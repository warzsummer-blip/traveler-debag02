class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.new(comment_params)
        @comment.post_id = @post.id # ← post_id をセット！

        if @comment.save
            redirect_to post_path(@post)
        else
            # @post は一番上で取得済みなのでそのまま使えます
            @comments = @post.comments.page(params[:page]).per(7).reverse_order
            render 'posts/show', status: :unprocessable_entity
        end
    end
    
    def destroy
        # 自分のコメントかつ該当の投稿のものだけを探して削除
        comment = current_user.comments.find_by(id: params[:id], post_id: params[:post_id])
        comment&.destroy # 存在するときだけ削除実行（&. は nil ガード）

        redirect_to post_path(params[:post_id])
    end
    
    private

    def comment_params
        params.require(:comment).permit(:comment)
    end
end