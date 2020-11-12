require './models/item'
require './db/mysql_client.rb'

describe Item do
    before(:each) do
        client = create_db_client
        client.query("TRUNCATE TABLE item_category")
        client.query("TRUNCATE TABLE items")
    end 

    describe '#valid' do
        context 'when initialized with valid input' do
            it 'should return true' do
                item = Item.new({ name: 'Nasi Uduk',
                        price: 10000
                         })
            expect(item.valid?).to eq(true)
            end
        end
		end
		

    # describe '.delete(item_id)' do
		# 	context 'when item_id match' do
		# 		it 'should be deleted' do
		# 			item = Item.new({
		# 				name: 'Nasi Uduk',
		# 				price: 14000,
		# 				categories: 'Main Dish'
		# 			})
		# 			Item.delete(item_id)
		# 			expect(Item.get_all_items).to eq([])
		# 		end
		# 	end
    # end
end
