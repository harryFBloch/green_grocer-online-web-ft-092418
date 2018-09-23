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
  # code here
  coups = {}
  cart.each {|keys, itemInfo| 
    coupons.each { |item_hash| 
      
      
    }
  }
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

a = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

consolidate_cart(a)
