class Attachment < ActiveRecord::Base
  belongs_to :post
  include Picturable
end
