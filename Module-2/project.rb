require 'sinatra'
require './db_connector.rb'


get '/menu' do
    items = get_all_items
    erb :table, locals: {
        items: items  
     }
end

get '/menu' do
    erb :table
end

get '/:id' do
    id = params['id']
    items = get_detail_items(id)
    erb :show, locals: {
       items: items
    }
end

get '/items/create' do
    erb :form
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
     id = params['id']
     items = get_detail_items(id)
     erb :edit, locals: {
        items: items
     }
  end

delete '/:id' do
    delete_item(params['id'])
    redirect '/menu'
end

put '/edit/:id' do
     name = params['item_name']
     price = params['item_price']
     category = params['item_categories']
     id = params['id']
     update_existing_item(id, name,price,categories)
     redirect '/:id'
end

# delete '/table' do
#     order_to_delete = Order.get(params[:order_id])
#     order_to_delete.destroy
#     redirect('/')
# end
