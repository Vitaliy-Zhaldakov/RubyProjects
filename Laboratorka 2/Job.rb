class Job
  attr_accessor :post, :employee, :hiredate, :firedate, :percent_bid

  def initialize(post, employee, hiredate, firedate=nil, percent_bid)
    self.post = post
    self.employee = employee
    self.hiredate = hiredate
    self.firedate = firedate
    self.percent_bid = percent_bid
  end
end
