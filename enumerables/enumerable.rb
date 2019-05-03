module Enumerable
	
	def my_each
		if self.class == Hash
			for
		else
		
		end
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

	def my_all? 
		self.my_each do |x|
			#stop if item is flagged
			return false if yield == false
		end

		true
	end

	def my_any? 
		self.my_each do |x|
			#stop if any item is true
			return true if yield == true
		end
		
		false
	end



end