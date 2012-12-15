#
# Begin by collecting the total number of pages
# that exist in your original document.
#
puts "Enter the number of pages for processing:"
pages = gets.to_i

#
# Create an array of page numbers
#
# ex. [1, 2, 3, 4, 5, 6, 7, 8, 9]
#
page_array = (1..pages).to_a
puts "Page Array: " + page_array.to_s

#
# If the page count isn't a multiple of 4, we need to
# pad the array with blank pages so we have the correct
# number of pages for a booklet.
#
# ex. [1, 2, 3, 4, 5, 6, 7, 8, 9, nil, nil, nil]
#
if pages % 4 != 0
  additional_pages = 4 - (pages % 4)
  puts "Additional blank filler pages needed: " + additional_pages.to_s
  blank_pages_array = Array.new(additional_pages)
  # puts "Blank pages array: " + blank_pages_array.to_s
  page_array = page_array + blank_pages_array
  puts "Final pages array: " + page_array.to_s
end

#
# Split the original array in half
#
# ex. [1, 2, 3, 4, 5, 6] ... [7, 8, 9, nil, nil, nil]
#
split_start =  (page_array.size / 2)
split_end = page_array.size - 1
second_array = page_array.slice!(split_start..split_end)
puts "Split Page Array: " + page_array.to_s
puts "Second Array: " + second_array.to_s

#
# Reverse the second half of the array.
# This is the beginning of the back half of the booklet
# (from the center fold, back to the outside last page)
#
#                     <-----
# ex. [nil, nil, nil, 9, 8, 7]
#
second_array_reversed = second_array.reverse!
puts "Second Array Reversed: " + second_array_reversed.to_s

#
# Zip the two arrays together in groups of 2
# These will end up being each '2-up side' of the final document
# So, the sub-array at index zero will be the first side of
# physical page one and index 1 will be the back side.
# However, they won't yet be in the proper order.
#
# ex. [[1, nil], [2, nil], [3, nil], [4, 9], [5, 8], [6, 7]]
#
page_groups = page_array.zip(second_array_reversed)
puts "Pages Grouped " + page_groups.to_s

#
# We need to reverse every other sub-array starting with the
# first side.
# This is the final step of aligning our booklet pages in
# the order with which the booklet gets printed and bound.
#
# ex. [[nil, 1], [2, nil], [nil, 3], [4, 9], [8, 5], [6, 7]]
#
final_groups = page_groups.each_with_index { |group, index| group.reverse! if (index % 2).zero? }
puts "Final Imposition Order: " + final_groups.to_s

booklet_impressions = final_groups.length
puts "Booklet Impressions needed: " + booklet_impressions.to_s

booklet_pages = booklet_impressions / 2
puts "Final Booklet pages needed: " + booklet_pages.to_s
