class BoardsTag < ApplicationRecord
  belongs_to :board
  belongs_to :tag
end
