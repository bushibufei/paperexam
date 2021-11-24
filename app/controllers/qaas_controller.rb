class QaasController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @qaa = Qaa.new
   
    #@qaas = Qaa.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Qaa.all
   
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
   
    @qaa = Qaa.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @qaa = Qaa.new
    
  end
   

   
  def create
    @qaa = Qaa.new(qaa_params)
     
    if @qaa.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @qaa = Qaa.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @qaa = Qaa.find(iddecode(params[:id]))
   
    if @qaa.update(qaa_params)
      redirect_to qaa_path(idencode(@qaa.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @qaa = Qaa.find(iddecode(params[:id]))
   
    @qaa.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def qaa_params
      params.require(:qaa).permit( :title, :answer)
    end
  
  
  
end

