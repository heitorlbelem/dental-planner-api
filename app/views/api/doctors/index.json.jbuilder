# frozen_string_literal: true

json.doctors @doctors do |doctor|
  json.partial! 'doctor', doctor:
end

json.pagination do
  json.page_index @doctors.current_page
  json.total_count @total_count
  json.page_items_count @doctors.count
end
