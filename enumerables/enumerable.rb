module Enumerable
	
	def my_each
		
		for item in self
			yield
		end
	end

	def my_each_with_index
		index = 0

		for item in self
			yield(item, index)
			index+=1
		end
	end

	def my_select 

		self.class == Array ? arr =[] : arr={}

		self.my_each do |x|
			arr << x if yield(x)
		end

		arr
	end

	#returns true if the block never returns false or nil for any element passed to it
	def my_all? 
		self.my_each do |x|
			#stop if item is flagged
			return false if !yield 
		end

		true
	end

	#returns true if the block ever returns a value other than false or nil for any element passed to it
	def my_any? 
		self.my_each do |x|
			#stop if any item is true
			return true if yield 
		end
		
		false
	end

	#returns true if the block never returns true for any element passed to it
	def my_none? 
		self.my_each do |x|
			#stop if any item is true
			return false if yield
		end
		
		true
	end

	
	def my_count(param =nil)
		temp = []

		if block_given?
			temp = self.my_select {|x| yield(x)}
		elsif !param.nil?
			temp = self.my_select{|x| x==param}
		else
			return self.size
		end
		
		return temp.size
		
	end


	def my_map(proc=nil)
		
		temp = []
		if proc
			self.my_each{|x| temp << proc.call}
		else
			self.my_each{|x| temp << yield(x)}
		end

		temp
		
	end

	def my_inject(acc)

		accumulator = acc

		self.my_each{|x| accumulator = yield(accumulator, x) }
		
		accumulator
	end




end