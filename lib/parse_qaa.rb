class ParseQaa
  def initialize(current_user)
    log_dir = File.join(Rails.root, "public", "errorlogs")
    Dir::mkdir(log_dir) unless File.directory?(log_dir)

    name = Time.now.strftime('%Y-%m-%d%H:%M:%S') + '上传问答题记录' + ".log"
    path = log_dir + '/' + name
    ErrorLog.create(:user => current_user, :name => name, :log_url => path) 
    @error = Logger.new(path)
  end

  def process(qes_bank, file)
    contents = File.read(file.path)
    ctns = contents.split('#$#')
    ctns.each do |ctn|
      begin
        arr = ctn.strip.split('#!!!#')

        title = arr[0]
        answer = arr[1]
        
        Qaa.create!(:qes_bank => qes_bank, :title => title.strip, :answer => answer)
      rescue
        @error.info ctn
        next
      end
    end
  end

end
