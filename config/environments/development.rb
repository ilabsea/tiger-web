Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Change mail delvery to either :smtp, :sendmail, :file, :test
  config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true

  smtp_settings = {}.tap do |settings|
    settings[:address]              = ENV['SETTINGS__SMTP__ADDRESS'] if ENV['SETTINGS__SMTP__ADDRESS'].present?
    settings[:port]                 = ENV['SETTINGS__SMTP__PORT'] if ENV['SETTINGS__SMTP__PORT'].present?
    settings[:domain]               = ENV['SETTINGS__SMTP__DOMAIN'] if ENV['SETTINGS__SMTP__DOMAIN'].present?
    settings[:user_name]            = ENV['SETTINGS__SMTP__USER_NAME'] if ENV['SETTINGS__SMTP__USER_NAME'].present?
    settings[:password]             = ENV['SETTINGS__SMTP__PASSWORD'] if ENV['SETTINGS__SMTP__PASSWORD'].present?
    settings[:authentication]       = ENV['SETTINGS__SMTP__AUTHENTICATION'] if ENV['SETTINGS__SMTP__AUTHENTICATION'].present?
    settings[:enable_starttls_auto] = ENV['SETTINGS__SMTP__ENABLE__STARTTLS__AUTO'] if ENV['SETTINGS__SMTP__ENABLE__STARTTLS__AUTO'].present?
  end

  config.action_mailer.smtp_settings = smtp_settings

  config.action_mailer.default_url_options = { host: ENV.fetch('HOST') { 'localhost:3000' } }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true
  config.asset_host = ENV['HOST']

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
