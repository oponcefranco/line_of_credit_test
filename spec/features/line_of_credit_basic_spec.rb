require "spec_helper"

RSpec.describe 'Line of Credit Management', type: :feature do

  before(:all) do
    visit_url
    create_new_line_of_credit('1000', '35.0')
    @url = current_url
  end

  before(:each) do
    visit @url
  end

  context 'when user draws $500 on day 1' do
    it 'calculates correct payoff after keeping money drawn for 30 days' do
      initial_amount = 500
      new_transaction_for('draw', initial_amount, 30)

      payoff = 0.00
      principal = initial_amount
      payoff += draw(principal, 30)
      total_payoff = principal + payoff.round(2)

      expect(total_payoff_from_page).to eq(total_payoff)
    end
  end

  context 'error handling' do
    it 'shows error when user tries to draw above credit limit' do
      new_transaction_for('draw', 2500, 30)
      error_message = find('#error_explanation ul li').text
      expect(error_message).to eq('Amount cannot exceed the credit limit')
    end

    it 'shows error when user tries to pay above what is owed' do
      new_transaction_for('pay', 2500, 30)
      error_message = find('#error_explanation ul li').text
      expect(error_message).to eq('Amount cannot exceed what is owed')
    end
  end
end
