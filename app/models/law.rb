class Law < ActiveRecord::Base



  mount_uploader :attch, AttachmentUploader




  belongs_to :law_ctg



end
