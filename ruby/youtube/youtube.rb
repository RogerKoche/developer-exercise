#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

class Youtube

	def initialize
		@link_results = []
	end

	def search(keyword, num_results=3)
		a = Mechanize.new
		a.get('http://youtube.com/') do |page|
			search_result = page.form_with(:name => nil) do |search| #form name is nil
				search.search_query = keyword
			end.submit

			links = search_result.parser.xpath('/html/body/div/div/div/div/div/div/ol/li/div/div/h3/a/@href').to_a

			links.take(num_results).each do |link|
				@link_results << ("http://youtube.com" + link.value)
			end
		end
	end

	def list
		@link_results
	end
end