# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(:name => Setting.roles.super_admin)

admin_permissions = Permission.create(:name => Setting.permissions.super_admin, :subject_class => Setting.admins.class_name, :action => "manage")

role.permissions << admin_permissions

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)
user.save!

user.roles = []
user.roles << role

AdminUser.create!(:phone => Setting.admins.phone, :email => Setting.admins.email, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)

@user = User.create!(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

###区分厂区和集团用户是为了sidebar显示
#@role_fct = Role.where(:name => Setting.roles.role_fct).first
#@role_grp = Role.where(:name => Setting.roles.role_grp).first
#
#@role_warehouse = Role.where(:name => Setting.roles.role_warehouse).first
#@role_device    = Role.where(:name => Setting.roles.role_device).first
#
##厂区仓库管理员
#@fct_whmgn = [@role_fct, @role_warehouse]
##厂区设备管理员
#@fct_dvmgn = [@role_fct, @role_device]
##厂区管理者
#@fctmgn = [@role_fct, @role_warehouse, @role_device]
##集团管理者
#@grp_mgn = [@role_grp] 
#
#@lssw = Company.create!(:area => "梁山县", :name => "梁山公用水务")
#@jiax = Company.create!(:area => "嘉祥县", :name => "嘉祥公用水务")
#@wens = Company.create!(:area => "汶上县", :name => "汶上公用水务")
#@qufu = Company.create!(:area => "曲阜市", :name => "曲阜公用水务")
#@yanz = Company.create!(:area => "兖州区", :name => "兖州公用水务")
#@zouc = Company.create!(:area => "邹城市", :name => "邹城公用水务")
#@renc = Company.create!(:area => "任城区", :name => "任城污水处理厂")
#@beih = Company.create!(:area => "太白湖新区", :name => "北湖污水处理厂")
#@jinx = Company.create!(:area => "金乡县", :name => "达斯玛特污水处理厂")
#
#@lssw  = Factory.create!(:area => "梁山县",     :name => "梁山公用水务",       :company => @lssw, :lnt => 116.648154, :lat => 35.471726, :design => 20000)
#@zcsw  = Factory.create!(:area => "邹城市",     :name => "邹城公用水务",       :company => @zouc, :lnt => 116.944881, :lat => 35.384207, :design => 80000)
#@jxsw  = Factory.create!(:area => "嘉祥县",     :name => "嘉祥公用水务",       :company => @jiax, :lnt => 116.344578, :lat => 35.397421, :design => 80000)
#@wssw  = Factory.create!(:area => "汶上县",     :name => "汶上公用水务",       :company => @wens, :lnt => 116.480951, :lat => 35.712144, :design => 40000)
#@qfsw  = Factory.create!(:area => "曲阜市",     :name => "曲阜公用水务",       :company => @qufu, :lnt => 116.970989, :lat => 35.583201, :design => 40000)
#@yzsw  = Factory.create!(:area => "兖州区",     :name => "兖州公用水务",       :company => @yanz, :lnt => 116.781921, :lat => 35.510729, :design => 60000)
#@rcws  = Factory.create!(:area => "任城区",     :name => "任城污水处理厂",     :company => @renc, :lnt => 116.648154, :lat => 35.471726, :design => 20000)
#@bhws  = Factory.create!(:area => "太白湖新区", :name => "北湖污水处理厂",     :company => @beih, :lnt => 116.563934, :lat => 35.302149, :design => 20000)
#@dsmt  = Factory.create!(:area => "金乡县",     :name => "达斯玛特污水处理厂", :company => @jinx, :lnt => 116.33235,  :lat => 35.095662, :design => 20000)
#
#User.create!(:phone => "053769699898", :password => "lssw9898", :password_confirmation => "lssw9898", :name => "梁山公用水务仓库管理员", :roles => @fct_whmgn, :factories => [@lssw])
#User.create!(:phone => "053769693708", :password => "lssw3708", :password_confirmation => "lssw3708", :name => "梁山公用水务设备管理员", :roles => @fct_dvmgn, :factories => [@lssw])
#User.create!(:phone => "053737080101", :password => "lssw0101", :password_confirmation => "lssw0101", :name => "梁山公用水务管理者",     :roles => @fctmgn,    :factories => [@lssw])
#
#User.create!(:phone => "053766880606", :password => "zcsw0606", :password_confirmation => "zcsw0606", :name => "邹城公用水务仓库管理员", :roles => @fct_whmgn, :factories => [@zcsw])
#User.create!(:phone => "053711115678", :password => "zcsw5678", :password_confirmation => "zcsw5678", :name => "邹城公用水务设备管理员", :roles => @fct_dvmgn, :factories => [@zcsw])
#User.create!(:phone => "053766880909", :password => "zcsw0909", :password_confirmation => "zcsw0909", :name => "邹城公用水务管理者",     :roles => @fctmgn,    :factories => [@zcsw])
#
#User.create!(:phone => "053700006666", :password => "jxsw6666", :password_confirmation => "jxsw6666", :name => "嘉祥公用水务仓库管理员", :roles => @fct_whmgn, :factories => [@jxsw])
#User.create!(:phone => "053700009999", :password => "jxsw9999", :password_confirmation => "jxsw9999", :name => "嘉祥公用水务设备管理员", :roles => @fct_dvmgn, :factories => [@jxsw])
#User.create!(:phone => "053711114567", :password => "jxsw4567", :password_confirmation => "jxsw4567", :name => "嘉祥公用水务管理者",     :roles => @fctmgn,    :factories => [@jxsw])
#
#User.create!(:phone => "053766886969", :password => "wssw6969", :password_confirmation => "wssw6969", :name => "汶上公用水务仓库管理员", :roles => @fct_whmgn, :factories => [@wssw])
#User.create!(:phone => "053766665656", :password => "wssw5656", :password_confirmation => "wssw5656", :name => "汶上公用水务设备管理员", :roles => @fct_dvmgn, :factories => [@wssw])
#User.create!(:phone => "053766885858", :password => "wssw5858", :password_confirmation => "wssw5858", :name => "汶上公用水务管理者",     :roles => @fctmgn,    :factories => [@wssw])
#
#User.create!(:phone => "053798985858", :password => "qfsw5858", :password_confirmation => "qfsw5858", :name => "曲阜公用水务仓库管理员", :roles => @fct_whmgn, :factories => [@qfsw]) 
#User.create!(:phone => "053737081111", :password => "qfsw1111", :password_confirmation => "qfsw1111", :name => "曲阜公用水务设备管理员", :roles => @fct_dvmgn, :factories => [@qfsw]) 
#User.create!(:phone => "053798983708", :password => "qfsw3708", :password_confirmation => "qfsw3708", :name => "曲阜公用水务管理者",     :roles => @fctmgn,    :factories => [@qfsw]) 
#
#User.create!(:phone => "053766661818", :password => "rcws1818", :password_confirmation => "rcws1818", :name => "任城污水处理厂仓库管理员", :roles => @fct_whmgn, :factories => [@rcws])
#User.create!(:phone => "053798986868", :password => "rcws6868", :password_confirmation => "rcws6868", :name => "任城污水处理厂设备管理员", :roles => @fct_dvmgn, :factories => [@rcws])
#User.create!(:phone => "053766889999", :password => "rcws9999", :password_confirmation => "rcws9999", :name => "任城污水处理厂管理者",     :roles => @fctmgn,    :factories => [@rcws]) 
#
#User.create!(:phone => "053798986666", :password => "bhws6666", :password_confirmation => "bhws6666", :name => "北湖污水处理厂仓库管理员", :roles => @fct_whmgn, :factories => [@bhws]) 
#User.create!(:phone => "053756788989", :password => "bhws8989", :password_confirmation => "bhws8989", :name => "北湖污水处理厂设备管理员", :roles => @fct_dvmgn, :factories => [@bhws]) 
#User.create!(:phone => "053756786789", :password => "bhws6789", :password_confirmation => "bhws6789", :name => "北湖污水处理厂管理者",     :roles => @fctmgn,    :factories => [@bhws]) 
#
#User.create!(:phone => "053798981919", :password => "dsmt1919", :password_confirmation => "dsmt1919", :name => "达斯玛特污水处理厂仓库管理员", :roles => @fct_whmgn, :factories => [@dsmt])
#User.create!(:phone => "053756781234", :password => "dsmt1234", :password_confirmation => "dsmt1234", :name => "达斯玛特污水处理厂设备管理员", :roles => @fct_dvmgn, :factories => [@dsmt])
#User.create!(:phone => "053766881234", :password => "dsmt6688", :password_confirmation => "dsmt6688", :name => "达斯玛特污水处理厂管理者",     :roles => @fctmgn,    :factories => [@dsmt])


#
#all_factories = Factory.all
#user.factories << all_factories
#
##集团运营
#grp_opt = User.create!(:phone => "15763703588", :password => "swjt3588", :password_confirmation => "swjt3588", :name => "水务集团运营", :roles => @grp_opt, :factories => all_factories)
#
##集团管理
#grp_mgn = User.create!(:phone => "1236688", :password => "swjt6688", :password_confirmation => "swjt6688", :name => "水务集团管理者", :roles => @grp_mgn, :factories => all_factories)



#Factory.all.each do |f|
#  fake = Faker::Date
#  31.times.each do |t|
#    pdt_date = fake.between(from: '2021-01-01', to: '2021-01-31')
#    DayPdtRpt.create!(
#      :factory => f,
#      :name => pdt_date.to_s + f.name + "生产运营数据", :pdt_date => pdt_date, :weather => '晴', :min_temper => Faker::Number.between(from: -10, to: 35), 
#      :inf_qlty_bod => Faker::Number.within(range: 10..100), :inf_qlty_cod => Faker::Number.within(range: 10..100), :inf_qlty_ss => Faker::Number.within(range: 10..100), :inf_qlty_nhn => Faker::Number.within(range: 10..100), :inf_qlty_tn => Faker::Number.within(range: 10..100), :inf_qlty_tp => Faker::Number.within(range: 10..100), :inf_qlty_ph => Faker::Number.between(from: 0, to: 14), 
#      :eff_qlty_bod => Faker::Number.within(range: 1..10), :eff_qlty_cod => Faker::Number.within(range: 10..50), :eff_qlty_ss => Faker::Number.within(range: 1..10), :eff_qlty_nhn => Faker::Number.within(range: 1..5), :eff_qlty_tn => Faker::Number.within(range: 1..15), :eff_qlty_tp => format("%0.2f", Faker::Number.within(range: 0.1..0.5)), :eff_qlty_ph => Faker::Number.between(from: 0, to: 14), :eff_qlty_fecal => Faker::Number.within(range: 10..500),  
#      :sed_qlty_bod => Faker::Number.within(range: 10..100), :sed_qlty_cod => Faker::Number.within(range: 10..100), :sed_qlty_ss => Faker::Number.within(range: 10..100), :sed_qlty_nhn => Faker::Number.within(range: 10..100), :sed_qlty_tn => Faker::Number.within(range: 10..100), :sed_qlty_tp => Faker::Number.within(range: 10..100), :sed_qlty_ph => Faker::Number.between(from: 0, to: 14), 
#      :inflow => Faker::Number.within(range: 10..100), :outflow => Faker::Number.within(range: 10..100), :inmud => Faker::Number.within(range: 10..100), :outmud => Faker::Number.within(range: 10..100), :mst => Faker::Number.within(range: 10..100), :power => Faker::Number.within(range: 10..100), :mdflow => Faker::Number.within(range: 10..100), :mdrcy => Faker::Number.within(range: 10..100), :mdsell => Faker::Number.within(range: 10..100)
#    )
#  end
#end

#rcws = Factory.first
#31.times.each do |t|
#  pdt_date = Date.new(2021, 1, t+1) 
#  day_rpt = DayPdtRpt.create!(
#    :factory => rcws,
#    :name => pdt_date.to_s + rcws.name + "生产运营数据", :pdt_date => pdt_date, :weather => '晴', :min_temper => Faker::Number.between(from: -10, to: 35), 
#    :inf_qlty_bod => Faker::Number.within(range: 10..100), :inf_qlty_cod => Faker::Number.within(range: 10..100), :inf_qlty_ss => Faker::Number.within(range: 10..100), :inf_qlty_nhn => Faker::Number.within(range: 10..100), :inf_qlty_tn => Faker::Number.within(range: 10..100), :inf_qlty_tp => Faker::Number.within(range: 10..100), :inf_qlty_ph => Faker::Number.between(from: 0, to: 14), 
#    :eff_qlty_bod => Faker::Number.within(range: 1..10), :eff_qlty_cod => Faker::Number.within(range: 10..50), :eff_qlty_ss => Faker::Number.within(range: 1..10), :eff_qlty_nhn => Faker::Number.within(range: 1..5), :eff_qlty_tn => Faker::Number.within(range: 1..15), :eff_qlty_tp => format("%0.2f", Faker::Number.within(range: 0.1..0.5)), :eff_qlty_ph => Faker::Number.between(from: 0, to: 14), :eff_qlty_fecal => Faker::Number.within(range: 10..500),  
#    :sed_qlty_bod => Faker::Number.within(range: 10..100), :sed_qlty_cod => Faker::Number.within(range: 10..100), :sed_qlty_ss => Faker::Number.within(range: 10..100), :sed_qlty_nhn => Faker::Number.within(range: 10..100), :sed_qlty_tn => Faker::Number.within(range: 10..100), :sed_qlty_tp => Faker::Number.within(range: 10..100), :sed_qlty_ph => Faker::Number.between(from: 0, to: 14), 
#    :inflow => Faker::Number.within(range: 10..100), :outflow => Faker::Number.within(range: 10..100), :inmud => Faker::Number.within(range: 10..100), :outmud => Faker::Number.within(range: 10..100), :mst => Faker::Number.within(range: 10..100), :power => Faker::Number.within(range: 10..100), :mdflow => Faker::Number.within(range: 10..100), :mdrcy => Faker::Number.within(range: 10..100), :mdsell => Faker::Number.within(range: 10..100)
#  )
#  [1,2,3,4,5,6].each do |chemical|
#    Chemical.create!(:name => chemical, :unprice => Faker::Number.within(range: 10..100), :dosage => Faker::Number.within(range: 10..100), :cmptc => Faker::Number.within(range: 10..100), :day_pdt_rpt => day_rpt)
#  end
#end
#
#User.create!(:phone => "12396969696", :password => "wsfd9696", :password_confirmation => "wsfd9696", :name => "汶上佛都管理者", :roles => [], :factories => [])
#User.create!(:phone => "053798989797", :password => "yzws9797", :password_confirmation => "yzws9797", :name => "兖州污水管理者", :roles => [], :factories => [])
#User.create!(:phone => "053737089898", :password => "zcdy9898", :password_confirmation => "zcdy9898", :name => "邹城一污管理者", :roles => [], :factories => [])
#
#User.create!(:phone => "053798981234", :password => "wsqy9898", :password_confirmation => "wsqy9898", :name => "汶上清源数据审核员", :roles => @data_verifer, :factories => [@wsqy])
#User.create!(:phone => "053712348888", :password => "wsqq8888", :password_confirmation => "wsqq8888", :name => "汶上清泉数据填报员", :roles => @data_filler, :factories => [@wsqq])
#User.create!(:phone => "053712349999", :password => "wsqq9999", :password_confirmation => "wsqq9999", :name => "汶上清泉数据审核员", :roles => @data_verifer, :factories => [@wsqq])
#User.create!(:phone => "12395889588", :password => "wsfd9588", :password_confirmation => "wsfd9588", :name => "汶上佛都数据填报员", :roles => @data_filler, :factories => [@wsfd])
#User.create!(:phone => "12395999599", :password => "wsfd9599", :password_confirmation => "wsfd9599", :name => "汶上佛都数据审核员", :roles => @data_verifer, :factories => [@wsfd])
#User.create!(:phone => "053795661234", :password => "wsqy9566", :password_confirmation => "wsqy9566", :name => "汶上污水管理者", :roles => @fct_mgn, :factories => [@wsqy, @wsqq, @wsfd])
#User.create!(:phone => "053712343708", :password => "wsqq3708", :password_confirmation => "wsqq3708", :name => "汶上污水领导", :roles => @fct_leader, :factories => [@wsqy, @wsqq, @wsfd])
##-----------
#User.create!(:phone => "12305379188", :password => "rcws9188", :password_confirmation => "rcws9188", :name => "任城污水数据填报员", :roles => @data_filler, :factories => [@rcws])
#User.create!(:phone => "12305379199", :password => "rcws9199", :password_confirmation => "rcws9199", :name => "任城污水数据审核员", :roles => @data_verifer, :factories => [@rcws])
#User.create!(:phone => "12305377788", :password => "rcws7788", :password_confirmation => "rcws7788", :name => "任城污水管理者", :roles => @fct_mgn, :factories => [@rcws])
#User.create!(:phone => "12305376699", :password => "rcws6699", :password_confirmation => "rcws6699", :name => "任城污水领导", :roles => @fct_leader, :factories => [@rcws])
##-----------
#User.create!(:phone => "12305378888", :password => "dsmt8888", :password_confirmation => "dsmt8888", :name => "达斯玛特数据填报员", :roles => @data_filler, :factories => [@dsmt])
#User.create!(:phone => "12305379999", :password => "dsmt9999", :password_confirmation => "dsmt9999", :name => "达斯玛特数据审核员", :roles => @data_verifer, :factories => [@dsmt])
#User.create!(:phone => "12305376688", :password => "dsmt6688", :password_confirmation => "dsmt6688", :name => "达斯玛特管理者", :roles => @fct_mgn, :factories => [@dsmt])
#User.create!(:phone => "12305379988", :password => "dsmt9988", :password_confirmation => "dsmt9988", :name => "达斯玛特领导", :roles => @fct_leader, :factories => [@dsmt])
##-----------
#User.create!(:phone => "12305371818", :password => "jxws1818", :password_confirmation => "jxws1818", :name => "嘉祥污水数据填报员", :roles => @data_filler, :factories => [@jxws])
#User.create!(:phone => "12305370101", :password => "jxws0101", :password_confirmation => "jxws0101", :name => "嘉祥污水数据审核员", :roles => @data_verifer, :factories => [@jxws])
#User.create!(:phone => "12305378989", :password => "jxws8989", :password_confirmation => "jxws8989", :name => "嘉祥污水管理者", :roles => @fct_mgn, :factories => [@jxws])
#User.create!(:phone => "12305371111", :password => "jxws1111", :password_confirmation => "jxws1111", :name => "嘉祥污水领导", :roles => @fct_leader, :factories => [@jxws])
##-----------
#User.create!(:phone => "053766887788", :password => "bhws7788", :password_confirmation => "bhws7788", :name => "太白湖新区污水数据填报员", :roles => @data_filler, :factories => [@bhws])
#User.create!(:phone => "053798987878", :password => "bhws7878", :password_confirmation => "bhws7878", :name => "太白湖新区污水数据审核员", :roles => @data_verifer, :factories => [@bhws])
#User.create!(:phone => "053798989188", :password => "bhws9188", :password_confirmation => "bhws9188", :name => "太白湖新区污水管理者", :roles => @fct_mgn, :factories => [@bhws])
#User.create!(:phone => "053798989199", :password => "bhws9199", :password_confirmation => "bhws9199", :name => "太白湖新区污水领导", :roles => @fct_leader, :factories => [@bhws])
