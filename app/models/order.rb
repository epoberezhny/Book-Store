class Order < ApplicationRecord
  include AASM

  belongs_to :user,            optional: true
  belongs_to :shipping_method, optional: true
  belongs_to :coupon,          optional: true

  has_one :credit_card
  has_one :billing_address,  as: :addressable
  has_one :shipping_address, as: :addressable

  has_many :items, class_name: 'OrderItem', dependent: :destroy

  before_save :clear_shipping_method,
              :calc_subtotal,
              :calc_total,
              :calc_total_quantity

  accepts_nested_attributes_for :billing_address,
                                :shipping_address,
                                :credit_card,
                                :items

  scope :for_show, -> { includes(items: :book).where.not(state: :in_progress) }

  aasm column: :state do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :confirm, after: :confirm_order do
      transitions from: :in_progress, to: :in_queue
    end

    event :cancel, after: :cancel_order do
      transitions from: :in_queue, to: :canceled
    end

    event :ship    { transitions from: :in_queue,    to: :in_delivery }
    event :deliver { transitions from: :in_delivery, to: :delivered   }
  end

  def add_item(item)
    old = items.find { |old_item| old_item.book_id == item.book_id }

    if old
      old.quantity += item.quantity
    else
      items << item
    end
  end

  def merge!(other)
    other.items.each { |item| add_item(item) }
    self.coupon = nil
    save
    other.items.reload
    other.destroy
  end

  def coupon_discount
    coupon ? (items_subtotal * coupon.multiplier).truncate(2) : 0.0
  end

  def delivery_price
    shipping_method&.price || 0.0
  end

  private

  def confirm_order
    transaction do
      items.each(&:set_price!)
      items.each(&:take_from_stock)
      self.completed_at = Time.current
    end
  end

  def cancel_order
    transaction { items.each(&:put_in_stock) }
  end

  def clear_shipping_method
    self.shipping_method = nil if shipping_address&.country_id_changed?
  end

  def calc_subtotal
    self.items_subtotal = items.select(&:persisted?).sum(&:total)
  end

  def calc_total_quantity
    self.total_quantity = items.sum(&:quantity)
  end

  def calc_total
    self.total  = items_subtotal - coupon_discount + delivery_price
  end
end
