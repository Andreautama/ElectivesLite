require 'mysql2'


def create_db_client
    client = Mysql2::Client.new(
        host: "localhost",
        username: "userbaru",
        password:"Password_baru15",
        database: ENV["DB_NAME"],
    )
    client
end