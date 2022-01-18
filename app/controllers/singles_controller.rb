class SinglesController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!, :except => [:query_all]
  #authorize_resource

   
  def index
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @singles = @qes_bank.singles
  end
   

  def query_all 
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    items = @qes_bank.singles.all
    tag_arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
   
    obj = []
    items.each_with_index do |item, number|
      number = (number + 1).to_s + '、'
      options = item.single_options
      option_arrs = []
      answer = ''
      options.each_with_index do |opt, index|
        option_arrs << {
          "id": index,
          "value": tag_arr[index],
          "content": opt.title
        }
        answer = tag_arr[index] if opt.answer
      end
      obj << {
        :title => number + item.title,
        :options => option_arrs,
        :answer => answer
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @single = @qes_bank.singles.find(iddecode(params[:id]))
  end
   

   
  def new
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
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
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @single = @qes_bank.singles.find(iddecode(params[:id]))
  end
   
  def update
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @single = @qes_bank.singles.find(iddecode(params[:id]))
   
    if @single.update(single_params)
      redirect_to edit_qes_bank_single_path(idencode(@qes_bank.id), idencode(@single.id)) 
    else
      render :edit
    end
  end
   
  def destroy
    @qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    @single = @qes_bank.singles.find(iddecode(params[:id]))
   
    @single.destroy
    redirect_to :action => :index
  end
   
  def xls_download
    send_file File.join(Rails.root, "templates", "单选题模板.txt"), :filename => "单选题模板.txt", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  
  def parse_excel
    qes_bank = QesBank.find(iddecode(params[:qes_bank_id]))
    parse = ParseSingle.new(current_user)
    excel = params["excel_file"]
    parse.process(qes_bank, excel)

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

