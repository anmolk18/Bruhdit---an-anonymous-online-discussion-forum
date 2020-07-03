class Message < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :user
    validates_presence_of :body, :conversation_id, :user_id

    def message_time
     created_at.strftime("%m/%d/%y at %l:%M %p")
    end

    def chat_time
        
        time = self.created_at.in_time_zone('Eastern Time (US & Canada)')
        base_form = time.strftime("%l:%M %P    |    ")
        if self.created_at.to_date.today?
            base_form + "Today"
        elsif self.created_at.to_date.yesterday == DateTime.yesterday
            base_form + "Yesterday"
        else
            base_form + time.strftime("%b %-d")
        end
    end
end