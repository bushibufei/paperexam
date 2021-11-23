class Paper < ActiveRecord::Base
  has_many :paper_singles, :dependent => :destroy
  has_many :singles, :through => :paper_singles


  belongs_to :user

end
