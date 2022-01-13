class ParseSingle 
  def initialize(current_user)
    log_dir = File.join(Rails.root, "public", "errorlogs")
    Dir::mkdir(log_dir) unless File.directory?(log_dir)

    name = Time.now.strftime('%Y-%m-%d%H:%M:%S') + '上传单选题记录' + ".log"
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
        next
      end

      titles = arr[0].strip
      options = arr[1].strip
      answer = arr[2].strip.upcase

      ansmtch = /[ABCDEF]/.match(answer) 

      title_mch = /(\d+\p{P})(.+)/.match(titles)
      orderno = title_mch[1]
      title = title_mch[2]

      if ansmtch.nil? || title.nil?
        @error.error ctn + '标题有错误'
        next
      end
      
      opt_arr = options.scan(/[ABCDEF][^ABCDEF]+/)
      flag = false
      count = 0
      hash_arr = []
      opt_arr.each do |opt|
        opts = /([ABCDEF])(\p{P}*)([^ABCDEF]+)/.match(opt.upcase)
        ans = opts[1]
        if opts[3].nil?
          break
        end
        if ans == ansmtch[0]
          count += 1
          flag = true
          hash_arr << {:title => opts[3].strip, :answer => true}
        else
          hash_arr << {:title => opts[3].strip, :answer => false}
        end
      end

      if !flag || count > 1
        @error.error ctn + '答案格式有错误或单选题答案超出了一个'
        next
      end

      @single = Single.create!(:qes_bank => qes_bank, :title => title.strip)
      hash_arr.each do |item|
        SingleOption.create(:single => @single, :title => item[:title], :answer => item[:answer])
      end
    end
  end

end
