class RoomsController < ApplicationController
  include RoomsHelper
  def new
  end

  def index
    @user = get_user
    @rooms = @user.past_rooms
    render layout: "rooms"
  end

  def create
    opponent = get_opponent
    clear_errors
    if opponent == get_user
      add_error "Congradulations, you played yourself"
      return redirect_to new_room_path
    end
    if opponent.playing?
      add_error "This opponent is currently playing with someone else"
      return redirect_to new_room_path
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
      if room.opponent.ai
        selections = HardAi.new.move(game.boxes)
        game.next_turn(selections)
        game.next_player unless game.over?
      end
    end
    redirect_to room_path(room)
  end

  def history
    @room = get_room
    user = get_user
    if !(@room.host == user || @room.opponent == user)
      add_error 'Your game was not found'
      return redirect_to home_path
    end
    @game = @room.tictactoe
    @boxes = @game.game_at(params[:turn].to_i - 1)
    @your_turn = false
    @active = false
    render :"tictactoe/new", layout: "tictactoe"
  end


  def show
    @room = get_room
    user = get_user
    if !(@room.host == user || @room.opponent == user)
      add_error 'Your game was not found'
      return redirect_to home_path
    end
    @game = @room.tictactoe
    @boxes = @game.boxes
    @your_turn = false if @game.status != "active"
    if @game.status == "draw"
      add_message "It is a draw"
    elsif @game.status == curr_player(@room).to_s
      add_message "You won!!!"
    elsif @game.status == "active"
      @your_turn = @room.curr_player?(curr_user)
    else
      add_message "You lost :("
    end
      @active = (@game.status == "active")
      render :"tictactoe/new", layout: "tictactoe"
  end

  def concede
    room = get_room
    winner = (room.host == get_user ? "1" : "0")
    room.tictactoe.update(status: winner)
    redirect_to room_path(room)
  end

  private
  def curr_player(room)
    room.player_num(curr_user)
  end


end
