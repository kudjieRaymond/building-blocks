
def bubble_sort(arr)
	iterations = arr.length-1
	exchanges = true

	while exchanges && iterations >0
		exchanges = false
		 #arr.length-2
		(0...iterations).each do |i|
			if arr[i]>arr[i+1]
				exchanges = true
				arr[i], arr[i+1] = arr[i+1], arr[i]

			end
		end

		iterations -=1

	end
	arr
end


def bubble_sort_by(arr)
	iterations = arr.length-1
	exchanges =true
	
	while exchanges && iterations >0
		exchanges = false
		(0...iterations).each do  |i|
			if yield(arr[i], arr[i+1]) > 0
				exchanges = true
				arr[i], arr[i+1] = arr[i+1], arr[i]
				
			end
		end
		iterations -=1
	end

	arr
end

puts bubble_sort([9,8,7,6,4,3,2,1]).inspect

puts bubble_sort_by(["hi","hello","hey"]){|left,right| left.length - right.length}.inspect