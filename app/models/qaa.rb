class Qaa < ActiveRecord::Base

  has_many :paper_qaas, :dependent => :destroy
  has_many :papers, :through => :paper_qaas





  belongs_to :paper



end
