class TictactoeController < ApplicationController
  def new
    @game = Tictactoe.new
  end
  def info
    render layout: "application"
  end
end
