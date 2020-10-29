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

def get_items
    client = create_db_client
    client.query("SELECT * from items")
end

#  def get_all_items
#       client = create_db_client
#       raw_data = client.query("SELECT * FROM items")
#       items = Array.new
#       raw_data.each do |data|
#           item = Item.new(data['name'], data ['price'], data['item_id'])
#           #categories = Categories.new(data['name'], data['category_id'])
#           items.push(item)
#       end
#       items
#   end

def get_all_items
    client = create_db_client
    raw_data = client.query("select i.item_id as id, i.name, i.price, c.category_name, c.category_id from items i left join item_category i_c on i.item_id = i_c.item_id left join categories c on i_c.category_id =
    c.category_id;")
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
    client.query("SELECT * from categories")
end


def get_detail_items(id)
    client = create_db_client
    raw_data = client.query("select i.item_id as id, i.name, i.price, c.category_name, c.category_id from items i left join item_category i_c on i.item_id = i_c.item_id left join categories c on i_c.category_id =
    c.category_id;")
    items = Array.new
    raw_data.each do |data|
        categories = Categories.new(data['category_name'],data['category_id'])
        item = Item.new(data['name'], data ['price'], data['id'], categories)
        items.push(item)
    end
    items
end


def create_new_item(name,price,category)
    client = create_db_client
    client.query("Insert into items(name,price) values('#{name}','#{price}')")
    client.query("Insert into categories(category_name) values('#{category}')")
end

def delete_item(id)
    client = create_db_client
    client.query("delete from items where item_id = #{id}")

end

def update_existing_item(id, name,price,category)
    client = create_db_client
    client.query("Update items(id,name,price,category) set (name = '#{name}', price = '#{price}', categories = '#{category}') where id='#{id}'")
end


# items = get_all_items()
#item = get_detail_items(id)

# items = create_new_item()
# items = update_existing_item()

#p items.each
#p create_db_client
#p items(1)

