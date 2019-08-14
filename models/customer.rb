require( 'pg' )

class Customer

  attr_reader(:id, :name)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "
      INSERT INTO customers
        (
          name
        )
      VALUES
      ($1)
      RETURNING *
    "
    values = [@name]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Customer.delete_all
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM customers"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end




end
