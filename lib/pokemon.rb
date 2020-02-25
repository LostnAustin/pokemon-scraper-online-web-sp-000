class Pokemon
  attr_accessor  :id, :name, :type, :db


  def initialize(id:, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?,?)
        SQL
        db.execute(sql, name, type)
       @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

    def self.find(id, db)
      sql = <<-SQL
      SELECT name, type FROM pokemon
      WHERE id = ?
      LIMIT 1
      SQL
      results =  db.execute(sql, id)
      pokemon = Pokemon.new(id, name, type, db).tap do |p|
        pokemon.id = results[0]
        pokemon.name = results[1]
        pokemon.type = results[2]
        pokemon
      end

      # db.execute(sql).map do |row|
      #   self.new(row)
      # end.first

    end

  # if self.id
  #   sql = <<-SQL
  #   UPDATE pokemon SET name = ?, type = ?
  #   WHERE id = ?
  #   SQL
  #   DB[:conn].execute(sql, self.name, self.type, self.id)
  # else

  # def self.create_table
  #   sql = <<-SQL
  #     CREATE TABLE IF NOT EXISTS pokemon (
  #       id INTEGER PRIMARY KEY,
  #       name TEXT,
  #       type TEXT
  #     )
  #   SQL
  #   DB[:conn].execute(sql)
  # end



end
