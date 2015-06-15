require 'pry'

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  # code here
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def both_valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    sender_new_balance = sender.balance - amount
    if sender_new_balance > 0
      if @status != "complete"
        sender.balance = sender_new_balance
        receiver.balance += amount
        @status = "complete"
      end
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end