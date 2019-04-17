=begin
Behold this incomplete class for constructing boxed banners.

class Banner
  def initialize(message)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
  end

  def empty_line
  end

  def message_line
    "| #{@message} |"
  end
end
Complete this class so that the test cases shown below work as intended. You are free to add any methods or instance variables you need. However, do not make the implementation details public.

You may assume that the input will always fit in your terminal window.

Further Exploration:

Modify this class so new will optionally let you specify a fixed banner width at the time the Banner object is created. The message in the banner should be centered within the banner of that width. Decide for yourself how you want to handle widths that are either too narrow or too wide.

=end

class Banner
  def initialize(message)
    @message = message
    @spaces = @message.length + 2
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  
  def horizontal_rule
    "+#{'-' * @spaces}+"
  end
  
  def empty_line
    "|#{' ' * @spaces}|"
  end
  
  def message_line
    "| #{@message} |"
  end
end

# Test Cases
banner = Banner.new('To boldly go where no one has gone before.')
puts banner
#+--------------------------------------------+
#|                                            |
#| To boldly go where no one has gone before. |
#|                                            |
#+--------------------------------------------+
banner = Banner.new('')
puts banner
#+--+
#|  |
#|  |
#|  |
#+--+

# Further Exploration

class CustomBanner
  MAX_WIDTH = 76

  attr_reader :message, :spaces
  attr_accessor :width, :banner

  def initialize(message, message_width = message.length)
    @message = message
    @width = message_width
    constrain_width
    @spaces = @width + 2
    @banner = []
    assemble_banner
  end

  def to_s
    banner.flatten.join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * spaces}+"
  end

  def empty_line
    "|#{' ' * spaces}|"
  end

  def get_message_lines
    message_lines = []
    if message.length == width && width <= MAX_WIDTH
      message_lines << "| #{message} |"
    elsif width > message.length && width < MAX_WIDTH
      message_lines << "| #{message.center(width)} |"
    else
      message_lines = split_message
    end
    message_lines
  end

  def split_message
    message_list = message.split
    split = []
    index = 0
    until split.join(' ').length >= message.length
      split[index] = ''
      loop do
        if split[index].length == 0
          split[index] = "#{message_list.shift}"
        else
          split[index] += " #{message_list.shift}"
        end
        if message_list.empty? ||
           (split[index] + message_list[0]).length >= width
             split[index] = "| #{split[index].center(width)} |"
             break
        end
      end
      index += 1
    end
    split
  end

  def assemble_banner
    banner << horizontal_rule << empty_line
    banner << get_message_lines
    banner << empty_line << horizontal_rule
  end

  def constrain_width
    if width_too_small?
      display_small_width
      self.width = get_longest_word_length
    elsif width_too_big?
      display_large_width
      self.width = MAX_WIDTH
    end
  end

  def display_small_width
    puts
    puts "The width you gave was too small. It has been adjusted\n" \
         "too fit the longest word in your message:"
    puts
  end

  def display_large_width
    puts
    puts "The width you gave was too large. It has been adjusted\n" \
         "too fit within a length of 80 spaces:"
    puts
  end

  def width_too_big?
    width > MAX_WIDTH
  end

  def width_too_small?
    length = get_longest_word_length
    width < length
  end

  def get_longest_word_length
    longest = 0
    message.split.each do |word|
      if word.length > longest
        longest = word.length
      end
    end
    longest
  end
end

puts
custom = CustomBanner.new("Test")
puts custom

custom = CustomBanner.new("Test", 40)
puts custom

words = "This is a test to find out if my CustomBanner class will break " \
        "a message into multiple lines when the message is longer than 76 " \
        "characters long or if the given width is shorter than the length " \
        "of the message."

custom = CustomBanner.new(words, 7)
puts custom

custom = CustomBanner.new(words)
puts custom

=begin
Further Exploration Notes:

X- Check if message_width is big enough to fit the longest word
  - If it is too short, make the new width the size of the longest word.
X- Check if message_width is great than 76
  - If it is too long, make the width = 76
- If message_width is different than message length, or if the message length is greater than
  76, reformat to fit into banner width.
- Add each line of the banner to @banner as needed.
  - set index = 0
  - until split message.join(' ').length >= message.length
    - loop do
      - split[index] += "#{message_list.shift} "
      - break if split[index] += messahe_list[0] > MAX_WIDTH
    - index += 1
- return @banner in to_s method
=end