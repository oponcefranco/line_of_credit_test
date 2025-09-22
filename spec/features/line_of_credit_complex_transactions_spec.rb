require "spec_helper"

RSpec.describe 'Line of Credit Complex Transactions', type: :feature do

  before(:all) do
    visit_url
    create_new_line_of_credit('1000', '35.0')
    @url = current_url
  end

  before(:each) do
    visit @url
  end

  context 'when user makes multiple transactions' do
    it 'calculates correct payoff after draw, payment, and another draw' do
      initial_amount = 500
      new_transaction_for('draw', initial_amount, 1)
      new_transaction_for('payment', 200, 15)
      new_transaction_for('draw', 100, 25)

      payoff = 0.00
      principal = initial_amount
      payoff += draw(principal, 15)     # Interest for 15 days on $500
      principal = initial_amount - 200
      payoff += pay(principal, 10)      # Interest for 10 days on $300
      principal = initial_amount - 100
      payoff += draw(principal, 5)      # Interest for 5 days on $400

      total_payoff = principal + payoff.round(2)

      expect(total_payoff_from_page).to eq(total_payoff)
    end

    it 'calculates correct total interest' do
      initial_amount = 500

      payoff = 0.00
      principal = initial_amount
      payoff += draw(principal, 15)     # Interest for 15 days on $500
      principal = initial_amount - 200
      payoff += pay(principal, 10)      # Interest for 10 days on $300
      principal = initial_amount - 100
      payoff += draw(principal, 5)      # Interest for 5 days on $400
      interest = payoff.round(2)

      expect(total_interest_from_page).to eq(interest)
    end
  end
end
