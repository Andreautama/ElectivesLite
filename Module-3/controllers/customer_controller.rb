require 'sinatra'
require './models/customer.rb'


class CustomerController    
	def show_customers
		customers = Customer.get_all_customers()
		renderer = ERB.new(File.read("./views/customer.erb"))
		renderer.result(binding)
    end
end