require 'pry'

class Dog
attr_accessor :name, :breed, :id


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
end

def self.find_by_id(id)
  sql = "SELECT * FROM dogs WHERE id = ?"
  row = DB[:conn].execute(sql,id)[0]
  dog = self.new_from_db(row)
  dog.save
  binding.pry
end

def self.find_or_create_by

end

def self.new_from_db(row)
  Dog.new(id: row[0], name: row[1], breed: row[2])
end

def self.find_by_name(name)
  sql = "SELECT * FROM dogs WHERE name = ?"
  row = DB[:conn].execute(sql,name)[0]
  dog = self.new_from_db(row)
  dog
end

def update
  sql = "UPDATE dogs SET name = ?, breed = ?, id = ?"
  DB[:conn].execute(sql,self.name,self.breed,self.id)
end

end
