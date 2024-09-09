// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"
import 'bootstrap'


document.addEventListener('DOMContentLoaded', () => {
    const notificationsButton = document.querySelector('.bell_icon_box a');
    const notificationsContent = document.getElementById('notificationsContent');
  
    notificationsButton.addEventListener('click', () => {
      fetch('/notifications') // 通知を取得するエンドポイントに変更
        .then(response => response.json())
        .then(data => {
          notificationsContent.innerHTML = ''; // コンテンツをクリア
          data.notifications.forEach(notification => {
            const p = document.createElement('p');
            p.textContent = notification.message;
            notificationsContent.appendChild(p);
          });
        });
    });
  });

  document.addEventListener('DOMContentLoaded', () => {
    const notificationsModal = document.getElementById('notificationsModal');
  
    notificationsModal.addEventListener('shown.bs.modal', () => {
      fetch('/notifications/mark_all_as_read', {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })
      .then(response => {
        if (response.ok) {
          console.log('通知が既読に設定されました');
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });