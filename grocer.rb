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
  result = {}
 
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    result[food] = info
  end
  result
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

def checkout(cart, coupons)
  # code here
   cart = consolidate_cart(cart: cart)
   cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
  result = 0
  cart.each do |food, info|
    result += (info[:price] * info[:count]).to_f
  end
  result > 100 ? result * 0.9 : result
end

a = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

consolidate_cart(a)
