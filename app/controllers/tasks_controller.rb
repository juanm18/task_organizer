class TasksController < ApplicationController
  def index
    @tasks = Task.where("user_id = ?", session[:id])
    # render json: @tasks
  end

  def new
  end

  def create
    @task = Task.new({task:params[:task], due_date:params[:date], status:params[:status]})
    @task.user_id = session[:id]
    @task.save
    puts "*******"
    puts @task.errors.full_messages
    puts "*******"
    if @task.errors.any? == true
      flash[:create_error] = @task.errors.full_messages
      redirect_to '/tasks/new'
    else
      flash[:succes] = 'Succesfully created Task'
      redirect_to '/tasks'
    end
  end

  def task_params
    params.require(:task).permit(:task, :due_date)
  end

  def update
    @task = Task.find(params[:id])
    @task.status = params[:status]
    @task.save
    if @task.errors.any? == true
      puts "*******"
      puts  @task.errors.full_messages
      puts "*******"
      redirect_to '/tasks'
  else
    redirect_to '/tasks'
  end
  end

  def delete
    task = Task.find params[:id]
    task.delete
    redirect_to '/tasks'
  end
end
