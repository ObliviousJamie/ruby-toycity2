require 'json'

#Sets up files
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("../report.txt", "w+")
end

#Write to file
def print_this(*phrases)
    phrases.each{|phrase| $report_file.write(" #{phrase} \n")}
end

#Line break of stars
def star_line_break
    print_this "**************************"
end

#Prints a given word in ascii art
def print_heading(header)
    require 'rubygems'
    require 'artii'
    a = Artii::Base.new :font => 'slant'
    print_this a.asciify(header)
end

#Prints sales and brands secton
def print_data
    print_heading("Products")
    print_this "\n"
    makes_products_section
    print_this "\n"
    print_heading("Brands")
    print_this "\n"
    makes_brands_section
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

# Call methods to make products section
def makes_products_section
    $products_hash["items"].each do |product|
        print_this product["title"]
        star_line_break
        
        retail_price = product["full-price"]
        total_purchases = calculate_total_purchases product
        total_sales = calculate_total_sales product
        average_price = calculate_average_price total_sales, total_purchases
        average_discount = calculate_average_discount retail_price.to_f, average_price.to_f
        
        print_this "Retail Price: $#{retail_price} ", "Total Purchases: #{total_purchases} ", "Total Sales: $#{total_sales.to_f.round(2)} ","Average Price: $#{average_price.to_f.round(2)}", "Average Discount Percentage: #{average_discount.to_f.round(2)}%", "\n"
    end
end

#Calculates how many purchases there are
def calculate_total_purchases(product)
    product["purchases"].length
end

#Calculates total revenue there is for a given item
def calculate_total_sales(product)
   product["purchases"].inject(0) {|sales_total, sale| sales_total + sale["price"]}
end

#Calculates average price
def calculate_average_price(revenue, purchases = 1)
    revenue / purchases 
end

#Calculates average discount percentage
def calculate_average_discount(retail_price, avg_price)
    ((retail_price - avg_price) / retail_price) * 100
end
# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
# Call methods to make brands section
def makes_brands_section
    items = $products_hash["items"]
    brands = items.map {|item| item["brand"]}.uniq

    brands.each do |brand|
        by_brand = items.select { |item| item["brand"] == brand}

        stock = 0
        total_brand_price = 0
        total_revenue = 0
        brand_count = by_brand.length
     
        by_brand.each do |key|
            stock = calculate_brand_stock key,stock
            total_brand_price = calculate_total_brand_price key,total_brand_price 
            total_revenue = calculate_total_brand_sales key, total_revenue
        end 
        print_this "Brand #{brand} "
        star_line_break

        avg_price = calculate_avg_brand_price total_brand_price, brand_count

        print_this "Number of Products: #{stock} ", "Average Product Price $#{avg_price}", "Total Sales: $#{total_revenue} ", "\n"

    end

end

#Calculates stock for given brand
def calculate_brand_stock(brands,stock)
    stock + brands["stock"].to_i
end

#Calculates total brand price
def calculate_total_brand_price(brands,total)
    (brands["full-price"].to_f + total.to_f)

end

#Calculates average brand price
def calculate_avg_brand_price(total,items)
    (total / items).round(2)
end

#Calculates total brand sales
def calculate_total_brand_sales(brands,total)
    (total + brands["purchases"].inject(0) { |purchase_total, purchase| purchase_total + purchase["price"]}).round(2)
end

#Creates body of report
def create_report
    require 'date'
    print_heading("Sales report")
    print_this (Date.today)
    print_data
end

#Prints report
def start
    setup_files # load,read parse,and create the files
    create_report #create the report!
    puts "Report printed successfully"
end

#Starting the application
start
