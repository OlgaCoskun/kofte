# Письма о событиях
class EventMailer < ApplicationMailer
  # Письмо о новой подписке для автора события
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  # Письмо о новом комментарии на заданный email
  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "Новый комментарий @ #{event.title}"
  end

  # Письмо о новой фотке в событии
  def photo(event, photo, email)
    @photo = photo
    @event = event

    mail to: email, subject: "Новая фотка @ #{event.title}"
  end
end