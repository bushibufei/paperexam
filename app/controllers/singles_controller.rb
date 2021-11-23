class SinglesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @single = Single.new
   
    #@singles = Single.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Single.all
   
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
   
    @single = Single.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @single = Single.new
    
  end
   

   
  def create
    @single = Single.new(single_params)
     
    if @single.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @single = Single.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @single = Single.find(iddecode(params[:id]))
   
    if @single.update(single_params)
      redirect_to single_path(idencode(@single.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @single = Single.find(iddecode(params[:id]))
   
    @single.destroy
    redirect_to :action => :index
  end
   

  

  

  
  def xls_download
    send_file File.join(Rails.root, "templates", "表格模板.xlsx"), :filename => "表格模板.xlsx", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  
  def parse_excel
    excel = params["excel_file"]
    tool = ExcelTool.new
    results = tool.parseExcel(excel.path)

    a_str = ""
    b_str = ""
    c_str = "" 
    d_str = ""
    e_str = ""
    f_str = ""
    g_str = ""

    results["Sheet1"][1..-1].each do |items|
      items.each do |k, v|
        if !(/A/ =~ k).nil?
          a_str = v.nil? ? "" : v 
        elsif !(/B/ =~ k).nil?
          b_str = v.nil? ? "" : v 
        elsif !(/C/ =~ k).nil?
          c_str = v.nil? ? "" : v 
        elsif !(/D/ =~ k).nil?
          d_str = v.nil? ? "" : v 
        elsif !(/E/ =~ k).nil?
          e_str = v.nil? ? "" : v 
        elsif !(/F/ =~ k).nil?
          f_str = v.nil? ? "" : v 
        elsif !(/G/ =~ k).nil?
          g_str = v.nil? ? "" : v 
          break
        end
      end
    end

    redirect_to :action => :index
  end 
  

  private
    def single_params
      params.require(:single).permit( :title , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
  
end

