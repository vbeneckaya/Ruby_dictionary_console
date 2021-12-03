require_relative 'app'

def help
  p "try:"
  p "1. all"
  p "2. add dict_number key value"
  p "3. find dict_number key"
  p "4. delete dict_number key"
end

command = ARGV.length > 0 ? ARGV[0]  : 'help'

app = App.new

case

when (command.match(/^all$/))
  app.read_all

when (command.match(/^add$/))
  if ARGV.length < 4
    p 'Not enough arguments'
  else
    if ("#{ARGV[1]} #{ARGV[2]} #{ARGV[3]}".match(/^(1 \d{4} \d{4})|(2 [a-zA-Z]{5} [a-zA-Z]{5})$/))
      dict_number = ARGV[1].to_i
      key = ARGV[2]
      value = ARGV[3]

      app.select_dictionary dict_number
      app.add ({ key: key, value: value })
    else
      p 'Error in params'
    end
  end

when (command.match(/^delete$/))
  if ("#{ARGV[1]} #{ARGV[2]}".match(/^(1 \d{4})|(2 [a-zA-Z]{5})$/))
    dict_number = ARGV[1].to_i
    key = ARGV[2]
    app.select_dictionary dict_number
    app.delete_by_key key
  else
    p 'Error in params'
  end
when (command.match(/^find$/))
  if ("#{ARGV[1]} #{ARGV[2]}".match(/^(1 \d{4})|(2 [a-zA-Z]{5})$/))
    dict_number = ARGV[1].to_i
    key = ARGV[2]
    app.select_dictionary dict_number
    app.find_by_key key
  else
    p 'Error in params'
  end
when (command.match(/^help$/))
  help
else
  p "No such command"
  help
end


# app.select_dictionary 1

# p app.current_dictionary_index
# app.delete_by_key '234'
# app.find_by_key '2234'
# app.add ({ key: 1234, value: 4444 })