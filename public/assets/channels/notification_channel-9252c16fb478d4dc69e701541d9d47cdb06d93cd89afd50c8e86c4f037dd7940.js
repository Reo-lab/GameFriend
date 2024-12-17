import consumer from "channels/consumer"

const notificationContainer = document.getElementById('notificationsContent')

document.addEventListener('turbo:load', () => {
  const notificationContainer = document.querySelector('.bell_icon_box');

  if (!consumer.subscriptions.subscriptions.find(sub => sub.identifier === JSON.stringify({ channel: "NotificationChannel" }))) {
  if (notificationContainer) {
    const subscription = consumer.subscriptions.create("NotificationChannel", {
      connected() {
        console.log("Connected to NotificationChannel");
      },
      received(data) {
        console.log("Received data:", data);
        // 通知アイコンのクラスを変更してスタイルを更新
        const notificationsButton = document.querySelector('.bell_icon_box');
        if (notificationsButton) {
          notificationsButton.classList.add('has-new-notification');
          notificationsButton.classList.add('bell-icon-shake');
        }
      },
      disconnected() {
        console.log("Disconnected from NotificationChannel");
      }
    });
  }
 }
});
