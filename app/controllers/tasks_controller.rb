class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def new
    @board = Board.find(params[:board_id])
    @task = @board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
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
        redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: '更新できました'
    else
        flash.now[:error] = '更新できませんでした'
        render :edit
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    @task.destroy!
    redirect_to board_path(@board), notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :expiry, :user_id, :eyecatch)
    .merge(user_id: current_user.id)
  end
end
