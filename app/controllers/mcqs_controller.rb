class McqsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @mcq = Mcq.new
   
    #@mcqs = Mcq.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Mcq.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @mcq = Mcq.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @mcq = Mcq.new
    
  end
   

   
  def create
    @mcq = Mcq.new(mcq_params)
     
    if @mcq.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @mcq = Mcq.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @mcq = Mcq.find(iddecode(params[:id]))
   
    if @mcq.update(mcq_params)
      redirect_to mcq_path(idencode(@mcq.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @mcq = Mcq.find(iddecode(params[:id]))
   
    @mcq.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def mcq_params
      params.require(:mcq).permit( :title)
    end
  
  
  
end

