class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.premium!

    flash[:notice] = "Thanks! Enjoy your premium membership #{current_user.email}"
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def destroy
    current_user.standard!

    current_user.wikis.each do |wikis|
      wikis.update_attributes(private: false)
    end

    flash[:notice] = "Membership has been downgraded to Standard"
    redirect_to wikis_path
  end
end
