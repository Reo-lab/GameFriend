import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  const chatroomId = document.getElementById('chatroom-id').value;

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
                <span class="timestamp">${data.message.timestamp}</span>
              </div>
            </div>
            <div class="message-content">
              ${data.message.content}
            </div>
          </div>
        `;

        document.querySelector('.messages').insertAdjacentHTML('beforeend', messageHtml);
        document.querySelector('.messages').scrollTop = document.querySelector('.messages').scrollHeight;
      },

      speak(message) {
        this.perform('speak', { message: message });
      }
    }
  );

  document.addEventListener('keypress', (event) => {
    const messageInput = event.target;
    if (messageInput.dataset.behavior === 'chat_speaker' && event.keyCode === 13 && !event.shiftKey) {
      event.preventDefault();
      const message = messageInput.value.trim();
      if (message) {
        chatChannel.speak(message);
        messageInput.value = '';
      }
    }
  });
});