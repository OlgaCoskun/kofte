# Модель Коммента
class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates  :event, presence: true
  validates :body, presence: true

  # поле должно быть, только если не выполняется user.present? (у объекта на задан юзер)
  validates :user_name, presence: true, unless: -> {user.present?} # new synt with rails 5.2


  # переопределяем метод, если есть юзер, выдаем его имя,
  # если нет -- дергаем исходный переопределенный метод
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
end
