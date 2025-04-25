class Product < ApplicationRecord
  has_rich_text :description

  def price_cents
    (price.to_f * 100).to_i
  end
end
