module Types
  class NotificationType < Types::BaseObject
    field :id, ID, null: false
    field :image_url, String, null: false
    field :description, String, null: true
    field :due_date, String, null: false
  end
end
