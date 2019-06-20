class MessagesController < ApplicationController
  include ApplicationHelper
  def home
    @user = get_user
    @messages = Message.where(to: @user)
  end

  def new
  end

  def create
    @message = Message.create(attr)
    if @message.valid?
      add_message "Your message was successfuly sent"
      redirect_to messages_path
    else
      add_error @message.errors.full_messages
      redirect_to messages_path
    end
  end

  private
  def attr
    params.require(:message).permit(:title, :text, :from_id, :to_id)
  end
end
