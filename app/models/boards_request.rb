class BoardsRequest < ApplicationRecord
  belongs_to :board
  belongs_to :user
  has_one :permit_request
end
