require 'yaml'
require 'logger'
require 'find'
require 'creek'

namespace 'db' do
  desc "import water wsclgs"
  task(:import_wsclgs => :environment) do
    log_dir = "lib/tasks/data/inoutcms/logs/" 
    base_dir = "lib/tasks/data/wsclgs/" 
    qesbank_hash = Hash.new
    @error_log = Logger.new(log_dir + 'qes_banks_error.log')

    Find.find(base_dir).each do |xls|
      unless File::directory?(xls)
        file_name = File.basename(xls, '.xlsx')
        creek = Creek::Book.new(xls) 

        file_names = file_name.gsub(/\d/, '').split('$')

        creek.sheets.each_with_index do |sheet, index| 
          sheet_name = sheet.name
          matchs = /([^单多]*)((?:单|多))/.match(sheet_name)
          title = file_names[1] + matchs[1]
          qestype = matchs[2]

          qes_bank_id = nil 
          if qesbank_hash[title].nil?
            qes_bank = QesBank.create(:name => title, :editor => file_names[0])
            qes_bank_id = qes_bank.id
            qesbank_hash[title] = qes_bank_id
          else
            qes_bank_id = qesbank_hash[title]
          end

          sheet.with_images.rows.each do |row|
            content = row.reject { |key,value| value.to_s.blank? }
            if !content.blank?
              values = content.values
              c_first = values.first
              c_last = values.last

              title_mch = /(\d+\p{P})?(.+)/.match(c_first)
              q_title = title_mch[2]

              q_answer = c_last.upcase.scan(/[ABCDEFG]/) 

              #puts title + '  ' + q_title
              if qestype[0] == '单'
                @single = Single.create!(:qes_bank_id => qes_bank_id, :title => q_title)
                values[1..-2].each do |option|
                  opt = /([ABCDEFG])(\p{P}*)(.+)/.match(option.upcase)
                  option_ans = opt[1] 
                  option_title = opt[3]
                  flag = q_answer.include?(option_ans)
                  SingleOption.create(:title => option_title, :single => @single, :answer => flag)
                end
              elsif qestype[0] == '多'
                @mcq = Mcq.create!(:qes_bank_id => qes_bank_id, :title => q_title)
                values[1..-2].each do |option|
                  #puts option
                  opt = /([ABCDEFG])(\p{P}*)(.+)/.match(option.upcase)
                  option_ans = opt[1] 
                  option_title = opt[3]
                  flag = q_answer.include?(option_ans)

                  if flag 
                    McqOption.create(:title => option_title, :mcq => @mcq, :answer => flag, :sequence => q_answer.index(option_ans) + 1)
                  else
                    McqOption.create(:title => option_title, :mcq => @mcq)
                  end
                end
              else
                puts '题型未识别出来'
              end
            end
          end
        end
      end
    end
  end
end
