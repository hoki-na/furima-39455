class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_item, only: [:index, :create]


  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new(order_address_params)

    if @item.sold_out? || (@item.user_id == current_user&.id)
      redirect_to root_path
    elsif current_user.nil?
      redirect_to login_path
    end
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      # 保存成功時の処理
      redirect_to root_path
    else
      # 保存失敗時の処理
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_item
    if current_user.nil?
      redirect_to login_path
    elsif item_belongs_to_current_user? && item_sold_out?
      # 処理を継続
    else
      redirect_to root_path
    end
  end

  def item_belongs_to_current_user?
    @item.user_id == current_user.id
  end

  def item_sold_out?
    @item.sold_out?
  end

  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipality, :address, :telephone_number, :building_name).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_address_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end