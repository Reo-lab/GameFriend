// app/javascript/signaling_server.js

import consumer from "channels/consumer";

// Broadcast Types
const JOIN_ROOM = "JOIN_ROOM";
const EXCHANGE = "EXCHANGE";
const REMOVE_USER = "REMOVE_USER";

// DOM Elements
let currentUser;
let localVideo;
let remoteVideoContainer;
let pcPeers = {};
let localstream;
let videoDevices = [];
let audioDevices = [];

window.onload = () => {
  const chatroomElement = document.getElementById("room-id"); // チャットルームを特定するための要素を取得
  if (chatroomElement) {
  currentUser = document.getElementById("current-user").innerText;
  localVideo = document.getElementById("local-video");
  remoteVideoContainer = document.getElementById("remote-video-container");
 }
};

// Ice Credentials
const ice = { iceServers: [{ urls: "stun:stun.l.google.com:19302" }] };

// Add event listener's to buttons
document.addEventListener("turbo:load", async () => {
  const chatroomElement = document.getElementById("room-id"); // チャットルームを特定するための要素を取得
  if (chatroomElement) {
  currentUser = document.getElementById("current-user").innerHTML;
  localVideo = document.getElementById("local-video");
  remoteVideoContainer = document.getElementById("remote-video-container");

  const joinButton = document.getElementById("join-button");
  const leaveButton = document.getElementById("leave-button");

  joinButton.onclick = handleJoinSession;
  leaveButton.onclick = handleLeaveSession;

  // デバイスを取得して選択肢を作成
  await getMediaDevices();
  populateDeviceSelects();
 }
});

const getMediaDevices = async () => {
  const devices = await navigator.mediaDevices.enumerateDevices();
  videoDevices = devices.filter(device => device.kind === "videoinput");
  audioDevices = devices.filter(device => device.kind === "audioinput");
};

const populateDeviceSelects = () => {
  const videoSelect = document.getElementById("video-select");
  const audioSelect = document.getElementById("audio-select");
  
  // ビデオなしのオプションを追加
  const noVideoOption = document.createElement("option");
  noVideoOption.value = ""; // ビデオなしの場合の値
  noVideoOption.text = "ビデオなし"; // 表示名
  videoSelect.appendChild(noVideoOption);

  videoDevices.forEach(device => {
    const option = document.createElement("option");
    option.value = device.deviceId;
    option.text = device.label || `Camera ${videoSelect.length + 1}`;
    videoSelect.appendChild(option);
  });

  audioDevices.forEach(device => {
    const option = document.createElement("option");
    option.value = device.deviceId;
    option.text = device.label || `Microphone ${audioSelect.length + 1}`;
    audioSelect.appendChild(option);
  });
};

const handleJoinSession = async () => {
  const videoSelect = document.getElementById("video-select");
  const audioSelect = document.getElementById("audio-select");
  const userIconContainer = document.getElementById("user-icon-container"); // アイコンコンテナを取得
  const localVideo = document.getElementById("local-video");

  if (videoSelect.value === "") {
    // ビデオなしの場合、アイコンを表示
    userIconContainer.style.display = "block";
    localVideo.style.display = "none";
  } else {
    // ビデオがある場合、アイコンを非表示
    userIconContainer.style.display = "none";
  }

  const constraints = {
    video: videoSelect.value ? { deviceId: { exact: videoSelect.value } } : false, // ビデオなしの場合はfalseに
    audio: {
      deviceId: audioSelect.value ?  { deviceId: { exact: videoSelect.value } } : undefined,
      echoCancellation: false,
      noiseSuppression: true,
      sampleRate: 44100, // サンプルレートを指定
    },
  };

  try {
    // メディアデバイスの取得
    const stream = await navigator.mediaDevices.getUserMedia(constraints);
    localstream = stream;
    localVideo.srcObject = stream;
    localVideo.muted = true;
    console.log("Local video stream obtained");
  
    const chatroomIdElement = document.getElementById("room-id");
    const roomId = chatroomIdElement.value; 
    console.log("Attempting to join the session...");
    consumer.subscriptions.create(
      { channel: "SessionChannel", chatroom_id: roomId }, // chatroom_idを追加
      {
       connected: () => {
         console.log("Successfully connected to the session channel.");
         const dataToSend = {
           type: JOIN_ROOM,
           from: currentUser,
           chatroomId: roomId,
         };
         console.log("Broadcasting data:", dataToSend); // 送信するデータのログ
         console.log("Before broadcasting data");
         broadcastData(dataToSend);
         console.log(`${currentUser} has joined the room.`);
      },
      received: (data) => {
        console.log("received", data);
        if (data.from === currentUser) return;
        switch (data.type) {
        case JOIN_ROOM:
          return joinRoom(data);
        case EXCHANGE:
          if (data.to !== currentUser) return;
          return exchange(data);
        case REMOVE_USER:
          return removeUser(data);
        default:
          return;
        }
      },      disconnected: () => {
        console.error("Disconnected from the session channel."); // 切断時のエラーログ
      },
      rejected: () => {
      console.error("Failed to connect to the session channel."); // 接続失敗時のエラーログ
      }
    }
  );
  } catch (error) {
  console.error("Error accessing media devices.", error);
  alert("Error accessing local video and audio stream: " + error.message);
 }
};

const handleLeaveSession = () => {
  for (let user in pcPeers) {
    pcPeers[user].close();
  }
  pcPeers = {};

  remoteVideoContainer.innerHTML = "";

  broadcastData({
    type: REMOVE_USER,
    from: currentUser,
  });
};

const joinRoom = (data) => {
  createPC(data.from, true);
};

const removeUser = (data) => {
  console.log("removing user", data.from);
  let video = document.getElementById(`remoteVideoContainer+${data.from}`);
  video && video.remove();
  delete pcPeers[data.from];
};

const createPC = (userId, isOffer) => {
  let pc = new RTCPeerConnection(ice);
  pcPeers[userId] = { pc, userId }; // PCとユーザーIDを保存

  for (const track of localstream.getTracks()) {
    pc.addTrack(track, localstream);
  }

  isOffer &&
    pc
      .createOffer()
      .then((offer) => {
        return pc.setLocalDescription(offer);
      })
      .then(() => {
        broadcastData({
          type: EXCHANGE,
          from: currentUser,
          to: userId,
          sdp: JSON.stringify(pc.localDescription),
        });
      })
      .catch(logError);

  pc.onicecandidate = (event) => {
    event.candidate &&
      broadcastData({
        type: EXCHANGE,
        from: currentUser,
        to: userId,
        candidate: JSON.stringify(event.candidate),
      });
  };

  pc.ontrack = async (event) => {
    const stream = event.streams[0]; // 受信したストリームを取得
    const videoTracks = stream.getVideoTracks(); // ビデオトラックを取得
    const audioTracks = stream.getAudioTracks(); // オーディオトラックを取得
    console.log("videoTracks:", videoTracks); 
    let existingVideo = document.getElementById(`remoteVideoContainer+${userId}`);
    let remoteUserIconContainer = document.getElementById("remote-user-icon-container");

    const remoteUserId = pcPeers[userId].userId;
    console.log("Remote User ID:", remoteUserId); 
    // アイコンを表示する関数
    const showremoteUserIcon = async () => {
      
      try {
        const remoteUser = await fetch(`/users/${remoteUserId}/icon`) // ユーザーアイコン情報を取得
          .then(response => response.json());
      
        if (remoteUserIconContainer) {
          remoteUserIconContainer.style.display = "block"; // アイコンを表示
          const remoteUserIcon = document.createElement("img");
          remoteUserIcon.src = remoteUser.url; // APIから返されるURLを使ってアイコンを設定
          remoteUserIcon.alt = "User Icon";
          remoteUserIcon.classList.add("user-icon-voice-chat");
          remoteUserIconContainer.appendChild(remoteUserIcon); // アイコンをコンテナに追加
        }
      } catch (error) {
        console.error("Error fetching user icon:", error);
      }
    };
  
    if (videoTracks.length === 0 || !videoTracks[0].enabled) {
      // ビデオトラックがない場合はアイコンを表示
        showremoteUserIcon();
        if (existingVideo) {
          existingVideo.style.display = "none"; // 既存のビデオ要素を非表示
        }
        if (remoteUserIconContainer) {
            remoteUserIconContainer.style.display = "block"; // アイコンを表示
        }
    } else {
      // ビデオトラックがある場合
      if (!existingVideo) {
        const element = document.createElement("video");
        element.id = `remoteVideoContainer+${userId}`;
        element.autoplay = true;
        element.srcObject = stream;
        element.classList.add('remote-video');
        remoteVideoContainer.appendChild(element);
        console.log("Remote video element created and added.");
        
        // アイコンを非表示に
        if (remoteUserIconContainer) {
          remoteUserIconContainer.style.display = "none";
        }
      } else {
        // 既存の要素がある場合はストリームを再設定
        existingVideo.srcObject = stream;
        existingVideo.style.display = "block"; // ビデオを表示
        console.log("Existing video element updated.");
        
        // アイコンを非表示に
        if (remoteUserIconContainer) {
          remoteUserIconContainer.style.display = "none";
        }
      }
    }
    if (audioTracks.length > 0) {
      const audioElement = document.createElement("audio");
      audioElement.srcObject = stream;
      audioElement.autoplay = true; // 自動再生
      document.body.appendChild(audioElement); // DOMに追加
      console.log("Audio element created and added.");
    }
  };

  pc.oniceconnectionstatechange = () => {
    if (pc.iceConnectionState == "disconnected") {
      console.log("Disconnected:", userId);
      broadcastData({
        type: REMOVE_USER,
        from: userId,
      });
    }
  };

  return pc;
};

const exchange = (data) => {
  let pc;

  if (!pcPeers[data.from]) {
    pc = createPC(data.from, false);
  } else {
    pc = pcPeers[data.from].pc;// pcを取得
  }

  if (data.candidate) {
    pc.addIceCandidate(new RTCIceCandidate(JSON.parse(data.candidate)))
      .then(() => console.log("Ice candidate added"))
      .catch(logError);
  }

  if (data.sdp) {
    const sdp = JSON.parse(data.sdp);
    pc.setRemoteDescription(new RTCSessionDescription(sdp))
      .then(() => {
        if (sdp.type === "offer") {
          pc.createAnswer()
            .then((answer) => {
              return pc.setLocalDescription(answer);
            })
            .then(() => {
              broadcastData({
                type: EXCHANGE,
                from: currentUser,
                to: data.from,
                sdp: JSON.stringify(pc.localDescription),
              });
            });
        }
      })
      .catch(logError);
  }
};

const broadcastData = (data) => {
  /**
   * Add CSRF protection: https://stackoverflow.com/questions/8503447/rails-how-to-add-csrf-protection-to-forms-created-in-javascript
   */
  const csrfToken = document.querySelector("[name=csrf-token]").content;
  const headers = new Headers({
    "content-type": "application/json",
    "X-CSRF-TOKEN": csrfToken,
  });
  // roomIdをデータに含める
  data.chatroomId = document.getElementById("room-id").value;

  fetch("/sessions", {
    method: "POST",
    body: JSON.stringify(data),
    headers,
  })
  .then(response => {
    console.log("Response status:", response.status); // ステータスコードをログ出力
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return response.text(); // サーバーからのレスポンスをJSONとして解析
  })
  .then(text => {
    console.log("Raw response text:", text); // レスポンスをテキストとしてログに出力
    if (text.trim() === "") { // 空のレスポンスをチェック
      throw new Error("相手が参加すると通話が開始されます");
    }
    try {
        const jsonResponse = JSON.parse(text); // 必要に応じてパース
        console.log("Parsed JSON:", jsonResponse);
    } catch (parseError) {
        console.error("Error parsing JSON:", parseError);
        console.log("Received raw data during parsing:", text);
    }
  })
  .catch(error => {
    console.error("Error broadcasting data:", error);
  });
};

const logError = (error) => console.warn("Whoops! Error:", error);