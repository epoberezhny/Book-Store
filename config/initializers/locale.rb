# # где библиотека I18n должна искать наши переводы
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

# Белый список локалей, доступных приложению
I18n.available_locales = [:en, :ru]