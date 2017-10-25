class Review < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :book

  validates :body, :score,
    presence: true
  validates :body,
    format: { with: /[ \w[:punct:]]/ }

  before_save :verify_reviewer

  scope :processed, -> { approved.or(rejected) }

  aasm column: :state do
    state :unprocessed, initial: true
    state :approved
    state :rejected

    event :approve { transitions from: :unprocessed, to: :approved }
    event :reject  { transitions from: :unprocessed, to: :rejected }
  end

  private

  def verify_reviewer
    self.verified = user.orders.delivered.joins(:items).where(order_items: { book_id: book.id }).exists?
  end
end
