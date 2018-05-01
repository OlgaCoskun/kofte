class Event < ApplicationRecord
  belongs_to :user

  # У события много комментариев и подписок
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  # У события много подписчиков (объекты User), через таблицу subscriptions,
  # по ключу user_id
  has_many :subscribers, through: :subscriptions, source: :user

  validates :user, presence: true

  validates :title, presence: true, length: {maximum: 255}

  validates :address, presence: true
  validates :datetime, presence: true
end
