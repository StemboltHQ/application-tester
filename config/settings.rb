class Settings
  attr_reader :mailer

  def initialize (yaml_file_path)
    @mailer = Settings::Mailer.new

    settings_hash = YAML.load_file(yaml_file_path)
    settings_hash.each do |setting, settings_value|
      sub_settings = self.send(setting)

      settings_value.each do |key, value|
        sub_settings.send("#{key}=", value)
      end
    end
  end

  class Mailer
    attr_accessor :smtp, :smtp_port, :from_name, :from_email, :domain, :username, :password
  end
end

settings = Settings.new("config/settings.yaml")
Mail.defaults do
  delivery_method :smtp,
    address: settings.mailer.smtp,
    port: settings.mailer.smtp_port,
    domain: settings.mailer.domain,
    user_name: settings.mailer.username,
    password: settings.mailer.password,
    authentication: 'plain',
    enable_starttls_auto: true
end
