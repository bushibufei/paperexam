require 'nokogiri'         

class EssaysController < ApplicationController
  layout "application_control"
  #before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @essay = Essay.new
   
    #@essays = Essay.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Essay.all.order('article_date DESC')
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :title => item.title,
       
        :dept => item.dept,
       
        :article_date => item.article_date,
       
        :content => item.content
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @essay = Essay.find(iddecode(params[:id]))
   
  end

  def query_show
    @essay = Essay.find(iddecode(params[:id]))
    content = @essay.content.gsub("/uploads/image/", Setting.systems.host + ":3000/uploads/image/").gsub("alt=", "width='100%' alt=").gsub(/<(?!br|img)[^>]*>/, '')

    obj = {
      :title => @essay.title,
      :dept => @essay.dept,
      :article_date => @essay.article_date,
      :content => content 
    }
    puts obj[:content]

    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end
   

   
  def new
    @essay = Essay.new
    
  end
   

   
  def create
    @essay = Essay.new(essay_params)
     
    if @essay.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @essay = Essay.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @essay = Essay.find(iddecode(params[:id]))
   
    if @essay.update(essay_params)
      redirect_to essay_path(idencode(@essay.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @essay = Essay.find(iddecode(params[:id]))
   
    @essay.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def essay_params
      params.require(:essay).permit( :title, :dept, :article_date, :content , :photo)
    end
  
  
  
end

