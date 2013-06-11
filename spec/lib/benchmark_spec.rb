require 'benchmark'

describe Benchmark do
  it "should perform better" do
    Benchmark.bm do |r|
      arr = 500.times.inject([]){ |a, i| a.push({:p1 => i, :p2 => Date.today - i.days}) }

      r.report("ActiveRecord transaction") do
        ActiveRecord::Base.transaction do
          TimestampDummyClass.create arr
        end
      end

      r.report("Populate                ") do
        TimestampDummyClass.populate arr
      end

      r.report("Populate(batch size = 8)") do
        TimestampDummyClass.populate arr
      end
    end
  end
end