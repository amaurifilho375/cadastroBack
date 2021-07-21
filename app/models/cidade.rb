class Cidade < ApplicationRecord
  belongs_to :estado
  #validates :nome, presence: true, uniqueness: {case_sensitive: false}
  #validates_uniqueness_of :nome, :case_sensitive => false
end
