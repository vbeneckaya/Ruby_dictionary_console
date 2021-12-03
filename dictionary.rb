class Dictionary
  def initialize(params = {})
    @file = params[:file]
    @pattern = params[:pattern]

    # create file if not exist
    unless File.file? @file
      File.open(@file, "w")
    end
  end

  def read_all
    begin
      file_data = File.readlines(_file)
                      .map(&:chomp)
                      .map { |line| line.split }
      return {data: file_data, error: nil}
    rescue
      return {data: nil, error: 'Read error'}
    end
  end

  def add (params)
    begin
      #check
      # p params
      if @pattern.match(params[:key].to_s) && @pattern.match(params[:value].to_s)
        File.write(_file, "#{params[:key]} #{params[:value]} \n", mode: "a")
        return {error: nil}
      else
        return {error: 'Not fit to pattern'}
      end

    rescue
      return {error: 'Some error occur by adding'}
    end
  end

  def delete_by_key (key)
    begin
      file_data = File.readlines(_file)
                      .map(&:chomp)
                      .map { |line| line.split }
                      .map { |pair| { key: pair[0], value: pair[1] } }
                      .delete_if { |item| item[:key] == key }
      # p key
      # p file_data
      File.open(_file, 'w') { |file| file_data.each { |line| file.write("#{line[:key]} #{line[:value]} \n") } }
      return {error: nil}
    rescue
      return {error: 'Some error occur by delete'}
    end
  end

  def find_by_key (key)
    begin
      file_data = File.readlines(_file)
                      .map(&:chomp)
                      .map { |line| line.split }
                      .map { |pair| { key: pair[0], value: pair[1] } }
                      .delete_if { |item| item[:key] != key }
      return {data: file_data, error: nil}
    rescue
      return {data: nil, error: 'Some error occur by find'}
    end
  end

  private

  def _file
    @file
  end
end
