require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require 'bigdecimal'

describe "BigDecimal.limit" do
  it "returns the value before set if the passed argument is nil or is not specified" do
    old = BigDecimal.limit
    BigDecimal.limit.should == 0
    BigDecimal.limit(10).should == 0
    BigDecimal.limit.should == 10
    BigDecimal.limit(old)
  end

  it "uses the global limit if no precision is specified" do
    BigDecimalSpecs.with_limit(0) do
      (BigDecimal('0.888') + BigDecimal('0')).should == BigDecimal('0.888')
      (BigDecimal('0.888') - BigDecimal('0')).should == BigDecimal('0.888')
      (BigDecimal('0.888') * BigDecimal('3')).should == BigDecimal('2.664')
      (BigDecimal('0.888') / BigDecimal('3')).should == BigDecimal('0.296')
    end

    BigDecimalSpecs.with_limit(1) do
      (BigDecimal('0.888') + BigDecimal('0')).should == BigDecimal('0.9')
      (BigDecimal('0.888') - BigDecimal('0')).should == BigDecimal('0.9')
      (BigDecimal('0.888') * BigDecimal('3')).should == BigDecimal('3')
      (BigDecimal('0.888') / BigDecimal('3')).should == BigDecimal('0.3')
    end

    BigDecimalSpecs.with_limit(2) do
      (BigDecimal('0.888') + BigDecimal('0')).should == BigDecimal('0.89')
      (BigDecimal('0.888') - BigDecimal('0')).should == BigDecimal('0.89')
      (BigDecimal('0.888') * BigDecimal('3')).should == BigDecimal('2.7')
      (BigDecimal('0.888') / BigDecimal('3')).should == BigDecimal('0.30')
    end
  end

  it "picks the specified precision over global limit" do
    BigDecimalSpecs.with_limit(3) do
      BigDecimal('0.888').add(BigDecimal('0'), 2).should == BigDecimal('0.89')
      BigDecimal('0.888').sub(BigDecimal('0'), 2).should == BigDecimal('0.89')
      BigDecimal('0.888').mult(BigDecimal('3'), 2).should == BigDecimal('2.7')
      BigDecimal('0.888').div(BigDecimal('3'), 2).should == BigDecimal('0.30')
      end
  end
end
