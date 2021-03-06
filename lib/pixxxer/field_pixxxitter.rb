class FieldPixxxitter
	def initialize(field)
		@field = field
	end
	def pixxxit(hash, record)
		field = fetch_field hash
		add_to_record record, field
	end
	def add_to_record(record, field)
		record = widen_record record
		inject_field record, field
	end
	def widen_record(record)
		record.ljust @field.position
	end
	def inject_field(record, field)
		record[@field.position, field.length] = field
		record
	end
	def fetch_field(hash)
		field = coerce_field hash[@field.name].to_s
		field = pad_field field
		shorten_field field
	end
	def coerce_field(field)
		if @field.type == Float
			field = (field.to_f * 10 ** @field.precision).to_i
		elsif @field.type == "Boolean"
			field = field == 'true' ? @field.true_value : @field.false_value
		end
		field.to_s
	end
	def shorten_field(field)
		if @field.type == Integer || @field.type == Float
			return field[field.length - @field.width, @field.width] unless @field.width.nil?
		else
			return field[0, @field.width] unless @field.width.nil?
		end
		field
	end
	def pad_field(field)
		if @field.type == Integer || @field.type == Float
			return field.rjust(@field.width, '0') unless @field.width.nil?
		else
			return field.ljust(@field.width, ' ') unless @field.width.nil?
		end
		field
	end
end
