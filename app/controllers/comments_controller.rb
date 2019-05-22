class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comments_params)
        redirect_to posts_path(@post.id) 
    end

    private
        def comments_params
            params.require(:comment).permit(:content).merge(user: current_user)
        end

end
