class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :events

  # Юзер может создавать много событий
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}
  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end

end
