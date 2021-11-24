class Tof < ActiveRecord::Base

  has_many :paper_tofs, :dependent => :destroy
  has_many :papers, :through => :paper_tofs





  belongs_to :paper



end
