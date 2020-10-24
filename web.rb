require 'sinatra'

get '/messages' do
    erb :message, locals: {
        color: 'DodgerBlue',
        name: 'World'}
end

get '/messages/:name' do
    name = params['name']
    color = params['color'] ? params['color'] : 'DodgerBlue'
    erb :message, locals:{
        color: color,
        name: name}
end

get '/login' do
    erb :form
end

post '/login' do
    if params['username'] == 'admin' && params['password'] == 'admin'
        return 'Logged in!'
    else
        redirect '/login'
    end
end

get '/table' do
    erb :table
end

get '/form' do
    erb :form
end

post '/form' do
    if params['food_name'] == '' && params['food_price'] == ''
        redirect '/form'
    else
        'Food created!'
    end
end

