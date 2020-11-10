require 'mysql2'
require './item.rb'
require './category.rb'


def create_db_client
    client = Mysql2::Client.new(
        host: "localhost",
        username: "userbaru",
        password:"Password_baru15",
        database: "food_oms_db",
    )
    client
end

# def get_items
#     client = create_db_client
#     client.query("SELECT * from items")
# end

def get_all_items
    client = create_db_client
    raw_data = client.query("SELECT * FROM items")
    items = Array.new
    raw_data.each do |data|
        item = Item.new(data['name'], data ['price'], data['item_id'])
        items.push(item)
       end
    items
end

def get_items_and_categories
    client = create_db_client
    raw_data = client.query("select i.item_id as id, i.name, i.price, c.category_name, c.category_id from items i left join item_category i_c on i.item_id = i_c.item_id left join categories c on i_c.category_id =
    c.category_id")
    items = Array.new
    raw_data.each do |data|
        categories = Categories.new(data['category_name'],data['category_id'])
        item = Item.new(data['name'], data ['price'], data['id'], categories)
        items.push(item)
    end
    items
end

def get_categories
    client = create_db_client
    raw_data = client.query("SELECT * from categories")
    categories = Array.new
    raw_data.each do |data|
        category = Categories.new(data['category_name'],data['category_id'])
        categories.push(category)
    end
    categories
end


def get_detail_items(item_id)
    client = create_db_client
    raw_data = client.query("select i.item_id as id, i.name, i.price, c.category_name, c.category_id from items i left join item_category i_c on i.item_id = i_c.item_id left join categories c on i_c.category_id =
    c.category_id where i.item_id = #{item_id}")
    detail_items = Array.new
    raw_data.each do |data|
        categories = Categories.new(data['category_name'],data['category_id'])
        item = Item.new(data['name'], data ['price'], data['id'], categories)
        detail_items.push(item)
    end
    detail_items
end


def create_new_item(name,price,category_id)
    client = create_db_client
    client.query("Insert into items(name,price) values('#{name}','#{price}')")
    client.query("Insert into item_category(item_id, category_id) select item_id , #{category_id} from items where name = '#{name}'")
end

def delete_item(item_id)
    client = create_db_client
    client.query("delete from item_category where item_id = #{item_id}")
    client.query("delete from items where item_id = #{item_id}")
end

def update_existing_item(item_id,name,price,category_id)
    client = create_db_client
    client.query("Update items set name = '#{name}', price = #{price} where item_id = #{item_id}")
    client.query("Update item_category set category_id = #{category_id} where item_id = #{item_id}")
 end



