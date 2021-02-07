class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image
  # 画像かテキストどちらかが存在していれば、メッセージを送信できるようにバリデーションを変更
  validates :content, presence: true, unless: :was_attached?
  # テキストがなければこのメソッドへ
  def was_attached?
    image.attached?
  end
end
