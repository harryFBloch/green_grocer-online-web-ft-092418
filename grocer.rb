def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each { |item_info |
    item_info.each {|item, item_hash|
    puts item_hash
    
    if !new_hash.has_key?(item)
      new_hash[item.to_s] = {:price => item_hash[:price], :clearance => item_hash[:clearance], :count => 1}
    else
      new_hash[item][:count] += 1 
    end
    }
  }
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon_name = coupon[:item]
    coupon_item_num = coupon[:num]
    cart_item = cart[coupon_name]
     next if cart_item.nil? || cart_item[:count] < coupon_item_num
     cart_item[:count] -= coupon_item_num
     coupon_in_cart = cart["#{coupon_name} W/COUPON"]
     if coupon_in_cart
      coupon_in_cart[:count] += 1
    else
      cart["#{coupon_name} W/COUPON"] = { 
        price: coupon[:cost], 
        clearance: cart_item[:clearance], 
        count: 1
      }
    end
  end
   cart
end


def apply_clearance(cart)
  
   clearance_cart = {}
  cart.each do |food, info|
    clearance_cart[food] = {}
    if info[:clearance] == true
      clearance_cart[food][:price] = info[:price] * 4 / 5
    else
      clearance_cart[food][:price] = info[:price]
    end
    clearance_cart[food][:clearance] = info[:clearance]
    clearance_cart[food][:count] = info[:count]
  end
  clearance_cart
end

def checkout(cart: [], coupons: [])
  total = 0
 consolidated = consolidate_cart(cart: cart)
  coupons_applied = apply_coupons(cart: consolidated, coupons: coupons)
  clearance_applied = apply_clearance(cart: coupons_applied)
  clearance_applied.each do |item|
    total += item[1][:price] * item[1][:count]
  end
  if total > 100
    total = total * 0.9
  else
    total
  end
  total  
end

