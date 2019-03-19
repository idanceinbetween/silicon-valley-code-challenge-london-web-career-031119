class VentureCapitalist
  attr_accessor :name,  :type, :investment, :startup

  @@all = []

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def all_investments
    FundingRound.all.select {|fr| fr.venture_capitalist == self}
  end

  def total_worth
    all_investments.inject(0) {|sum,x| sum + x.investment}
  end

  def self.all
    @@all
  end

  def self.tres_commas_club
    self.all.select {|vc| vc.total_worth > 2500}
  end

  def offer_contract(startup, type, investment)
    FundingRound.new(startup, self, type, investment)
  end

  def funding_rounds
    FundingRound.all.select {|fr| fr.venture_capitalist == self}
  end

  def portfolio
    funding_rounds.map {|fr| fr.startup}.uniq
  end

  def biggest_investment
    funding_rounds.max_by {|fr| fr.investment}
  end

  def invested(domain_str)
    funding_rounds.inject(0) {|sum,x| x.startup.domain == domain_str ? sum + x.investment : sum}
  end
  
end
