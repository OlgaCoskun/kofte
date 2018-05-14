class PhotosController < ApplicationController
  # Для каждого действия нужно получить событие, к которому привязана фотография
  before_action :set_event, only: [:create, :destroy]

  # Для действия destroy нужно получить из базы саму фотографию
  before_action :set_photo, only: [:destroy]

  # Действие для создания новой фотографии
  # Обратите внимание, что фотку может сейчас добавить даже неавторизованный пользовать
  def create
    # Создаем новую фотографию у нужного события @event
    @new_photo = @event.photos.build(photo_params)

    # Проставляем у фотографии пользователя
    @new_photo.user = current_user

    if @new_photo.save

      # уведомляем всех подписчиков о новой фотке
      notify_subscribers(@event, @new_photo)

      # Если фотографию удалось сохранить, редирект на событие с сообщением
      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      # Если фотографию не удалось сохранить, рендер события с ошибкой
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  # Действие для удаления фотографии
  def destroy
    message = {notice: I18n.t('controllers.photos.destroyed')}

    # Проверяем, может ли пользователь удалить фотографию
    # Если может — удаляем, нет, меняем сообщение
    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t('controllers.photos.error')}
    end

    # И в любом случае редиректим его на событие
    redirect_to @event, message
  end

  private

  # Так как фотография — вложенный ресурс, то в params[:event_id] рельсы
  # автоматически положает id события, которому принадлежит фотография
  # найденное событие будет лежать в переменной контроллера @event
  def set_event
    @event = Event.find(params[:event_id])
  end

  # Получаем фотографию из базы стандартным методом find
  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  # При создании новой фотографии мы получаем массив параметров photo
  # c единственным полем (оно тоже называется photo)
  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end

  def notify_subscribers(event, photo)
    # собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email]).uniq
    #all_emails.delete_if {|email| email == current_user.email}

    # XXX: Этот метод может выполняться долго из-за большого числа подписчиков
    # поэтому в реальных приложениях такие вещи надо выносить в background задачи!
    all_emails.each do |mail|
      EventMailer.photo(event, photo, mail).deliver_now
    end
  end
end
