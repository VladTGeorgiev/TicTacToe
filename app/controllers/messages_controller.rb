class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(attr)
    if @message.valid?
      redirect_to message_path(@message)
    else
      flash[:errors] = @message.errors.full_messages
      render :new
    end
  end

  def attr
    params.require(:message).permit(:title, :text, :from_id, :to_id)
  end
end
