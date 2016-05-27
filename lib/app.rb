require 'json'
require 'date'

#Sets up files
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

#Line break of stars
def star_line_break
    puts "**************************"
end

#Prints a given word in ascii art
def print_heading(header)
end

#Prints sales and brands secton
def print_data
    print_heading("Products")
    puts "\n"
    makes_products_section
    puts "\n"
    print_heading("Brands")
end

# Print "Sales Report" in ascii art

# Print today's date

# Print "Products" in ascii art

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price
def makes_products_section
    $products_hash["items"].each do |product|
        puts product["title"]
        star_line_break
        
        retail_price = product["full-price"]
        total_purchases = calculate_total_purchases product
        total_sales = calculate_total_sales product
        average_price = calculate_average_price total_sales, total_purchases
        average_discount = calculate_average_discount retail_price.to_f, average_price.to_f
        
        puts "Retail Price: $#{retail_price} "
        puts "Total Purchases: #{total_purchases} "
        puts "Total Sales: $#{total_sales.to_f.round(2)} "
        puts "Average Price: $#{average_price.to_f.round(2)}"
        puts "Average Discount Percentage: #{average_discount.to_f.round(2)}"
        puts "\n"
    end
end

def calculate_total_purchases(product)
    product["purchases"].length
end

def calculate_total_sales(product)
   product["purchases"].inject(0) {|sales_total, sale| sales_total + sale["price"]}
end

def calculate_average_price(revenue, purchases = 1)
    revenue / purchases 
end

def calculate_average_discount(retail_price, avg_price)
    ((retail_price - avg_price) / retail_price) * 100
end
# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
def makes_brands_section

end

def create_report
    print_heading("Sales report")
    puts (Date.today)
    print_data
end


def start
    setup_files # load,read parse,and create the files
    create_report #create the report!
    puts "Report printed successfully"
end

start
