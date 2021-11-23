class SingleOptionsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @single_option = SingleOption.new
   
    #@single_options = SingleOption.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = SingleOption.all
   
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
   
    @single_option = SingleOption.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @single_option = SingleOption.new
    
  end
   

   
  def create
    @single_option = SingleOption.new(single_option_params)
     
    if @single_option.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @single_option = SingleOption.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @single_option = SingleOption.find(iddecode(params[:id]))
   
    if @single_option.update(single_option_params)
      redirect_to single_option_path(idencode(@single_option.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @single_option = SingleOption.find(iddecode(params[:id]))
   
    @single_option.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def single_option_params
      params.require(:single_option).permit( :title, :answer)
    end
  
  
  
end

