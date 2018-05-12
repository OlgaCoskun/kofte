# Письма о событиях
class EventMailer < ApplicationMailer
  # Письмо о новой подписке для автора события
  def subscription
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Письмо о новом комментарии на заданный email
  def comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
