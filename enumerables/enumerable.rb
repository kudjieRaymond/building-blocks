module Enumerable
	
	def my_each
		if self.class == Array
			for i in (0...self.length) do
				yield(self[i])
			end
		elsif self.class == Hash
			for i in (0...self.keys.length) do
				yield(self.keys[i], self.values[i])
			end
		end
	end

	def my_each_with_index
		if self.class == Array
			for i in (0..self.length) do
			  yield(self[i], i)
			end
		elsif self.class == Hash
			for i in (0...self.keys.length) do
			  yield(self.keys[i], self.values[i], i)
			end
		end
	end

	def my_select 

		if self.class == Array
			temp=[]
			self.my_each do |x|
				temp << x if yield(x)	
			end
			temp
		elsif self.class == Hash
			temp={}
			self.my_each do |key, value|
				if yield(key, value)
				  temp[key] = value
				end
			end
			temp
		end

	end

	#returns true if the block never returns false or nil for any element passed to it
	def my_all? 
		if self.class == Array
			self.my_each do |value|
				#stop if item is flagged
				return false if !yield(value)
			end
		elsif self.class == Hash
			self.my_each do |key, value|
				return false if !yield(key, value)
			end
		end
		true
	end

	#returns true if the block ever returns a value other than false or nil for any element passed to it
	def my_any? 
		if self.class == Array
			self.my_each do |key|
				#stop if any item is true
				return true if yield(key) 
			end
		elsif self.class == Hash
			self.my_each do |key, value|
			  #stop if any item is true
				return true if yield(key, value)
			end
		end
		false
	end

	#returns true if the block never returns true for any element passed to it
	def my_none? 
		if self.class == Array
			self.my_each do |value|
				#stop if any item is true
				return false if yield(value)
			end
		elsif self.class == Hash
			self.my_each do |key , value|
				#stop if any item is true
				return false if yield(key, value)
			end
		end
		
		true
	end

	
	def my_count(param =nil)
		temp = []
		if self.class == Array
			if block_given?
				temp = self.my_select {|value| yield(value)}
			elsif !param.nil?
				temp = self.my_select {|value| value==param}
			else
				return self.size
			end
		elsif self.class == Hash
			if block_given?
				temp = self.my_select {|key,value| yield(key,value)}
			elsif !param.nil?
				temp = self.my_select {|key,value| value==param}
			else
				return self.size
			end
		end

		return temp.size
		
	end


	def my_map(proc=nil)
		if self.class == Array
			temp = []
			if proc.is_a? Proc
				self.my_each {|value| temp << proc.call(value)}
			else
				self.my_each {|value| temp << yield(value)}
			end
			temp
		elsif self.class == Hash
			temp = {}
			if proc.is_a? Proc
				self.my_each {|key, value| temp[key] =  proc.call(key,value)}
			else
				self.my_each {|key, value| temp[key] = yield(key, value)}
			end
			temp
		end
		
	end

	def my_inject(acc=0)
    accumulator = acc
    
		if self.class == Array
			self.my_each{|value| accumulator = yield(accumulator, value) }
		elsif self.class == Hash
			self.my_each{|key,value| accumulator = yield(accumulator, value) }
		end
		accumulator
	end
end

def multiply_els(arr)
	puts arr.my_inject(1) {|tot,n| tot * n}
end
multiply_els([2,4,5])


#arr = [1,2,3,4,5,6]

# puts arr.all? {|x| x> 10}
# puts arr.my_all? {|x| x>10}

# puts arr.any? {|x| x> 10}
# puts arr.my_any? {|x| x>10}

# puts arr.count
# puts arr.count(2)
# puts arr.count {|x| x<5}
# puts arr.my_count
# puts arr.my_count(2)
# puts arr.my_count {|x| x<5}

#puts arr.map {|x| x*2}
#puts arr.my_map {|x| x*2}


