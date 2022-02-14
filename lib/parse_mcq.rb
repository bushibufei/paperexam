class ParseMcq
  def initialize(current_user)
    log_dir = File.join(Rails.root, "public", "errorlogs")
    Dir::mkdir(log_dir) unless File.directory?(log_dir)

    name = Time.now.strftime('%Y-%m-%d%H:%M:%S') + '上传多选题记录' + ".log"
    path = log_dir + '/' + name
    ErrorLog.create(:user => current_user, :name => name, :log_url => path) 
    @error = Logger.new(path)
  end

  def process(qes_bank, file)
    contents = File.read(file.path)
    ctns = contents.split('#$#')
    ctns.each do |ctn|
      arr = ctn.strip.split(/\r\n/)
      if arr.size != 3
        @error.error ctn + '题不是3分结构'
      end

      titles = arr[0].strip
      options = arr[1].strip
      answer = arr[2].strip.upcase

      ansmtch = answer.scan(/[ABCDEFGH]/) 

      title_mch = /(\d+\p{P})(.+)/.match(titles)
      if title_mch.nil?
        @error.error ctn + '标题格式不正确'
        next
      end

      orderno = title_mch[1]
      title = title_mch[2]

      @mcq = qes_bank.mcqs.where(:title => title.strip)
      next unless @mcq.blank?

      if ansmtch.nil? || title.nil?
        @error.error ctn + '标题有错误'
        next
      end
      
      opt_arr = options.scan(/[ABCDEFGH][^ABCDEFGH]+/)
      flag = false
      hash_arr = []
      opt_arr.each do |opt|
        opts = /([ABCDEFGH])(\p{P}*)(.+)/.match(opt.upcase)
        ans = opts[1]
        if opts[3].nil?
          break
        end
        if ansmtch.include?(ans)
          flag = true
          hash_arr << {:title => opts[3].strip, :answer => true, :sequence => ansmtch.index(ans) + 1}
        else
          hash_arr << {:title => opts[3].strip, :answer => false}
        end
      end

      if !flag
        @error.error ctn + '答案格式有错误'
        break
      end

      @mcq = Mcq.create!(:qes_bank => qes_bank, :title => title.strip)
      hash_arr.each do |item|
        if item[:answer]
          McqOption.create(:mcq => @mcq, :title => item[:title], :answer => item[:answer], :sequence => item[:sequence])
        else                             
          McqOption.create(:mcq => @mcq, :title => item[:title], :answer => item[:answer])
        end
      end
    end
  end

end
