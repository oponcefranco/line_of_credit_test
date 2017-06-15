module Features
  module SessionHelpers
    def visit_url
      visit '/'
    end

    def create_new_line_of_credit(credit_limit, apr)
      click_link('New Line of credit')
      fill_in('line_of_credit[apr]', with: apr)
      fill_in('line_of_credit[credit_limit]', with: credit_limit)
      click_button('Create Line of credit')
    end
    
    def select_transaction_type(type)
      option = type.downcase.capitalize
      select option, from: "transaction_type"
    end
    
    def enter_amount(amount)
      fill_in('transaction[amount]', with: amount)
    end
    
    def applied_at_day(day)
      option = day.to_i
      select option, from: "transaction_applied_at"
    end
    
    def save_transaction
      click_button('Save Transaction')
    end
    
    def remove_transaction
      remove = page.all('a.delete-transaction')
      click_link(remove[0])
    end
    
    def total_payoff_from_page
      payoff = "0.00"
      if page.has_css?('a.delete-transaction')
        sleep(2)
        result = page.all('body.line_of_credits p')
        payoff = result[4].text
        payoff.split(":")[1].split(/\D+/).reject(&:empty?).join(".").to_f
      else
        raise "unable to find element: #{element}"
      end
    end
    
    def total_interest_from_page
      interest = "0.00"
      if page.has_css?('a.delete-transaction')
        sleep(2)
        result = page.all('body.line_of_credits p')
        interest = result[3].text
        interest.split(":")[1].split(/\D+/).reject(&:empty?).join(".").to_f
      else
        raise "unable to find element: #{element}"
      end
    end
    
    def new_transaction_for(type, amount,day)
      select_transaction_type(type)
      enter_amount(amount)
      applied_at_day(day)
      save_transaction
    end
    
    def interest(principal, transaction_type, day)
      case transaction_type
      when "draw"
        then draw(principal, day).round(2)
      when "pay"
        then pay(principal, day).round(2)
      end
    end
    
    def total_payoff(amount, transaction_type, day)
      total = amount + interest(amount, transaction_type, day)
      # sprintf "%.2f", total
      return total.round(2)
    end
    
    def draw(amount, day)
      (amount * 0.35) / 365 * day
    end
    
    def pay(amount, day)
      (amount * 0.35) / 365 * day
    end
  end
end