class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
      
        @tasks = Task.all
        
      if logged_in?
        @task = current_user.tasks.build  # form_with 用
        #@tasks = current_user.tasks.order(id: :desc).page(params[:page])
      end
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end
 
    def create
        @task = current_user.tasks.build(task_params)

        if @task.save
            
            flash[:success] = 'task が正常に投稿されました'
            redirect_to @task
        else
            flash.now[:danger] = 'task が投稿されませんでした'
            render :new
            
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])

        if @task.update(task_params)
            flash[:success] = 'Task は正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Task は更新されませんでした'
            render :edit
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy

        flash[:success] = 'Task は正常に削除されました'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        
        @task = Task.find(params[:id])
    end
    
    def task_params
        
        params.require(:task).permit(:status,:content)
    end  
    
    
    
    
    #def ensure_correct_user
    #@task = Task.find_by(id:params[:id])
      #if @task.user_id != @current_user.id
        #flash[:notice] = "権限がありません"
        #redirect_to("/tasks/index")
      #end
    #end
end
