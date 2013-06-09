
require 'active_record'

class Populator
  def initialize( klass, array)
    @klass = klass
    @columns = @klass.columns.map{ |column| column.name.to_sym }
    @array = array
  end

  def to_sql_values batch
    batch.inject([]) do |arr, hash|
      arr.push "(%s)"%[to_sql(hash)]
    end.join(",")
  end

  def to_sql hash
    @columns.inject([]) do |arr, column|
      arr.push "'#{hash[column]}'"
    end.join(",")
  end

  def query batch
    values = to_sql_values batch
    q = "INSERT INTO #{@klass.table_name} (#{@columns.map(&:to_s).join(',')}) VALUES #{values}"
    puts q
    q
  end



  def execute batch_size = 512
    @array.each_slice(batch_size) do |batch|
      @klass.connection.execute query(batch)
    end
  end

end