#! /usr/bin/env ruby
# frozen_string_literal: true

require 'image-charts'
require 'nokogiri'

# https://coolors.co/114b5f-456990-e4fde1-f45b69-6b2737-efbcd5
COLORS = %w[114b5f 456990 e4fde1 f45b69 6b2737 efbcd5].freeze

data = {}
(2015..2020).each do |year|
  data[year] = {}

  page = `curl -sS -XGET https://adventofcode.com/#{year}/stats`
  document = Nokogiri::HTML.parse(page)

  document.css('a').each do |link|
    next unless link.attribute('href').to_s =~ %r{^/#{year}/day/(\d+)$}

    day = $1.to_i
    both = link.at_css('.stats-both').text.to_i
    first_only = link.at_css('.stats-firstonly').text.to_i

    data[year][day] = { first: first_only + both, both: both }
  end
end

def val(value)
  value
  # Math.log10(value).round(2)
end

chd = []
chdl = []
chco = []
chls = []
data.keys.sort.each_with_index do |year, i|
  chd << data[year].keys.sort.map { |day| val(data[year][day][:both]) }.join(',')
  chd << data[year].keys.sort.map { |day| val(data[year][day][:first]) }.join(',')
  chdl << "#{year} - both stars" << "#{year} - each day"
  chco << COLORS[i] << COLORS[i]
  chls << '2' << '2,10,5'
end

chart = ImageCharts()
        .cht('lc')
        .chxt('x,y')
        .chd("a:#{chd.join('|')}")
        .chdl(chdl.join('|'))
        .chco(chco.join(','))
        .chls(chls.join('|'))
        .chs('900x600')

puts chart.to_url
