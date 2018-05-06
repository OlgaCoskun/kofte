class Photo < ApplicationRecord
  # Фотография оставлена к какому-то события
  belongs_to :event

  # Фотографию добавил какой-то пользователь
  belongs_to :user

  # У фотографии всегда есть событие и пользователь
  validates :event, presence: true
  validates :user, presence: true

  # Добавляем аплоадер фотографий, чтобы заработал carrierwave
  mount_uploader :photo, PhotoUploader

  # Этот scope нужен нам, чтобы отделить реальные фотки от болваной
  # см. events_controller
  scope :persisted, -> { where "id IS NOT NULL" }
end
