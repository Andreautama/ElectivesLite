require 'sinatra'
require './models/category.rb'

class CategoryController
    def show_categories
        categories = Categories.get_categories()
        renderer = ERB.new(File.read("./views/category.erb"))
        renderer.result(binding)
    end

    def show_detail_categories(params)
        category_id = params['category_id']
        items = Categories.get_items_by_category_id(category_id)
        category_details = Categories.get_category_by_category_id(category_id)
        renderer = ERB.new(File.read("./views/category_show.erb"))
        renderer.result(binding)
    end

    def show_edit_category(params)
        category_id = params['category_id']
        categories = Categories.get_category_by_category_id(category_id)
        renderer = ERB.new(File.read("./views/category_edit.erb"))
        renderer.result(binding)
    end

    def save_updated_category(params)
        category_id = params['category_id']
        category_name = params['category_name']
        Categories.update_category(category_id, category_name)
    end
    
    def show_add_category
        renderer = ERB.new(File.read("./views/category.erb"))
        renderer.result(binding)
    end

    def add_category(params)
        category = Categories.new({
            category_name: params['category_name'],
            })
        category.save
    end
    
    def drop_category(params)
        category_id = params['category_id']
        Categories.delete_category(category_id)
    end
end

