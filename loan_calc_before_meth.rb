system "clear"
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
  num.to_i.to_s == num || num.to_f.to_s == num
end

def valid_choice?(choice)
  choice == 'n' || choice.downcase == 'n' || 
  choice == 'y' || choice.downcase == 'y'
end

def int_month_calc(apr, amount, dur_month)
  case apr
  when 0
    puts "Your monthly repayment will be #{amount.to_i / dur_month}."
  else
    prompt(messages("apr_monthly", LANGUAGE))
  sleep(1)
  prompt ((apr.to_f / 100) / 12).round(4)
  end
end

loop do
  name = ''
  loop do
    prompt(messages("welcome", LANGUAGE))
    name = gets.chomp
    sleep(1)
    if name.empty?()
      prompt(messages("valid_name", LANGUAGE))
    else
      break
    end
  end
  sleep(1)
  amount = ''
  loop do
    prompt(messages("amount", LANGUAGE))
    amount = gets.chomp
    break if amount.to_i >= 0
    prompt(messages("valid_number", LANGUAGE))
  end

  sleep(1)

  duration = ''
  loop do
    prompt(messages("duration", LANGUAGE))
    duration = gets.chomp
    break if (valid_number?(duration)) && ((duration.to_i > 0) || (duration.to_f > 0))
    prompt(messages("valid_number", LANGUAGE))
  end

  dur_month = duration.to_f * 12

  sleep(1)

  prompt(messages("duration_months", LANGUAGE))
  prompt dur_month.to_s

  apr = ''
  loop do
    prompt(messages("apr", LANGUAGE))
    apr = gets.chomp
    break if (valid_number?(apr)) && ((apr.to_i >= 0) || (apr.to_f >= 0))
    prompt(messages("valid_number", LANGUAGE))     
  end

  int_month_calc(apr, amount, dur_month)

  # int_month = ((apr.to_f / 100) / 12).round(4)
  # # if int_month == 0
  # #     puts "Your monthly replayment will be #{amount.to_i / dur_month}."
  # #  sleep(1)
  # # elsif
  #   prompt(messages("apr_monthly", LANGUAGE))
  # sleep(1)
  # prompt int_month.to_s
  
  # prompt(messages("go_again", LANGUAGE))
  # choice = gets.chomp.downcase
  # if choice == 'n'
  #   break  
  # end
    
    

  sleep(1) 
  

  monthly_payment =
    amount.to_i * (int_month / (1 - (1 + int_month)**(-dur_month)))
  monthly_payment_round = monthly_payment.round(2)
  sleep(1)
  prompt(messages("monthly_repayment", LANGUAGE))
  sleep(1)

  prompt "$#{monthly_payment_round}"
  sleep(1)

  choice = ''
  loop do
      prompt(messages("go_again", LANGUAGE))
    choice = gets.chomp
    if valid_choice?(choice) 
      break
    elsif 
    prompt (messages("valid_choice", LANGUAGE))
    end
  end

  break if choice.downcase == 'n'
    
    
end

  

prompt(messages("thank_you", LANGUAGE))