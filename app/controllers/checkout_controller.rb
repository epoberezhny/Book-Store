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
    Checkouter.call(@order, params, step) do
      on(:ok) do |order|
        self.order = order.decorate
        render_wizard order
      end
    end
  end

  private

  attr_writer :order

  def quickly_authenticate_user!
    redirect_to new_user_registration_path(type: 'quick') unless user_signed_in?
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
