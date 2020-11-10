require 'sinatra'
require './db_connector.rb'


get '/menu' do
    items = get_items_and_categories
    erb :table, locals: {
        items: items  
     }
end

get '/menu' do
    erb :table
end

get '/:id' do
    item_id = params['id']
    detail_items = get_detail_items(item_id)
    erb :show, locals: {
       detail_items: detail_items
    }
end

get '/items/create' do
    categories = get_categories
    erb :form, locals: {
        categories: categories
     }
end

post '/items/create' do
    name = params['item_name']
    price = params['item_price']
    category = params['item_categories']
    create_new_item(name,price,category)
        if params['item_name'] == '' && params['item_price'] == ''
            redirect '/items/create'
        else
            redirect '/menu'
        end
end

get '/edit/:id' do
    item_id = params['id']
    categories = get_categories
    all_items = get_detail_items(item_id)
    erb :edit, locals: {
        categories: categories,
        all_items: all_items
    }
end


post '/edit/:id' do
    item_id = params['item_id']
    name = params['item_name']
    price = params['item_price']
    category_id = params['item_categories']
    update_existing_item(item_id,name,price,category_id)
    redirect '/menu'
end


delete '/:id' do
    item_id = params['item_id']
    delete_item(params[:id])
    redirect'/menu'
end