class User < ApplicationRecord
    attr_accessor :confirm_password

    validates :username, presence: true
    validates :password, presence: true
end
