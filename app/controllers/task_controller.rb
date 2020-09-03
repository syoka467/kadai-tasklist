class TaskController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end
 
    def create
        @task = Task.new(task_params)

        if @task.save
            
            flash[:success] = 'task が正常に投稿されました'
            redirect_to @message
        else
            flash.now[:danger] = 'task が投稿されませんでした'
            render :new
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @message = Message.find(params[:id])

        if @message.update(message_params)
            flash[:success] = 'Message は正常に更新されました'
            redirect_to @message
        else
            flash.now[:danger] = 'Message は更新されませんでした'
            render :edit
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy

        flash[:success] = 'Message は正常に削除されました'
        redirect_to messages_url
    end
    
    def task_params
    params.require(:task).permit(:content)
    end 
end
