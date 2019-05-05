require 'pry'

class Dog
attr_accessor :name, :breed
attr_reader :id

def initialize(attr_hash)
  @name = attr_hash[:name]
  @breed = attr_hash[:breed]
end


end
