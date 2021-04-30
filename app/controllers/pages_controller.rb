require 'checkout/checkout.rb'

# controller for our pages

class PagesController < ApplicationController
    def home
        # get user - Using a default user with ID 1
        @user = User.find(1)
        # get User Cart
        @cart = Cart.find_by(:id => 1)

        #create userCart if it doesn't exist
        if !@cart
            @cart = @user.build_cart()
            @cart.save
        end
        # get User CartItems
        @cart ? @cartItems = CartItem.where(:cart_id => @cart.id) : @cartItems = nil
        # get all items to be shown on the homepage
       @items = Item.all 

       
    end

    # controller to check user out
    def checkout
        # get all items in cart
        items = CartItem.where(:cart_id => params[:cart_id])
        pricing_rules = ["3_FOR_2", "3_OR_MORE_TSHIRTS"]
        co = PB::Checkout.new(pricing_rules)
        #debugger
        #total = 100
        items.each do | item |
            code = Item.find(item[:item_id])[:code]
            co.scan(code)
        end
       # debugger
        @total = co.total()
    end
end