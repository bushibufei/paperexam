class QesBanksController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!, :except => [:query_all]
  #authorize_resource

   
  def index
    @qes_bank = QesBank.new
   
    @qes_banks = QesBank.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = QesBank.all
   
    obj = []
    items.each do |item|
      obj << {
        :id => idencode(item.id),
       
        :name => item.name,
       
        :single_count => item.single_count,
       
        :mcq_count => item.mcq_count,
       
        :tof_count => item.tof_count,
       
        :qaa_count => item.qaa_count
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @qes_bank = QesBank.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @qes_bank = QesBank.new
    
  end
   

   
  def create
    @qes_bank = QesBank.new(qes_bank_params)
     
    if @qes_bank.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @qes_bank = QesBank.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @qes_bank = QesBank.find(iddecode(params[:id]))
   
    if @qes_bank.update(qes_bank_params)
      redirect_to edit_qes_bank_path(idencode(@qes_bank.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @qes_bank = QesBank.find(iddecode(params[:id]))
   
    @qes_bank.destroy
    redirect_to :action => :index
  end
   
  private
    def qes_bank_params
      params.require(:qes_bank).permit( :name, :editor, :single_count, :mcq_count, :tof_count, :qaa_count , :photo)
    end
  
  
  
end

