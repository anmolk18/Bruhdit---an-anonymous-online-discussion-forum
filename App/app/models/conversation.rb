class Conversation < ApplicationRecord
    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
    has_many :messages, dependent: :destroy
    
    validates_uniqueness_of :sender_id, :scope => :recipient_id

    scope :between, -> (sender_id,recipient_id) do
        where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
    end

    def other_user(current_user)
        self.recipient_id == current_user.id ? User.find(self.sender_id) : User.find(self.recipient_id)
    end

    def sorted_messages()
        self.messages.select{|message| message.id != nil}
    end

    def read_messages()
        self.messages.each do |message|
            message.update(read: true)
        end
    end

    def self.default_convo(new_user_id)
        bot = User.find_by(user_name: "Bruhdit_Bot")
        convo = self.create(sender_id: bot.id, recipient_id: new_user_id)
        Message.create(body: 'Hello, welcome to our website!', conversation_id: convo.id, user_id: bot.id)
    end

    def latest_convo_time
        self.messages
    end

    def message_timestamp
        self.messages.empty? ? self.created_at : self.messages.max_by(&:created_at).created_at
    end

end
  