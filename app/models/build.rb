class Build < ActiveRecord::Base
  belongs_to :author
  belongs_to :skill
end
