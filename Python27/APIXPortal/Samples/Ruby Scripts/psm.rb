
require 'test/unit'
#require 'watir'
require 'time'
require 'date'
require 'win32ole'

require 'watir-webdriver'

	


#--------------------------PSM verification Code--------------------------------------------------------

	ff1 = Watir::Browser.new
	psmsite= 'http://pun-psm-qc/'
	ff1.goto psmsite

	ff1.text_field(:name, "authentificationLogin").set "nitin.nazare@ubisoft.com"
	ff1.text_field(:name, "authentificationPassword").set "nitin1234"

	ff1.button(:name, "authentificationSubmit").click
	sleep 5

	

	ff1.div(:id,/langBox/).form(:action => /member/, :index => 1).click
	sleep 3

	ff1.select_list(:id, "accountSelected").select "Ubisoft"
	ff1.select_list(:id, "siteSelected").select "Nitin_test_6"

	ff1.link(:href, /promotion/).click
	sleep 10

	#ff1.select_list(:id, "property[0]").select "Reference"
	sleep 1

	#ff1.text_field(:id, "value[0]").set str

	#ff1.button(:value, "search").click

	#sleep 2
    
	pricemang = ff1.tr(:class,/weak/).cell(:index, 10).text
	ff1.tr(:class,/weak/).td(:class=>/action/).img(:alt,/Disable/>).click
	#pricemang = ff1.tr(:class,/weak/).cell(:index, 2).text
	#ref = ff1.tr(:class,/weak/).cell(:index, 3).text
	#sum = ff1.tr(:class,/weak/).cell(:index, 4).text

	#textlog.puts pricemang
	#textlog.puts ref
	#textlog.puts sum

	