class Notification < ApplicationRecord
  belongs_to :user
  validates :message, presence: true
  after_create_commit :broadcast_notification

  # スコープで未読通知を取得
  scope :unread, -> { where(read: false) }

  # スコープで既読通知を取得
  scope :read, -> { where(read: true) }


  private

  def broadcast_notification
    ActionCable.server.broadcast(
      "notifications_#{user.id}",
      { message: message }
    )
  end
end