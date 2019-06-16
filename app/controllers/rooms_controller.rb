class RoomsController < ApplicationController
  include RoomsHelper
  def new
  end

  def create
    opponent = get_opponent
    clear_errors
    if opponent == get_user
      flash[:errors] << "Congradulations, you played yourself"
      return render :new
    end
    if opponent.playing?
      flash[:errors] << "This opponent is currently playing with someone else"
      return render :new
    end
    concede_prev_games
    room = create_a_room
    redirect_to room_path(room)
  end

  def update
    room = get_room
    if !params[:game] || !params[:game][:boxes]
      if room.curr_player?(curr_user)
        add_error "You have to mark at least one box to make a turn"
      else
        add_error "It is not your turn yet"
      end
      return redirect_to room_path(room)
    end
    selections = params[:game][:boxes]
    if selections.keys.size > 1
      add_error "You cannot select more than one box"
    else
      game = room.tictactoe
      game.next_turn(selections)
      game.next_player unless game.over?
    end
    redirect_to room_path(room)
  end


  def show
    flash[:errors] ||= []
    @room = Room.find(params[:id])
    user = User.find_by(username: curr_user)
    if !(@room.host == user || @room.opponent == user)
      flash[:errors] << 'Your game was not found'
      return redirect_to home_path
    end
    @game = @room.tictactoe
    @your_turn = false if @game.status != "active"
    if @game.status == "draw"
      flash[:message] = "It is a draw"
    elsif @game.status == curr_player(@room).to_s
      flash[:message] = "You won!!!"
    elsif @game.status == "active"
      @your_turn = @room.curr_player?(curr_user)
    else
      flash[:message] = "You lost :("
    end
      @active = (@game.status == "active")
      render :"tictactoe/new", layout: "tictactoe"
  end

  def concede
    room = Room.find(params[:id])
    user = User.find_by(username: curr_user)
    winner = (room.host == user ? "1" : "0")
    room.tictactoe.update(status: winner)
    redirect_to room_path(room)
  end

  private
  def curr_player(room)
    room.player_num(curr_user)
  end


end
