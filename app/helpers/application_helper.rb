module ApplicationHelper
# Helper functions for calcuting mean and median of an array of receipts in kreuzer

  def mean(array)
    sum = 0
    array.each do |item|
      if item == 0
        sum = 0
        # If any item in the array is 0, then return 0
        # as a mean would not be valid
        break
      end
      sum += item
    end
    return sum/array.count
  end

  def median(array, already_sorted=false)
    return nil if array.empty?
    array = array.sort unless already_sorted
    m_pos = array.size / 2
    return array.size % 2 == 1 ? array[m_pos] : mean(array[m_pos-1..m_pos])
  end

end
