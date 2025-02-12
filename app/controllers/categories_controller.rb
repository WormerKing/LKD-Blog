class CategoriesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :find_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new 
  end

  def destroy
  end

    
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path,notice: "Kategori başarıyla oluşturuldu"
    else
      # redirect_to new_category_path, alert: "Category not created."
      render :new,status: :unprocessable_entity,alert: "Kategori validasyonu başarız"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def find_category
    if Category.find_by(title: params[:id])
      @category = Category.find_by(title: params[:id])
    else
      redirect_to categories_path, alert: "Category not found."
    end
  end

  def category_params
    params.expect(category: [:title])
  end
end
