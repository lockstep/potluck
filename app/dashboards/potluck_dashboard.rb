require "administrate/base_dashboard"

class PotluckDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    start_time: Field::DateTime,
    end_time: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :id,
    :start_time,
    :end_time
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :start_time,
    :end_time,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :start_time,
    :end_time
  ].freeze

  def display_resource(potluck)
    "Potluck #{potluck.id} at #{potluck.start_time}"
  end
end
