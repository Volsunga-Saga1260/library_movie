class Public::PostCommentsController < Public::ApplicationController

  def create
    movie = Movie.find(params[:movie_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.movie_id = movie.id
    comment.save
    redirect_to movie_path(movie.id), flash: {success: "コメント投稿に成功しました"}
  end

  def destroy
    PostComment.find_by(id: params[:id], movie_id: params[:movie_id]).destroy
    redirect_to movie_path(params[:movie_id]), flash: {error: "コメントを削除しました"}
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
