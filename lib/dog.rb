require 'pry'

class Dog
attr_accessor :name, :breed
attr_reader :id

def initialize(attr_hash)
  @name = attr_hash[:name]
  @breed = attr_hash[:breed]
end

def self.create_table
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT)
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs
      SQL
    DB[:conn].execute(sql)
  end

def save
  sql = <<-SQL
    INSERT INTO dogs (name, breed) VALUES (?,?)
    SQL
  DB[:conn].execute(sql,self.name,self.breed)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
  self
end

def self.create(attr_hash)
  new_dog = Dog.new(attr_hash)
  new_dog.save
  new_dog
end

def self.find_by_id(id)
  sql = <<-SQL
    SELECT FROM dogs where id = ?
    SQL
  DB[:conn].execute(sql,id)
end

end
