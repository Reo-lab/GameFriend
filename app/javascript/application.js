// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"
import 'bootstrap'

document.addEventListener('turbo:load', () => {
  const notificationsButton = document.querySelector('.bell_icon_box');
  fetch('/notifications/unread_count')
  .then(response => {
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    return response.json();
  })
  .then(data => {
    if (data.unread_count > 0) {
      notificationsButton.classList.add('has-new-notification');
    } else {
      notificationsButton.classList.remove('has-new-notification');
    }
  })
  .catch(error => {
    console.error('Error fetching unread count:', error);
  });
});

document.addEventListener('turbo:load', () => {
    const notificationsButton = document.querySelector('.bell_icon_box');
    const notificationsContent = document.getElementById('notificationsContent');
  
    notificationsButton.addEventListener('click', () => {
      fetch('/notifications') // 通知を取得するエンドポイントに変更
      .then(response => {
        // レスポンスが正常であることを確認
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        // レスポンスが空でないか確認
        return response.text().then(text => {
          if (text) {
            return JSON.parse(text);
          } else {
            throw new Error('Empty response');
          }
        });
      })
        .then(data => {
          notificationsContent.innerHTML = ''; // コンテンツをクリア
          data.notifications.forEach(notification => {
            const p = document.createElement('p');
            p.textContent = notification.message;
            if (notification.read) {
              p.className = 'notification-read'; // 既読通知のクラス
            } else {
              p.className = 'notification-unread'; // 未読通知のクラス
            }
            notificationsContent.appendChild(p);
        });
        if (notificationsButton) {
          notificationsButton.classList.remove('has-new-notification');
        }
      });
    });
  });

  document.addEventListener('turbo:load', () => {
    const notificationsModal = document.getElementById('notificationsModal');
  
    notificationsModal.addEventListener('hidden.bs.modal', () => {
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