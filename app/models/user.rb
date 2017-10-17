class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 3 }, presence: true
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, pw)
    
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(pw)
      user
    else
      nil
    end
  end
end

    # user = User.find_by_email(params[:email])
    # if user && user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   redirect_to '/'
    # else
    #   redirect_to '/login'
    # end
