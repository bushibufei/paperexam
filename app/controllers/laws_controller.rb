class LawsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @laws = Law.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Law.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title,
       
        :pdt_date => item.pdt_date,
       
        :content => item.content,
       
        :dept => item.dept,
       
        :ctg => item.ctg
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @law = Law.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @law_ctgs = LawCtg.all
    @law = Law.new
    
  end
   

   
  def create
    @law_ctg = LawCtg.find(iddecode(params[:law_ctg]))
    @law = Law.new(law_params)
    @law.law_ctg = @law_ctg
     
    if @law.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @law_ctgs = LawCtg.all
    @law = Law.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @law_ctg = LawCtg.find(iddecode(params[:law_ctg]))
    @law = Law.find(iddecode(params[:id]))
    @law.law_ctg = @law_ctg
     
   
    if @law.update(law_params)
      redirect_to law_path(idencode(@law.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @law = Law.find(iddecode(params[:id]))
   
    @law.destroy
    redirect_to :action => :index
  end
   

  

  
    def download_append
     
      @law = Law.find(iddecode(params[:id]))
     
      @attch = @law.attch_url

      if @attch
        send_file File.join(Rails.root, "public", URI.decode(@attch)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  
  
  

  private
    def law_params
      params.require(:law).permit( :title, :pdt_date, :content, :dept, :ctg , :attch)
    end
  
  
  
end

