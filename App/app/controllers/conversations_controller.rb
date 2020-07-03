class ConversationsController < ApplicationController
   layout 'base'
   def index
      @current_user = current_user
      @chats = @current_user.chats
      @message = Message.new
    end

    def show()
      @current_user = current_user
    end
    
   def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
       @conversation = Conversation.between(params[:sender_id],
       params[:recipient_id]).first
    else
     @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
   end
   
   private

    def conversation_params
     params.permit(:sender_id, :recipient_id)
    end
end