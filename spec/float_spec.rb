require 'pixxxer'

describe 'Float' do
		
	# add tests for invalid values
	
	describe 'String.depixxxit' do
		
		before(:each) do
			@sample = '12345'
		end

		it 'parses a field and coerces it to a float' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_float.at_position(0).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Float)
		end

		it 'parses a field and coerces it to a float with decimal places' do
			define_pixxx_template(:foobar)
				.add_field(:foo).as_float.with_precision(2).at_position(0).with_width(5)
			depixxxed = @sample.depixxxit :foobar
			depixxxed[:foo].should be_a_kind_of(Float)
			depixxxed[:foo].should == 123.45
		end

	end

	describe 'Hash.pixxxit' do

		before(:each) do
			@sample = {
				:float => 123.45,
			}
		end

		it 'builds a string coerced from a float with a width that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(10).with_precision(2)
			@sample.pixxxit(:foobar).should == '0000012345'
		end

		it 'builds a string coerced from a float with a width that is too small' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(3).with_precision(2)
			@sample.pixxxit(:foobar).should == '345'
		end

		it 'builds a string coerced from a float with a width that is just right' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(5).with_precision(2)
			@sample.pixxxit(:foobar).should == '12345'
		end

		it 'builds a string coerced from a float with a precision that is too big' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(10).with_precision(3)
			@sample.pixxxit(:foobar).should == '0000123450'
		end

		it 'builds a string coerced from a float with a precision that is too small' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(10).with_precision(1)
			@sample.pixxxit(:foobar).should == '0000001234'
		end

		it 'builds a string coerced from a float and defaults the precision to zero' do
			define_pixxx_template(:foobar)
				.add_field(:float).as_float.with_width(5)
			@sample.pixxxit(:foobar).should == '00123'
		end

	end

end
