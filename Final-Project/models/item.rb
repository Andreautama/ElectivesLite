require './db/mysql_client.rb'
require './models/category.rb'


class Item
    attr_accessor :name, :price, :item_id, :categories
    def initialize(param)
        @name = param[:name]
        @price = param[:price]
        @item_id = param[:item_id]
        @categories = param[:categories]
    end

    def self.get_all_items
        client = create_db_client
        raw_data = client.query("SELECT * FROM items")
        items = Array.new
        raw_data.each do |data|
            item = Item.new({
                name: data['name'],
                price: data['price'],
                item_id: data['item_id']
            })
            items.push(item)
        end 
        items
    end


    def self.get_detail_items_by_item_id(item_id)
        client = create_db_client
        raw_data = client.query("select i.item_id, i.name, i.price, c.category_name as categories from items i left join item_category i_c on i.item_id = i_c.item_id left join categories c on i_c.category_id =
        c.category_id where i.item_id = #{item_id}")
        items = Array.new
        raw_data.each do |data|
            item = Item.new({
                name: data['name'],
                price: data['price'],
                item_id: data['item_id'],
                categories: data['categories']
            })
            items.push(item)
        end
        items
    end

    def self.get_edit_items_by_item_id(item_id)
        client = create_db_client
        raw_data_item = client.query("select * from items where item_id = #{item_id}")
        client = create_db_client
        raw_data_category = client.query("select c.category_name from categories c join item_category i_c on i_c.category_id = c.category_id where item_id = #{item_id}")
        detail_items = Array.new
        detail_categories = Array.new
            raw_data_item.each do |data|
                raw_data_category.each do|data_cat|
                    detail_categories << data_cat['category_name']
                end
                detail_item = Item.new({
                    name: data['name'],
                    price: data['price'],
                    item_id: data['item_id'],
                    categories: detail_categories
                     })
            detail_items.push(detail_item)
        end
        detail_items
    end
    
    

    def save
        return false unless valid?

        client = create_db_client
        client.query("Insert into items(name,price) values('#{name}','#{price}')")
        query = "Insert into item_category(item_id, category_id) select item_id , #{categories} from items where name = '#{name}'"
        client.query(query)
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def self.update(name, price, item_id, category_id)
        client = create_db_client
        client.query("Update items set name = '#{name}', price = #{price} where item_id = #{item_id}")
        client.query("Update item_category set category_id = #{category_id} where item_id = #{item_id}")
    end

    def self.get_item_category_id_by_item_id(item_id)
        client = create_db_client
        raw_data = client.query("select c.category_id from item_category i_c
        join categories c on i_c.category_id = c.category_id where i_c.item_id=#{item_id}")
        categories = []
        raw_data.each do |data| 
            categories << data['category_id']
        end
        categories
    end

    def self.delete(item_id)
        client = create_db_client
        client.query("delete from order_details where item_id = #{item_id}")
        client.query("delete from item_category where item_id = #{item_id}")
        client.query("delete from items where item_id = #{item_id}")
    end
 
end



