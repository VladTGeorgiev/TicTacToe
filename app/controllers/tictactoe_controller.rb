class TictactoeController < ApplicationController
  def new
    @game = Tictactoe.new
  end
end
