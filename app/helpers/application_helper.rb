module ApplicationHelper

# Helper function to construct links for sortable table columns
# Adapted from http://railscasts.com/episodes/228-sortable-table-columns?autoplay=true and  https://richonrails.com/articles/sortable-table-columns?comments_page=2 

  def sort_link(column, path, title=nil)
    title ||= column.titleize
    
    if column == sort_column      # If the column is already sorted
      if sort_direction == "desc" # swap directions
        direction = "asc"
      else
        direction = "desc"
      end
    else                          # Else the column has not yet been sorted
      if column == "receipts"     # Default first to descending for receipts
        direction = "desc"
      else
        direction = "asc"         # Default to ascending for others
      end
    end
      
    # direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    
    icon = sort_direction == "asc" ? "fa fa-angle-up" : "fa fa-angle-down"
    icon = column == sort_column ? icon : ""
    
    if column == "receipts" # sort icon on left
      link_to "<i class='#{icon}'></i>#{title}".html_safe, {column: column, direction: direction}
    else # sort icon on right
      link_to "#{title}<i class='#{icon}'></i>".html_safe, {column: column, direction: direction}
    end
  end

# Helper functions for calculating mean and median of an array of receipts in kreuzer

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
