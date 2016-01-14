# Array sample
arr = (1..10).to_a
arr.delete(arr.sample)
arr.delete(arr.sample)

# Result wrapper for find_missed_elements method
#
# @param arr [Array]
def get_missed(arr)
  missed_elements = find_missed_elements(arr)
  case missed_elements.length
    when 0 ## STEP 2 ##
      if (1 - arr.first) == -2
        missed_elements << arr.first - 1
        missed_elements << arr.first - 2
      elsif (1 - arr.first) == -1
        missed_elements << arr.first - 1
        missed_elements << arr.last  + 1
      elsif (1 - arr.first) == 0
        missed_elements << arr.last + 1
        missed_elements << arr.last + 2
      end
    when 1 ## STEP 3 ##
      if missed_elements.include?(arr.first - 1)
        missed_elements << arr.last + 1
      else
        missed_elements << arr.first - 1
      end
  end
  missed_elements ## STEP 1 ##
end

# @param arr [Array] Sorted array (in ascending order)
# @param memo [Array] Optional array which stores missed elements
def find_missed_elements(arr, memo = [])
  ## STEP 1 ##
  center = arr.length / 2
  if center.zero?
    ## STEP 6 ##
    memo
  else
    ## STEP 2 ##
    left_half  = arr[0...center]
    right_half = arr[center..(arr.length - 1)]

    left_center_val  = left_half.last
    right_center_val = right_half.first

    diff = case right_center_val - left_center_val
             when 2 then [left_center_val + 1]
             when 3 then [left_center_val + 1, left_center_val + 2]
             else []
           end

    memo |= diff
    ## STEP 3 ##
    return memo if memo.length == 2

    ## STEP 4 ##
    memo |= find_missed_elements(left_half, memo)
    return memo if memo.length == 2

    ## STEP 5 ##
    memo |= find_missed_elements(right_half, memo)
    return memo if memo.length == 2

    ## STEP 6 ##
    memo
  end
end

puts arr.inspect
puts get_missed(arr).inspect
