class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def empty
    cart_items = CartItem.where(:cart_id => self.id)
    return if cart_items.length <= 0 
    cart_items.each do | item |
      item.delete
    end

  end
end
