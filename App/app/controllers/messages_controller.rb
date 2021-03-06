class MessagesController < ApplicationController
    before_action do
     @conversation = Conversation.find(params[:conversation_id])
    end
  layout 'base'
  def index
    @current_user = current_user
    @chats = @current_user.sorted_chats
    @chats.delete(@conversation)
    @messages = @conversation.messages
    @conversation.read_messages()
    if @messages.length > 10
     @over_ten = true
     @messages = @messages[-10..-1]
    end
    if params[:m]
     @over_ten = false
     @messages = @conversation.messages
    end
   if @messages.last
    if @messages.last.user_id != current_user.id
     @messages.last.read = true;
    end
   end
  @message = @conversation.messages.new
   end


  def new
   @message = @conversation.messages.new
  end
  
  def create
   @message = @conversation.messages.new(message_params)
   if @message.save
    redirect_to conversations_path(@conversation)
   end
  end



  private

   def message_params
    params.require(:message).permit(:body, :user_id)
   end
end