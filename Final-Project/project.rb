require 'sinatra'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/customer_controller.rb'


get '/menu' do
    controller = ItemController.new
    controller.show_items
end


get '/show/:item_id' do
    controller = ItemController.new
    controller. show_detail_item(params)
end

get '/items/create' do
    controller = ItemController.new
    controller.show_add_form
end

post '/items/create' do
    controller = ItemController.new
    controller.add_item(params)
    redirect '/menu'
end

get '/edit/:item_id' do
    controller = ItemController.new
    controller.show_edit_form(params)
end

post '/edit/:item_id' do
    controller = ItemController.new
    controller.edit_item(params)
    redirect '/menu'
end

delete '/delete/:item_id' do
    controller = ItemController.new
    controller.delete_item(params)
    redirect '/menu'
end

#related to category

get '/category' do
    controller = CategoryController.new
    controller.show_categories
end


get '/show-category/:category_id' do
    category_id = params['category_id']
    controller = CategoryController.new
    controller.show_detail_categories(params)
end

get '/category' do
    controller = CategoryController.new
    controller.show_add_category
end

post '/category' do
    controller = CategoryController.new
    controller.add_category(params)
    redirect '/category'
end

get '/edit-category/:category_id' do
    controller = CategoryController.new
    controller.show_edit_category(params)
end

post '/edit-category/:category_id'  do
    controller = CategoryController.new
    controller.save_updated_category(params)
    redirect '/category'
end

delete '/delete-category/:category_id' do
    controller = CategoryController.new
    controller.drop_category(params)
    redirect '/category'
end

#related to customer

get '/customer' do
    controller = CustomerController.new
    controller.show_customers
end

get '/customer' do
    controller = CustomerController.new
    controller.show_add_customer
end

post '/customer' do
    controller = CustomerController.new
    controller.add_customer(params)
    redirect '/customer'
end

get '/edit-customer/:customer_id' do
    controller = CustomerController.new
    controller.show_edit_customer(params)
end

post '/edit-customer/:customer_id'  do
    controller = CustomerController.new
    controller.save_updated_customer(params)
    redirect '/customer'
end

delete '/delete-customer/:customer_id' do
    controller = CustomerController.new
    controller.drop_customer(params)
    redirect '/customer'
end
