class StudentsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @factory = my_factory
    @students = [] 
    exclude_users = [Setting.admins.phone, "15763703188", "1239988"]
    users = @factory.users.where(['phone not in (?)', exclude_users])
    users.each do |user|
      @students << {:name => user.name, :idno => user.phone, :fct => user.factories.first.name} 
    end
  end

  def all 
    @students = [] 
    exclude_users = [Setting.admins.phone, "15763703188", "1239988"]
    users = User.where(['phone not in (?)', exclude_users]).all
    users.each do |user|
      @students << {:name => user.name, :idno => user.phone, :fct => user.factories.first.name} 
    end
  end
   

  def query_all 
    items = Student.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name,
       
        :identity => item.identity
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @student = Student.where(:user => current_user, :id => iddecode(params[:id])).first
   
  end
   

   
  def new
    @student = Student.new
    
  end
   

   
  def create
    @student = Student.new(student_params)
     
    @student.user = current_user
     
    if @student.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @student = Student.where(:user => current_user, :id => iddecode(params[:id])).first
   
  end
   

   
  def update
   
    @student = Student.where(:user => current_user, :id => iddecode(params[:id])).first
   
    if @student.update(student_params)
      redirect_to student_path(idencode(@student.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @student = Student.where(:user => current_user, :id => iddecode(params[:id])).first
   
    @student.destroy
    redirect_to :action => :index
  end
   

  

  

  
  def xls_download
    send_file File.join(Rails.root, "templates", "users.xlsx"), :filename => "学生信息模板.xlsx", :type => "application/force-download", :x_sendfile=>true
  end
  
  
  
  def parse_excel
    @factory = my_factory
    @role_student = Role.where(:name => Setting.roles.role_student).first
    @role_fct = Role.where(:name => Setting.roles.role_fct).first
    @student_role = [@role_fct, @role_student]

    excel = params["excel_file"]
    tool = ExcelTool.new
    results = tool.parseExcel(excel.path)

    name = ""
    identity = ""

    results["Sheet1"][1..-1].each do |items|
      items.each do |k, v|
        if !(/A/ =~ k).nil?
          name = v.nil? ? "" : v 
        elsif !(/B/ =~ k).nil?
          identity = v.nil? ? "" : v 
        end

        next if name.blank? || identity.blank?

        user_name = name.gsub(/\s/, "") 
        user_identity = identity.gsub(/\s/, "") 
        password = user_identity[6..13]

        user = User.where(:phone => user_identity).first
        next unless user.nil?

        User.create(:name => user_name, :phone => user_identity, :identity => user_identity, :password => password, :password_confirmation => password, :roles => @student_role, :factories => [@factory])
      end
    end

    redirect_to :action => :index
  end 
  

  private
    def student_params
      params.require(:student).permit( :name, :identity , :photo)
    end
  
  
  
end

