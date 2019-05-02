
def bubble_sort(arr)
	iterations = arr.length-1
	exchanges = true

	while exchanges && iterations >0
		exchanges = false
		 #arr.length-2
		for i in (0...iterations) do
			if arr[i]>arr[i+1]
				exchanges = true
				temp =arr[i]
				arr[i] = arr[i+1]
				arr[i+1] = temp
			end
		end

		iterations -=1

	end
	puts arr.inspect
end


def bubble_sort_by(arr)
	iterations = arr.length-1
	exchanges =true
	
	while exchanges && iterations >0
		exchanges = false
		for i in (0...iterations) do
			if yield(arr[i], arr[i+1]) > 0
				exchanges = true
				temp =arr[i]
				arr[i] = arr[i+1]
				arr[i+1] = temp
			end
		end
		iterations -=1
	end
	puts arr.inspect
end

bubble_sort([9,8,7,6,4,3,2,1])

bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end