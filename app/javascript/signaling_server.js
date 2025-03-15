// app/javascript/signaling_server.ts
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import consumer from "channels/consumer";
// Broadcast Types
const JOIN_ROOM = "JOIN_ROOM";
const EXCHANGE = "EXCHANGE";
const REMOVE_USER = "REMOVE_USER";
// DOM Elements
let currentUser;
let localVideo;
let remoteVideoContainer = null;
let localstream = null;
let videoDevices = [];
let audioDevices = [];
let pcPeers = {};
window.onload = () => {
    const chatroomElement = document.getElementById("room-id"); // チャットルームを特定
    if (chatroomElement) {
        currentUser = document.getElementById("current-user").innerText;
        localVideo = document.getElementById("local-video");
        remoteVideoContainer = document.getElementById("remote-video-container");
    }
};
// Ice Credentials
const ice = {
    iceServers: [{ urls: "stun:stun.l.google.com:19302" }],
};
document.addEventListener("turbo:load", () => {
    const startButton = document.getElementById("startButton");
    if (startButton) {
        startButton.addEventListener("click", () => {
            navigator.mediaDevices.getUserMedia({ video: true, audio: true })
                .then((stream) => {
                // ストリームを取得した後、ページをリロード
                window.location.href = window.location.href;
            })
                .catch((error) => {
                console.error("カメラまたはマイクへのアクセスが拒否されました。", error);
                alert("カメラまたはマイクへのアクセスが必要です。");
            });
        });
    }
});
document.addEventListener("turbo:load", () => __awaiter(void 0, void 0, void 0, function* () {
    const chatroomElement = document.getElementById("room-id");
    if (chatroomElement) {
        currentUser = document.getElementById("current-user").innerText;
        localVideo = document.getElementById("local-video");
        remoteVideoContainer = document.getElementById("remote-video-container");
        const joinButton = document.getElementById("join-button");
        const leaveButton = document.getElementById("leave-button");
        joinButton.onclick = handleJoinSession;
        leaveButton.onclick = handleLeaveSession;
        // デバイスを取得して選択肢を作成
        yield getMediaDevices();
        populateDeviceSelects();
    }
}));
const getMediaDevices = () => __awaiter(void 0, void 0, void 0, function* () {
    const devices = yield navigator.mediaDevices.enumerateDevices();
    videoDevices = devices.filter(device => device.kind === "videoinput");
    audioDevices = devices.filter(device => device.kind === "audioinput");
});
const populateDeviceSelects = () => {
    const videoSelect = document.getElementById("video-select");
    const audioSelect = document.getElementById("audio-select");
    // ビデオなしオプション追加
    const noVideoOption = document.createElement("option");
    noVideoOption.value = "";
    noVideoOption.text = "ビデオなし";
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
const handleJoinSession = () => __awaiter(void 0, void 0, void 0, function* () {
    const videoSelect = document.getElementById("video-select");
    const audioSelect = document.getElementById("audio-select");
    const userIconContainer = document.getElementById("user-icon-container"); // アイコン
    const localVideo = document.getElementById("local-video");
    if (videoSelect.value === "") {
        // ビデオ無しで、アイコン表示
        userIconContainer.style.display = "block";
        localVideo.style.display = "none";
    }
    else {
        // ビデオ有りで、アイコン非表示
        userIconContainer.style.display = "none";
    }
    const constraints = {
        video: videoSelect.value ? { deviceId: { exact: videoSelect.value } } : false, // ビデオなしの場合はfalse
        audio: {
            deviceId: audioSelect.value ? audioSelect.value : undefined,
            echoCancellation: false,
            noiseSuppression: true, // trueで良い音質になった
            sampleRate: 44100,
        },
    };
    try {
        // メディアデバイスの取得
        const stream = yield navigator.mediaDevices.getUserMedia(constraints);
        localstream = stream;
        localVideo.srcObject = stream;
        localVideo.muted = true;
        console.log("Local video stream obtained");
        const chatroomIdElement = document.getElementById("room-id");
        const roomId = chatroomIdElement.value;
        console.log("Attempting to join the session...");
        consumer.subscriptions.create({ channel: "SessionChannel", chatroom_id: roomId }, // chatroom_idを追加
        {
            connected: () => {
                console.log("Successfully connected to the session channel.");
                const dataToSend = {
                    type: JOIN_ROOM,
                    from: currentUser,
                    chatroomId: roomId,
                };
                console.log("Broadcasting data:", dataToSend);
                console.log("Before broadcasting data");
                broadcastData(dataToSend);
                console.log(`${currentUser} has joined the room.`);
            },
            received: (data) => {
                console.log("received", data);
                if (data.from === currentUser)
                    return;
                switch (data.type) {
                    case JOIN_ROOM:
                        return joinRoom(data);
                    case EXCHANGE:
                        if (data.to !== currentUser)
                            return;
                        return exchange(data);
                    case REMOVE_USER:
                        return removeUser(data);
                    default:
                        return;
                }
            }, disconnected: () => {
                console.error("Disconnected from the session channel.");
            },
            rejected: () => {
                console.error("Failed to connect to the session channel.");
            }
        });
    }
    catch (error) {
        if (error instanceof Error) {
            console.error("Error accessing media devices.", error);
            alert("Error accessing local video and audio stream: " + error.message);
        }
        else {
            console.error("Unknown error:", error);
            alert("An unknown error occurred while accessing the local video and audio stream.");
        }
    }
});
const handleLeaveSession = () => __awaiter(void 0, void 0, void 0, function* () {
    for (let user in pcPeers) {
        pcPeers[user].pc.close();
    }
    pcPeers = {};
    if (remoteVideoContainer) {
        remoteVideoContainer.innerHTML = "";
    }
    broadcastData({
        type: REMOVE_USER,
        from: currentUser,
    });
});
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
    if (localstream) {
        for (const track of localstream.getTracks()) {
            pc.addTrack(track, localstream);
        }
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
        if (event.candidate) {
            broadcastData({
                type: EXCHANGE,
                from: currentUser,
                to: userId,
                candidate: JSON.stringify(event.candidate),
            });
        }
    };
    pc.ontrack = (event) => __awaiter(void 0, void 0, void 0, function* () {
        const stream = event.streams[0];
        const videoTracks = stream.getVideoTracks();
        const audioTracks = stream.getAudioTracks();
        console.log("videoTracks:", videoTracks);
        let existingVideo = document.getElementById(`remoteVideoContainer+${userId}`);
        let remoteUserIconContainer = document.getElementById("remote-user-icon-container");
        const remoteUserId = pcPeers[userId].userId;
        console.log("Remote User ID:", remoteUserId);
        const showremoteUserIcon = () => __awaiter(void 0, void 0, void 0, function* () {
            try {
                const remoteUser = yield fetch(`/users/${remoteUserId}/icon`)
                    .then(response => response.json());
                if (remoteUserIconContainer) {
                    remoteUserIconContainer.style.display = "block";
                    const remoteUserIcon = document.createElement("img");
                    remoteUserIcon.src = remoteUser.url;
                    remoteUserIcon.alt = "User Icon";
                    remoteUserIcon.classList.add("user-icon-voice-chat");
                    remoteUserIconContainer.appendChild(remoteUserIcon);
                }
            }
            catch (error) {
                console.error("Error fetching user icon:", error);
            }
        });
        if (videoTracks.length === 0 || !videoTracks[0].enabled) {
            // ビデオトラックがない場合はアイコンを表示
            showremoteUserIcon();
            if (existingVideo) {
                existingVideo.style.display = "none"; // 既存のビデオ要素を非表示
            }
            if (remoteUserIconContainer) {
                remoteUserIconContainer.style.display = "block"; // アイコンを表示
            }
        }
        else {
            if (!existingVideo) {
                const element = document.createElement("video");
                element.id = `remoteVideoContainer+${userId}`;
                element.autoplay = true;
                element.muted = true;
                element.srcObject = stream;
                element.classList.add('remote-video');
                if (remoteVideoContainer) {
                    remoteVideoContainer.appendChild(element);
                }
                console.log("Remote video element created and added.");
                if (remoteUserIconContainer) {
                    remoteUserIconContainer.style.display = "none";
                }
            }
            else {
                // 既存の要素がある場合はストリームを再設定
                existingVideo.srcObject = stream;
                existingVideo.style.display = "block"; // ビデオを表示
                console.log("Existing video element updated.");
                if (remoteUserIconContainer) {
                    remoteUserIconContainer.style.display = "none";
                }
            }
        }
        if (audioTracks.length > 0) {
            const audioElement = document.createElement("audio");
            audioElement.srcObject = stream;
            audioElement.autoplay = true;
            document.body.appendChild(audioElement);
            console.log("Audio element created and added.");
        }
    });
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
    }
    else {
        pc = pcPeers[data.from].pc; // pcを取得
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
    var _a;
    /**
     * Add CSRF protection: https://stackoverflow.com/questions/8503447/rails-how-to-add-csrf-protection-to-forms-created-in-javascript
     */
    const csrfToken = ((_a = document.querySelector("[name=csrf-token]")) === null || _a === void 0 ? void 0 : _a.content) || '';
    const headers = new Headers({
        "content-type": "application/json",
        "X-CSRF-TOKEN": csrfToken,
    });
    // roomIdをデータに含める
    const roomIdElement = document.getElementById("room-id");
    if (roomIdElement) {
        data.chatroomId = roomIdElement.value;
    }
    else {
        console.error("Room ID element not found");
        return;
    }
    fetch("/sessions", {
        method: "POST",
        body: JSON.stringify(data),
        headers,
    })
        .then(response => {
        console.log("Response status:", response.status);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.text();
    })
        .then(text => {
        console.log("Raw response text:", text);
        if (text.trim() === "") {
            throw new Error("相手が参加すると通話が開始されます");
        }
        try {
            const jsonResponse = JSON.parse(text);
            console.log("Parsed JSON:", jsonResponse);
        }
        catch (parseError) {
            console.error("Error parsing JSON:", parseError);
            console.log("Received raw data during parsing:", text);
        }
    })
        .catch(error => {
        console.error("Error broadcasting data:", error);
    });
};
const logError = (error) => console.warn("Whoops! Error:", error);
