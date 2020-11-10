class Customer
  attr_accessor :customer_id, :name, :phone

    def initialize(param)
      @customer_id = param[:customer_id]
      @name = param[:name]
      @phone = param[:phone]
    end

    def self.get_all_customers
      client = create_db_client
      raw_data = client.query("SELECT * FROM customer")
      customers = Array.new
      raw_data.each do |data|
          customer = Customer.new({
              name: data['name'],
              phone: data['phone'],
              customer_id: data['customer_id']
          })
          customers.push(customer)
      end 
      customers
    end
end