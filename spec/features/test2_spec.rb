require "spec_helper"

feature 'Scenario 2: New Line of Credit for $1,000 and 35% APR' do
  
  before(:all) do
    visit_url
    create_new_line_of_credit('1000', '35.0')
    @url = current_url
  end
  
  before(:each) do
    visit @url
  end
    
  feature 'User draws $500 on day 1' do
    it 'pays $200 on day 15th and draws $100 on day 25th' do
      initial_amount = 500
      new_transaction_for('draw', initial_amount, 1)
      new_transaction_for('payment', 200, 15)
      new_transaction_for('draw', 100, 25)
      
      begin
        payoff = 0.00
        principal = initial_amount
        payoff += draw(principal, 15)     # 7.191780821917808
        principal = initial_amount - 200
        payoff += pay(principal, 10)      # 2.8767123287671232
        principal = initial_amount - 100
        payoff += draw(principal, 5)      # 1.917808219178082
        
        # payoff = sprintf "%.2f", payoff + principal # 411.986301369863014
        # total payoff at 30 days
        total_payoff = principal + payoff.round(2)
      end
      
      expect(total_payoff_from_page).to eq(total_payoff)
    end
    
    it 'returns interest' do
      initial_amount = 500
      begin
        payoff = 0.00
        principal = initial_amount
        payoff += draw(principal, 15)     # 7.191780821917808
        principal = initial_amount - 200
        payoff += pay(principal, 10)      # 2.8767123287671232
        principal = initial_amount - 100
        payoff += draw(principal, 5)      # 1.917808219178082
        interest = payoff.round(2)
      end
      
      expect(total_interest_from_page).to eq(interest)
    end
  end
end
