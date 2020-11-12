require 'sinatra'
require './models/customer.rb'


class CustomerController    
	def show_customers
		customers = Customer.get_all_customers()
		renderer = ERB.new(File.read("./views/customer.erb"))
		renderer.result(binding)
	end

	def show_add_customer
			renderer = ERB.new(File.read("./views/customer.erb"))
			renderer.result(binding)
	end

	def add_customer(params)
			customer = Customer.new({
					name: params['name'],
					phone: params['phone']
					})
			customer.save
	end

	def show_edit_customer(params)
		customer_id = params['customer_id']
		customers = Customer.get_customer_by_customer_id(customer_id)
		renderer = ERB.new(File.read("./views/customer_edit.erb"))
		renderer.result(binding)
	end

	def save_updated_customer(params)
		customer_id = params['customer_id']
		name = params['name']
		phone = params['phone']
		Customer.update_customer(customer_id, name, phone)
	end

	def drop_customer(params)
		customer_id = params['customer_id']
		Customer.delete_customer(customer_id)
	end

end