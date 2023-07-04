class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @item = Items.new
  end

  def create
    @item = Item.new(item_params)
  

    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.' 
    else render :new, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
    return unless current_user.id != @item.user_id

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user != @item.user
      redirect_to root_path
    else
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :description, :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :ship_date_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end



end
