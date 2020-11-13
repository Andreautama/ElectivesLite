require './db/mysql_client.rb'

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

    def self.get_customer_by_customer_id(customer_id)
        client = create_db_client
        raw_data = client.query(" Select cu.customer_id, cu.name, cu.phone from customer cu where
        cu.customer_id = #{customer_id}")
        customers = Array.new
        raw_data.each do |data|
            customer = Customer.new({
                customer_id: data['customer_id'],
                name: data['name'],
                phone: data['phone']
            })
            customers.push(customer)
        end
        customers
    end

    def save
      return false unless valid?

      client = create_db_client
      client.query("insert into customer(name,phone) values('#{name}','#{phone}')")
    end

    def valid?
      return false if @name.nil?
      return false if @phone.nil?
      true
    end

    def self.update_customer(customer_id, name, phone)
      client = create_db_client
      client.query("update customer set name = '#{name}', phone = '#{phone}' where customer_id = #{customer_id}")
    end

    def self.delete_customer(customer_id)
      client = create_db_client
      client.query("delete from orders where customer_id = #{customer_id}")
      client.query("delete from customer where customer_id = #{customer_id}")
    end
end