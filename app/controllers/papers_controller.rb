class PapersController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @paper = Paper.new
   
    @papers = Paper.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Paper.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :start_time => item.start_time,
       
        :end_time => item.end_time,
       
        :single => item.single,
       
        :single_score => item.single_score,
       
        :mcq => item.mcq,
       
        :mcq_score => item.mcq_score,
       
        :tof => item.tof,
       
        :tof_score => item.tof_score,
       
        :qaa => item.qaa,
       
        :qaa_score => item.qaa_score,
       
        :desc => item.desc
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @paper = Paper.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @paper = Paper.new
    
  end
   

   
  def create
    @paper = Paper.new(paper_params)
     
    if @paper.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @paper = Paper.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @paper = Paper.find(iddecode(params[:id]))
   
    if @paper.update(paper_params)
      redirect_to paper_path(idencode(@paper.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @paper = Paper.find(iddecode(params[:id]))
   
    @paper.destroy
    redirect_to :action => :index
  end
   

   def download_paper
     @paper = Paper.find(iddecode(params[:id]))

     docWorker = ExportPaperDoc.new    
     target_word = docWorker.process(@paper.id)
     send_file target_word, :filename => @paper.name + ".docx", :type => "application/force-download", :x_sendfile=>true
   end

  

  

  
  
  

  private
    def paper_params
      params.require(:paper).permit( :name, :start_time, :end_time, :single, :single_score, :mcq, :mcq_score, :tof, :tof_score, :qaa, :qaa_score, :desc)
    end
  
  
  
end

