class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :select_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Current.user.posts.new(post_params)

    @post.category = Category.find(params.expect(post: [:category])["category"])

    if @post.save
      redirect_to posts_path,notice: "Yazı başarıyla eklendi"
    else
      @categories = Category.all
      
      render :new,status: :unprocessable_entity,alert: "Kayıt başarısız"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path,notice: "Yazı başarıyla güncellendi"
    else
      redirect_to edit_post_path(@post),alert: "Yazı güncellemede hata meydana geldi"
    end
  end
  
  def destroy
    if @post.destroy
      redirect_to posts_path,notice: "Yazı başarıyla silindi"
    else
      redirect_to posts_path,alert: "Yazı silinemedi"
    end
  end



  private
  def post_params
    params.expect(post: [:title,:content,:status])
  end

  def select_post
    if Post.find_by(id: params[:id])
      @post = Post.find(params[:id])
    else
      redirect_to posts_path, notice: "Post not found"
    end
  end
end
