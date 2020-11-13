require './db/mysql_client.rb'
require './models/item.rb'

class Categories
    attr_accessor :category_name, :category_id, :item
    def initialize(param)
        @category_name = param[:category_name]
        @category_id = param[:category_id]
        @item = []
    end

    def self.get_categories
        client = create_db_client
        raw_data = client.query("SELECT * from categories")
        categories = Array.new
        raw_data.each do |data|
            category = Categories.new({
                category_name: data['category_name'],
                category_id: data['category_id'],
            })
            categories.push(category)
        end
        categories
    end

    def self.get_category_by_category_id(category_id)
        client = create_db_client
        raw_data = client.query("Select ca.category_id, ca.category_name, Count(i_c.item_id) item_included from categories ca Left join item_category i_c 
        on ca.category_id = i_c.category_id where ca.category_id = #{category_id} group by ca.category_id, ca.category_name;")
        categories = Array.new
        raw_data.each do |data|
            category = Categories.new({
                category_name: data['category_name'],
                category_id: data['category_id'],
                item: data['item_included']
            })
            categories.push(category)
        end
        categories
    end

    def save
        return false unless valid?

        client = create_db_client
        client.query("insert into categories(category_name) values('#{category_name}')")
    end

    def valid?
        return false if @category_name.nil?
        true
    end

    def self.update_category(category_id, category_name)
        client = create_db_client
        client.query("update categories set category_name = '#{category_name}' where category_id = #{category_id}")
    end

    def self.get_items_by_category_id(category_id)
        client = create_db_client
        raw_data = client.query("select i.item_id, i.name, i.price from items i join item_category i_c on i.item_id = i_c.item_id where i_c.category_id = #{category_id}")
        items_by_category = Array.new
        raw_data.each do |data|
            item = Item.new({
                name: data['name'], 
                price: data['price'], 
                item_id: data['item_id']})
            items_by_category.push(item)
        end
        items_by_category
    end

    def self.delete_category(category_id)
        client = create_db_client
        client.query("delete from item_category where category_id = #{category_id}")
        client.query("delete from categories where category_id = #{category_id}")
    end
end

