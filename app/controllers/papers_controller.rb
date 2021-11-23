class PapersController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @paper = Paper.new
   
    #@papers = current_user.papers.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Paper.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :exmdate => item.exmdate,
       
        :desc => item.desc
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @paper = Paper.where(:user => current_user, :id => iddecode(params[:id])).first
   
  end
   

   
  def new
    @paper = Paper.new
    
  end
   

   
  def create
    @paper = Paper.new(paper_params)
     
    @paper.user = current_user
     
    if @paper.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @paper = Paper.where(:user => current_user, :id => iddecode(params[:id])).first
   
  end
   

   
  def update
   
    @paper = Paper.where(:user => current_user, :id => iddecode(params[:id])).first
   
    if @paper.update(paper_params)
      redirect_to paper_path(idencode(@paper.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @paper = Paper.where(:user => current_user, :id => iddecode(params[:id])).first
   
    @paper.destroy
    redirect_to :action => :index
  end
   

  

  

  
  def xls_download
    send_file File.join(Rails.root, "templates", "表格模板.xlsx"), :filename => "表格模板.xlsx", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  

  private
    def paper_params
      params.require(:paper).permit( :name, :exmdate, :desc)
    end
  
  
  
end

