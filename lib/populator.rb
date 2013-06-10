
require 'active_record'

class Populator
  def initialize( klass, array)
    @klass = klass
    @columns = @klass.columns.map{ |column| column.name.to_sym }.delete_if{|column| :id == column  }
    @array = array
  end

  def merge_values batch
    batch.inject([]) do |arr, hash|
      arr.push( "(" << to_values(hash) << ")" )
    end.join(",")
  end

  def to_values hash
    @columns.inject([]) do |arr, column|
      value = [ :created_at, :updated_at ].include?(column) ? Time.now : hash[column]
      arr.push "#{ActiveRecord::Base::sanitize(value)}"
    end.join(",")
  end

  def sql_query batch
    values = merge_values batch
    q = "INSERT INTO #{@klass.table_name} (#{@columns.map(&:to_s).join(',')}) VALUES #{values}"
    q
  end



  def execute batch_size = 512
    ActiveRecord::Base.transaction do
      @array.each_slice(batch_size) do |batch|
        @klass.connection.execute sql_query(batch)
      end
    end
  end

end