class McqOptionsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @mcq_option = McqOption.new
   
    #@mcq_options = McqOption.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = McqOption.all
   
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
   
    @mcq_option = McqOption.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @mcq_option = McqOption.new
    
  end
   

   
  def create
    @mcq_option = McqOption.new(mcq_option_params)
     
    if @mcq_option.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @mcq_option = McqOption.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @mcq_option = McqOption.find(iddecode(params[:id]))
   
    if @mcq_option.update(mcq_option_params)
      redirect_to mcq_option_path(idencode(@mcq_option.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @mcq_option = McqOption.find(iddecode(params[:id]))
   
    @mcq_option.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def mcq_option_params
      params.require(:mcq_option).permit( :title, :answer)
    end
  
  
  
end

