class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include Cloudinary::CarrierWave

  # Если мы работаем в локальной версии нашего приложения,
  # аватарки хранятся прямо в файловой системе, иначе используем fog
  # для загрузки их на Cloudinary
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # Папка, в которой будут храниться все наши загруженные файлы
  # например, uploas/avatar/avatat/1
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # Аватарку, загруженную пользователем, надо обрезать/уменьшить
  # так, чтобы получился квадрат 400x400
  process resize_to_fill: [400, 400]

  # А потом нужно сделать миниатюрную версию 100x100
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Мы разрешаем для загрузки только файлы с расширением картинок
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
