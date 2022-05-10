class WxQesbanksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def query_all 
    #items = QesBank.all
    
    items = QesBank.select('editor').uniq
   
    obj = []
    items.each do |item|
      obj << {
        :id => idencode(item.id),
        :name => item.editor,
       
        #:name => item.name,
       
        #:single_count => item.single_count,
       
        #:mcq_count => item.mcq_count,
       
        #:tof_count => item.tof_count,
       
        #:qaa_count => item.qaa_count
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end

  def query_lib_all 
    learn_ctg = LearnCtg.find(iddecode(params[:learn_ctg_id]))
    items = learn_ctg.qes_banks.where(:editor => params[:qes_lib_name])
   
    obj = []
    items.each do |item|
      obj << {
        :id => idencode(item.id),
        :name => item.name,
      }
    end
    respond_to do |f|
      f.json{ render :json => {:title => params[:qes_lib_name], :res => obj}.to_json}
    end
  end
end
