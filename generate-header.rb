#!/usr/bin/env ruby

require "mini_magick"

`./generate-pngs.sh`

def get_char(char)
  $pixel_data[char.ord]
end

def print_string(str)
  chars = str.split('').map(&method(:char))
  chars_ = chars[0].zip(*chars[1..-1])

  puts chars_.map {|x| x.join('')}.join("\n").gsub('0', '  ').gsub('1', 'XX')
end

def get_pixels(img_path)
  image = MiniMagick::Image.new(img_path)
  image.colorspace "Gray"
  pixels = image.get_pixels.map { |row|
    row.map { |col| col.reduce(&:+) > 0 ? 0 : 1 }
  }

  pixels
end

$pixel_data = Dir['pngs/*'].sort.map { |img_path| get_pixels(img_path) }

puts "static const size_t font_width  = 16;"
puts "static const size_t font_height = 16;"
puts "static const uint8_t font_data[] = {"

puts (0..127).map {|idx|
  char = get_char(idx)
  char.map { |line| line.join(",") }.join(",\n")
}.join(",\n\n")

puts "}"
