class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps *StepAccess::STEPS

  before_action :quickly_authenticate_user!
  before_action :initialize_order
  before_action :check_access!, except: [:index]

  def index
    last_allowed = StepAccess.new(@order).last_allowed
    redirect_to wizard_path(last_allowed)
  end

  def show
    @order = @order.decorate
    render_wizard
  end

  def update
    @order = Checkouter.call(@order, params, step).decorate
    render_wizard @order.object
  end

  private

  def quickly_authenticate_user!
    return if user_signed_in?
    store_location_for(:user, checkout_index_path)
    redirect_to new_user_registration_path(type: :quick)
  end

  def check_access!
    StepAccess.call(@order, step) do
      on(:allowed)    { return }
      on(:empty_cart) { redirect_to root_path }

      on(:denied) do |last_allowed|
        redirect_to wizard_path(last_allowed), alert: t('.denied')
      end
    end
  end

  def initialize_order
    @order =
      if current_order.new_record? && step == :complete
        current_user.orders.in_queue.last
      else
        current_order
      end
  end
end
