class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { visitor: 0, editor: 1, receiver: 2, receiver_editor: 3, admin: 4, super_admin: 5 }
end
