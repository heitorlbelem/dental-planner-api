# frozen_string_literal: true

json.patients @patients do |patient|
  json.partial! 'patient', patient:
end

json.pagination do
  json.page_index @patients.current_page
  json.total_count @total_count
  json.page_items_count @patients.count
end
