require 'sinatra'
require './controllers/item_controller.rb'
require './controllers/category_controller.rb'
require './controllers/customer_controller.rb'


get '/menu' do
    controller = ItemController.new
    controller.show_items
end


# get '/:item_id' do
#     item_id = params['item_id']
#     controller = ItemController.new
#     controller. show_detail_item(params)
# end

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

post '/category/create' do
    controller = CetegoriesController.new
    controller.insert_new_category(params)
    redirect '/category'
end

get '/edit-category/:category_id' do
    category_id = params['category_id']
    controller = CategoryController.new
    controller.show_edit_category
end

post '/edit-category/:category_id'  do
    controller = CategoryController.new
    controller.save_updated_category(params)
    redirect '/menu'
end

delete '/delete-category/:category_id' do
    controller = CategoryController.neww
    delete_category(params)
    redirect '/menu'
end

#related to customer

get '/customer' do
    controller = CustomerController.new
    controller.show_customers
end