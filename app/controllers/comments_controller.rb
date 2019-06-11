class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comments_params)
        respond_to do |format|
            if @comment.save
                format.html { redirect_to post_path(@post) }
                format.js
            else
                format.html {redirect_to post_path(@post), notice: 'Relply did not save. Please try again.' }
                format.js
            end
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
    end

    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.update(comments_params)
        redirect_to post_path(@post)
    end
    
    

    private
        def comments_params
            params.require(:comment).permit(:content).merge(user: current_user)
        end
end
