import consumer from "channels/consumer";

document.addEventListener('turbo:load', () => {
  const chatroomIdElement = document.getElementById('chatroom-id');

  if (chatroomIdElement) {
    const chatroomId = chatroomIdElement.value;

    const chatChannel = consumer.subscriptions.create(
      { channel: "ChatChannel", chatroom_id: chatroomId },
      {
        connected() {
          console.log("Connected to chatroom " + chatroomId);
        },

        disconnected() {
          console.log("Disconnected from chatroom " + chatroomId);
        },

        received(data) {
          const messageHtml = `
            <div class="message">
              <div class="message-header">
                <div class="user-icon-box">
                  <img src="${data.message.user_icon}" class="user-icon-chat" />
                </div>
                <div class="message-info">
                  <strong>${data.message.user_name}</strong>
                </div>
              </div>
              <div class="message-content">
                ${data.message.content}
              </div>
              <div class="timestamp-box">
                <span class="timestamp">${data.message.timestamp}</span>
            </div>
            </div>
          `;

          const messagesContainer = document.querySelector('.messages');
          if (messagesContainer) {
            messagesContainer.insertAdjacentHTML('beforeend', messageHtml);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
          }
        },

        speak(message) {
          this.perform('speak', { message: message });
        }
      }
    );

    document.addEventListener('keypress', (event) => {
      const messageInput = event.target;
      if (messageInput.dataset.behavior === 'chat_speaker' && event.key === 'Enter' && !event.shiftKey) {
        event.preventDefault();
        const message = messageInput.value.trim();
        if (message) {
          chatChannel.speak(message);
          messageInput.value = '';
        }
      }
    });

    // ページ遷移時にチャットチャンネルを閉じる
    document.addEventListener('turbo:before-visit', () => {
      consumer.subscriptions.remove(chatChannel);
    });
  }
});