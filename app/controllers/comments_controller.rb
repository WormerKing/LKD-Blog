class CommentsController < ApplicationController
  before_action :select_post, only: %i[ edit update destroy]
  before_action :select_comment, only: %i[ edit update destroy ]

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = "Yorum başarıyla eklendi"
        format.turbo_stream
      # redirect_to post_path(@post), notice: "Comment created successfully"
      else
        render :new, status: :unprocessable_entity,alert: "Yorum eklenemedi!"
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post),notice: "Yorum başarıyla güncellendi"
    else
      render :edit,status: :unprocessable_entity,alert: "Yorum güncellenemedi"
    end
  end
  
  def destroy
    if @comment.destroy
      redirect_to post_path(@post), notice: "Yorum başarıyla silindi"
    else
      redirect_to post_path(@post), notice: "Yorum silinemedi"

    end
  end

  private
  def comment_params
    params.expect(comment: [:content])
  end

  def select_comment
    @comment = @post.comments.find(params[:id])
  end

  def select_post
    if Post.exists?(params[:post_id])
      @post = Post.find(params[:post_id])
    else
      redirect_to root_path
    end
  end
end
