class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    @comments = @task.comments.all
  end

  def new
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: 'Successfully done'
    else
      flash.now[:error] = 'Unfortunately failed'
      render :new
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def update
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
        redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: 'Succesfully updated'
    else
        flash.now[:error] = 'Unfortunately failed'
        render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: 'Deleted'
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :expiry, :eyecatch)
    .merge(user_id: current_user.id)
  end
end
