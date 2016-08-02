
require 'test/unit'
#require 'watir'
require 'time'
require 'date'
require 'win32ole'

require 'watir-webdriver'

	

excel = WIN32OLE::new('excel.Application')
excel.DisplayAlerts = false
workbook = excel.Workbooks.Open('d:\data.xlsx')
#Loop through the worksheets
for i in 1 .. workbook.Worksheets.Count

  worksheet = workbook.Worksheets(i)
  rowcount = worksheet.UsedRange.Rows.Count

  for j in 2..rowcount
    a = worksheet.Cells(j, 1).value
    b = worksheet.Cells(j, 2).value
    c = worksheet.Cells(j, 3).value
    
	puts a
	puts b
	puts c
	puts ""
	sleep 5
	
	end
	end
	
	workbook.Close()
  excel.quit()
	
	