class Book < ApplicationRecord

    def user
        return User.find(self.user_id)
    end

    validates :title, presence: true
    validates :body, presence: true, length: {maximum: 200}
    
    belongs_to :user
    
end
