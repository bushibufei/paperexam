class TofsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @tof = Tof.new
   
    #@tofs = Tof.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Tof.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title,
       
        :answer => item.answer
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @tof = Tof.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @tof = Tof.new
    
  end
   

   
  def create
    @tof = Tof.new(tof_params)
     
    if @tof.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @tof = Tof.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @tof = Tof.find(iddecode(params[:id]))
   
    if @tof.update(tof_params)
      redirect_to tof_path(idencode(@tof.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @tof = Tof.find(iddecode(params[:id]))
   
    @tof.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def tof_params
      params.require(:tof).permit( :title, :answer)
    end
  
  
  
end

