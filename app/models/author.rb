class Author < ActiveRecord::Base
  has_many :builds
end
