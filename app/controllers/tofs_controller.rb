class TofsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!, :except => [:query_all]
  #authorize_resource

  def index
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @tofs = @qes_bank.tofs
  end
   

  def query_all 
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    items = @qes_bank.tofs
   
    obj = []
    items.each_with_index do |item, number|
      number = (number + 1).to_s + '、'
      option_arrs = [
        {"id": 0, "value": "正确", "content": ''},
        {"id": 1, "value": "错误", "content": ''}
      ]
      obj << {
        :title => number + item.title,
        :options => option_arrs,
        :answer => item.answer ? "正确" : "错误"
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @tof = @qes_bank.tofs.find(iddecode(params[:id]))
  end
   

   
  def new
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
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
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @tof = @qes_bank.tofs.find(iddecode(params[:id]))
  end
   
  def update
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @tof = @qes_bank.tofs.find(iddecode(params[:id]))
   
    if @tof.update(tof_params)
      redirect_to edit_qes_bank_tof_path(idencode(@qes_bank.id), idencode(@tof.id)) 
    else
      render :edit
    end
  end
   
  def destroy
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @tof = @qes_bank.tofs.find(iddecode(params[:id]))
   
    @tof.destroy
    redirect_to :action => :index
  end
   
  def xls_download
    send_file File.join(Rails.root, "templates", "判断题模板.txt"), :filename => "判断题模板.txt", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  
  def parse_excel
    qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    parse = ParseTof.new(current_user)
    excel = params["excel_file"]
    parse.process(qes_bank, excel)

    redirect_to :action => :index
  end 
  

  private
    def tof_params
      params.require(:tof).permit( :title, :answer)
    end
  
  
  
end

