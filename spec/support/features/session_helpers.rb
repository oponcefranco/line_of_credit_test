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
      remove_links = page.all('a.delete-transaction', wait: 10)
      raise "No delete transaction links found" if remove_links.empty?
      remove_links.first.click
    end
    
    def total_payoff_from_page
      if page.has_css?('a.delete-transaction', wait: 10)
        within('body.line_of_credits') do
          # Wait for the page to update and find the payoff element
          paragraphs = page.all('p', wait: 10)
          raise "Expected at least 5 paragraphs, found #{paragraphs.length}" if paragraphs.length < 5

          payoff_text = paragraphs[4].text
          extract_currency_value(payoff_text)
        end
      else
        raise "Unable to find delete transaction element - page may not be fully loaded"
      end
    end
    
    def total_interest_from_page
      if page.has_css?('a.delete-transaction', wait: 10)
        within('body.line_of_credits') do
          # Wait for the page to update and find the interest element
          paragraphs = page.all('p', wait: 10)
          raise "Expected at least 4 paragraphs, found #{paragraphs.length}" if paragraphs.length < 4

          interest_text = paragraphs[3].text
          extract_currency_value(interest_text)
        end
      else
        raise "Unable to find delete transaction element - page may not be fully loaded"
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
    
    def calculate_daily_interest(amount, days)
      (amount * 0.35) / 365 * days
    end

    # Aliases for backward compatibility
    alias draw calculate_daily_interest
    alias pay calculate_daily_interest

    private

    def extract_currency_value(text)
      # Extract numeric value from text like "Total: $123.45"
      value_part = text.split(":")[1]
      return 0.0 unless value_part

      value_part.split(/\D+/).reject(&:empty?).join(".").to_f
    end
  end
end