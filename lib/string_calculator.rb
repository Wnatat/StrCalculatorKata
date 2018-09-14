class StringCalculator
  def sum string
    /\/\/(?<custom_delimiter>.*?)\n(?<string_fragment>.*)/ =~ string

    if !custom_delimiter.nil?
      delimiter = custom_delimiter.scan(/(?<=\[)([^\]]+)(?=\])/).map! {
        |delimiter| Regexp.escape(delimiter[0])
      }.join('|')
      string = string_fragment
    else
      delimiter = ",|\n"
    end

    begin
      if /(-\d+)/ =~ string
        raise "negatives not allowed: #{string.scan(/(-\d+)/).join(', ')}"
      end
    end

    numbers = string.split(/(#{delimiter})/)

    sum = 0
    for number in numbers do
      number = number.to_i

      if number <= 1000
        sum += number
      end
    end

    sum
  end
end
