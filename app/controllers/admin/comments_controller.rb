class Admin::CommentsController < AdminController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    def index
        @comments = Comment.all
        if params[:type] && params[:type] == 'unmoderated'
            @comments = Comment.unmoderated
        end
    end

    def show
    end

    def new
        @comment = Comment.new
    end

    def edit

    end

    def update
        if @comment.update(comment_params)
            redirect_to [:admin, @comment], notice: 'Комент успішно відредагований'
        else
            render :edit
        end
    end

    def destroy
        @comment.destroy
        redirect_to admin_comments_url, notice: 'Комент видалений'
    end
    
    def publish
        @comment = Comment.find(params[:id])
        @comment.user.update(comment_moderation: true)
        redirect_to admin_comments_path, notice: 'Коментарі користувача опубліковані'
    end

    private

    def set_comment
        @comment = Comment.friendly.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body, :image)
    end
end