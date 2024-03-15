class Alert < ApplicationRecord
  belongs_to :inventory
  # Level corresponds to how isolated the nearest store is and is represented by a hex color code with increasingly darker shades of red as level increases.
  enum level: ["#ff8080", "#ff5f5f", "#ff3f3f", "#ff1e1e", "#fc0000", "#dc0000", "#b00", "#9b0000", "#7a0000", "#510000"]

  scope :seconds_ago, ->(seconds) { where("created_at > ?", seconds.seconds.ago) }
end
