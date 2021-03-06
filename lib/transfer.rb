class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end 

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.valid? && self.sender.balance > self.amount && self.status != "complete"
      sender.balance -= amount
      receiver.deposit(amount)
      self.status = "complete"
    elsif !(self.sender.balance > self.amount) || !self.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

  end

  def reverse_transfer
    if self.status == "complete"
      receiver.balance -= amount
      sender.deposit(amount)
      self.status = "reversed"
    end
  end

end
