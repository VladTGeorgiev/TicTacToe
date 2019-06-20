class MessagesController < ApplicationController
  include ApplicationHelper
  def home
    @user = get_user
    options1 = {to: @user}
    options2 = {from: @user}
    if session[:from]
      @from = User.find(session[:from])
      options1[:from] = @from
      options2[:to] = @from
    end
    @messages = Message.where(options1).or(Message.where(options2)).reject(&:title).reverse
    @conversations = Message.where(to: @user).map(&:from)
    @conversations += Message.where(from: @user).map(&:to)
    @conversations.uniq!
    @others = User.all - @conversations
  end

  def new
  end

  def add
    flash[:add_conversation] = true
    redirect_to messages_path
  end

  def connect
    Message.create(from: get_user, to_id: params[:to_id], title: "connection")
    redirect_to messages_path
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

  def show
    from = User.find(params[:id])
    session[:from] = from.id
    redirect_to messages_path
  end

  private
  def attr
    params.require(:message).permit(:title, :text, :from_id, :to_id)
  end
end
