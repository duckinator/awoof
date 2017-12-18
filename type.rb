#!/usr/bin/env ruby

def get_char(char)
  "pngs/awoof-#{char.ord.to_s.rjust(3, '0')}.png"
end

def get_string(str)
  str.split('').map(&method(:get_char)).join(' ')
end

def save(filename, string)
  images = get_string(string)
  `convert #{images} +append #{filename}`
end

save(*ARGV)
