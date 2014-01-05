class User < ActiveRecord::Base

  has_secure_password

  has_many :sites, :dependent=>:destroy

  validates :password, presence: true, confirmation: true, on: :create
  validates :name, uniqueness: true, format: /[a-z0-9]+/
  validates :email, uniqueness: true, presence: true

  def to_param() name end

  def self.authenticate(name, password)
    user = find_by_name(name)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def send_password_reset
    begin
      self.password_reset_token = SecureRandom.urlsafe_base64
    end while User.exists?(:password_reset_token => password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end
