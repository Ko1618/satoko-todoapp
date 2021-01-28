class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  before_action :authenticate_user!

  def index
    @boards = Board.all.order(updated_at: :desc)
  end

  def show
    @tasks = @board.tasks.all.order(updated_at: :desc)
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
        redirect_to root_path, notice: 'Successfully done'
    else
        flash.now[:error] = 'Unfortunately failed'
        render :new
    end
  end

  def edit
      @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
        redirect_to root_path, notice: 'Succesfully updated'
    else
        flash.now[:error] = 'Unfortunately failed'
        render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: 'Deleted'
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
