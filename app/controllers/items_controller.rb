class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :destroy]
  before_action :set_item, only: [:show]
  before_action :user_check, only: [:show]

  def new
    @item = Item.new
  end

  def show
    @user = @item.user
    
    if user_signed_in? && user_check
      @editable = true
    end
  end
  

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.all.order('created_at DESC')
  end

  def edit
    if current_user != @item.user || @item.sold_out?
      redirect_to root_path and return
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
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

  def set_item
    @item = Item.find(params[:id])
  end

  def user_check
    current_user == @item.user
  end

  def item_params
    params.require(:item).permit(:item_name, :price, :description, :category_id, :condition_id, :delivery_charge_id,
                                 :prefecture_id, :ship_date_id, :image).merge(user_id: current_user.id)
  end

end
