import consumer from "channels/consumer"

const notificationContainer = document.getElementById('notificationsContent')

if (notificationContainer) {
  const subscription = consumer.subscriptions.create("NotificationsChannel", {
    connected() {
      console.log("Connected to NotificationsChannel")
    },
    received(data) {
      console.log("Received data:", data)
      const notification = document.createElement('div')
      notification.className = 'notification notification-unread'
      notification.innerHTML = `<p>${data.message}</p>`
      
      notificationContainer.appendChild(notification)
      
      const notificationsModal = new bootstrap.Modal(document.getElementById('notificationsModal'))
      if (!notificationsModal._isShown) {
        notificationsModal.show()
      }
    },
    disconnected() {
      console.log("Disconnected from NotificationsChannel")
    }
  })
}
