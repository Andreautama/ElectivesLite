require 'sinatra'
require './models/item.rb'
require './models/category.rb'

class ItemController    
    
	def show_items
		items = Item.get_all_items()
		renderer = ERB.new(File.read("./views/table.erb"))
		renderer.result(binding)
    end

    def show_detail_item(params)
        item_id = params['item_id']
        items = Item.get_detail_items_by_item_id(item_id)
        renderer = ERB.new(File.read("./views/show.erb"))
        renderer.result(binding)
    end

    def show_add_form
        categories = Categories.get_categories
        renderer = ERB.new(File.read("./views/form.erb"))
        renderer.result(binding)
    end

    def add_item(params)
        item = Item.new({
            name: params['item_name'],
            price: params['item_price'],
            categories: params['item_categories']})
        item.save
    end

    def show_edit_form(params)
        item_id = params['item_id']
        detail_items = Item.get_edit_items_by_item_id(item_id)
        categories = Categories.get_categories
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
    end

    def edit_item(params)
        name = params['item_name']
        price = params['item_price']
        item_id = params['item_id']
        category_id = params['item_categories']
        Item.update(name, price, item_id, category_id)
    end

    def delete_item(params)
        item_id = params['item_id']
        Item.delete(item_id)
    end
end
