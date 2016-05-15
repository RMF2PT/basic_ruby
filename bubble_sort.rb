def bubble_sort(array)
    array_size = array.size
    swapped = true # variable that checks if there's any swapping this iteration
    while swapped
        swapped = false # at the begining of the iteration is always false
        (1..array_size-1).each do |i| # starts at 1 bcs we need 2 to compare
            if array[i-1].to_i > array[i].to_i              # if out of order
                array[i-1], array[i] = array[i], array[i-1] # swap
                swapped = true # if something has changed, swapped is true
            end
        end
    end
    p array
end

bubble_sort([4,3,78,2,0,2])
bubble_sort([4,2])
bubble_sort([4])

def bubble_sort_by(array)
    array_size = array.size
    swapped = true # variable that checks if there's any swapping this iteration
    while swapped
        swapped = false # at the begining of the iteration is always false
        (1..array_size-1).each do |i| # starts at 1 bcs we need two to compare
            if yield(array[i-1], array[i]) > 0              # if out of order
                array[i-1], array[i] = array[i], array[i-1] # swap
                swapped = true # if something has changed, swapped is true
            end
        end
    end
    p array
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
    left.length - right.length
end

bubble_sort_by([4,3,78,2,0,2]) {|a,b| a-b}                  # ascending
bubble_sort_by([4,3,78,2,0,2]) {|a,b| b-a}                  # descending
bubble_sort_by([4,2]) {|a,b| b-a}
bubble_sort_by([4]) {|a,b| a-b}
bubble_sort_by([5,4,3,2,1]) {|a,b| a-b}
