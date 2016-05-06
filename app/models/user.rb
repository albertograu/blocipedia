class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators

  enum role: [:standard, :premium, :admin]
  after_initialize :default_user_role, :if => :new_record?

  def default_user_role
    self.role ||= :standard
  end
end
