LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('loan_calc.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i.to_s == num
end

loop do
  name = ''
  loop do
    prompt(messages("welcome", LANGUAGE))
    name = gets.chomp
    if name.empty?()
      prompt(messages("valid_name", LANGUAGE))
    else
      break
    end
  end

  amount = ''
  loop do
    prompt(messages("amount", LANGUAGE))
    amount = gets.chomp
    if valid_number?(amount)
      break
    else
      prompt(messages("valid_number", LANGUAGE))
    end
  end

  duration = ''
  loop do
    prompt(messages("duration", LANGUAGE))
    duration = gets.chomp
    if valid_number?(duration)
      break
    else
      prompt(messages("valid_number", LANGUAGE))
    end
  end

  dur_month = duration.to_i * 12

  prompt("Your loan duration in months is #{dur_month}")

  prompt(messages("apr", LANGUAGE))
  apr = gets.chomp.to_f

  int_month = (apr / 100) / 12

  prompt("your monthly interest rate is #{int_month}")

  monthly_payment =
    amount.to_i * (int_month / (1 - (1 + int_month)**(-dur_month)))
  monthly_payment_round = monthly_payment.round(2)
  prompt("Your monthly payment will be $#{monthly_payment_round}")

  prompt(messages("go_again", LANGUAGE))
  choice = gets.chomp.downcase
  if choice == 'n'
    break
  end
end
prompt(messages("thank_you", LANGUAGE))
