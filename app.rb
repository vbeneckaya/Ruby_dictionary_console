require_relative 'dictionary'

class App
  attr_reader :current_dictionary_index, :dictionaries

  def initialize
    @current_dictionary_index = nil
    @dictionaries = [Dictionary.new({ file: 'd1.txt', pattern: /^\d{4}$/ }),
                     Dictionary.new({ file: 'd2.txt', pattern: /^[a-zA-Z]{5}$/ })]
  end

  def select_dictionary(number = nil)

    if (1..2).include?(number)
      @current_dictionary_index = number
      p "Dictionary #{number} selected successful"
    else
      @current_dictionary_index = nil
      p "All dictionaries selected"
    end
  end

  def read_all
    dictionaries.each do |item|
      res = item.read_all

      if res[:error] == nil
        res[:data].each { |pair| p "key: #{pair[0]}, value: #{pair[1]}" }
      else
        p res[:error]
      end
    end
  end

  def delete_by_key (key)
    res = dictionaries[current_dictionary_index - 1].delete_by_key key
    p res[:error] != nil ? res[:error] : 'Success'
  end

  def find_by_key (key)
    res = dictionaries[current_dictionary_index - 1].find_by_key key
    p res[:error] == nil ? res[:data].map { |el| "#{el[:key]} #{el[:value]}" } : res[:error]
  end

  def add (params)
    res = dictionaries[current_dictionary_index - 1].add (params)
    p res[:error] != nil ? res[:error] : 'Success'
  end


end