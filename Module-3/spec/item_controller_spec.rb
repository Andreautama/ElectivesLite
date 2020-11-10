require './controllers/item_controller'
require './models/item'
require './models/category.rb'
require './db/mysql_client.rb'

describe ItemController do 
  # before(:each) do
  #   client = create_db_client
  #   client.query("TRUNCATE TABLE item_category")
  #   client.query("TRUNCATE TABLE items")
  # end 

    describe '#show_items' do
      it 'should show list menu' do
        controllers = ItemController.new

        response = controllers.show_items

        expected_view = ERB.new(File.read("./views/table.erb")).result_with_hash(items: Item.get_all_items)

        expect(response).to eq(expected_view)
      end
    end

    describe '#show_add_form' do

      it 'should show form to create menu' do
        controllers = ItemController.new

        response = controllers.show_add_form

        expected_view = ERB.new(File.read("./views/form.erb")).result_with_hash(categories: Categories.get_categories)

        expect(response).to eq(expected_view)
      end

    describe '#add_item' do
      it 'should save new item' do
        controllers = ItemController.new
        response = controllers.add_item

    end
end