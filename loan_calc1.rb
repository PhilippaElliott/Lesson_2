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


loop do

  name = ''
  loop do
    prompt(messages("welcome", LANGUAGE ))
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
        if  amount.to_i != 0
      break
    else
      prompt(messages("valid_number", LANGUAGE))
     
    end
  end
  sleep(1)
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

  sleep(1)

  prompt(messages("duration_months", LANGUAGE))
  
  prompt "#{dur_month}"
  
  apr = ''
  loop do
    prompt(messages("apr", LANGUAGE))
    apr = gets.chomp
    if valid_number?(apr)
      break
    else 
      prompt(messages("valid_number", LANGUAGE))
    end
  end

  int_month = (apr.to_f / 100) /12

  sleep(1)
  prompt(messages("apr_monthly", LANGUAGE))
  sleep(1)
  prompt "#{int_month}"


  monthly_payment = amount.to_i * (int_month / (1 - (1 + int_month)**(-dur_month)))
  monthly_payment_round = monthly_payment.round(2)
  sleep(1)
  prompt(messages("monthly_repayment", LANGUAGE))
  sleep(1)

  prompt "$#{monthly_payment_round}"
  sleep(1)
  prompt(messages("go_again", LANGUAGE))
  choice = gets.chomp.downcase
  if choice == 'n'
    break
  end
end

system "clear"
prompt(messages("thank_you", LANGUAGE)) 
