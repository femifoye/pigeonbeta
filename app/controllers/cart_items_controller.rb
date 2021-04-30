class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update destroy ]

  def create
    @cart_item = CartItem.new(cart_item_params)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to root_path, notice: "Cart item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.permit(:item_id, :cart_id)
    end
end
