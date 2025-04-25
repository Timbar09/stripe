module Products
  class PurchasesController < ApplicationController
    def new
    end

    def create
      product = Product.find(params[:product_id])

      puts "Creating checkout session for product: #{product.name}"
      puts "Product ID: #{product.id}"
      puts "Product Price: #{product.price}"
      puts "Product Price in cents: #{product.price_cents}"

      line_items = [
        {
          price_data: {
            currency: "usd",
            product_data: {
              name: product.name,
              description: product.description
            },
            unit_amount: product.price_cents
          },
          quantity: 1
        }
      ]

      session = Stripe::Checkout::Session.create(
        line_items: line_items,
        mode: "payment",
        success_url: success_product_purchases_url,
        cancel_url: cancel_product_purchases_url,
      )

      redirect_to session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to new_product_purchase_path
    end

    def success
    end

    def cancel
    end
  end
end
