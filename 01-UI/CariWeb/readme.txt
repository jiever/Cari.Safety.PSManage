======================【Modify by daiyinzhu】=====================
2017/5/23
此模块是 项目公共工具类，包含WebApi请求http的方法，用户权限接口的封装，业务系统中的转换类。

======================【Modify by sunkang】=====================
2018/5/28
修复api调用公共方法里的异常后的空指针漏判

======================【Modify by sunkang】=====================
2018/7/06
重构api请求相关内容，增加etag缓存，增加运行配置（appsetting和connectionstring）缓存


======================【Modify by jw】=====================
2018/9/18

	数据库结构变化：有
	配置变化：有
	配置数据增加： 有
	1、事故类别添加
insert into systemconfigs
select newid(),'事故类别','事故类别','','','事故管理',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'事故类别','原煤生产事故','原煤生产事故','原煤生产事故',1,1,0,getdate(),null,null,null union
select newid(),'事故类别','非原煤生产事故','非原煤生产事故','非原煤生产事故',2,1,0,getdate(),null,null,null 


	2、生产系统添加
insert into systemconfigs
select newid(),'生产系统','生产系统','','','事故管理',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'生产系统','采煤系统','采煤系统','采煤系统',1,1,0,getdate(),null,null,null union
select newid(),'生产系统','掘进系统','掘进系统','掘进系统',2,1,0,getdate(),null,null,null union
select newid(),'生产系统','机电系统','机电系统','机电系统',3,1,0,getdate(),null,null,null union
select newid(),'生产系统','运输系统','运输系统','运输系统',4,1,0,getdate(),null,null,null union
select newid(),'生产系统','通风系统','通风系统','通风系统',5,1,0,getdate(),null,null,null union
select newid(),'生产系统','其它系统','其它系统','其它系统',6,1,0,getdate(),null,null,null


	3、添加其中煤监罚款，事故类别，生产系统字段
	use CariAM
alter table [dbo].[BaseInfoes] add CoalSupervisorLoss decimal(18,2) null
alter table [dbo].[BaseInfoes] add AccidentCategory nvarchar(50) null 


alter table [dbo].[Casualtions] add CoalSupervisorLoss decimal(18,2) null
alter table [dbo].[Casualtions] add AccidentCategory nvarchar(50) null 

alter table [dbo].[NonCasualtions] add CoalSupervisorLoss decimal(18,2)  null
alter table [dbo].[NonCasualtions] add AccidentCategory nvarchar(50) null 

alter table [dbo].[CasualtionInjuries] add ProduceSystem nvarchar(50) null

	4、修改伤害程度多值配置
	use CariSafetyMain
delete from [dbo].[SystemConfigParams] where ConfigItemLabel = '伤害程度'

insert into systemconfigparams
select newid(),'伤害程度','死亡','死亡','',1,1,0,getdate(),null,null,null union
select newid(),'伤害程度','重伤','重伤','',2,1,0,getdate(),null,null,null union
select newid(),'伤害程度','轻伤','轻伤','',3,1,0,getdate(),null,null,null 


	5、添加非原煤伤害程度
insert into systemconfigs
select newid(),'非原煤伤害程度','非原煤伤害程度','','','事故管理',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'非原煤伤害程度','工业死亡','工业死亡','',1,1,0,getdate(),null,null,null union
select newid(),'非原煤伤害程度','地面病亡','地面病亡','',2,1,0,getdate(),null,null,null union
select newid(),'非原煤伤害程度','井下病亡','井下病亡','',3,1,0,getdate(),null,null,null union
select newid(),'非原煤伤害程度','重伤','重伤','',4,1,0,getdate(),null,null,null union
select newid(),'非原煤伤害程度','轻伤','轻伤','',5,1,0,getdate(),null,null,null 


	修改文件：

	
	01-UI\CariWeb\AM\CasualtionBodyEdit.aspx 修改
	01-UI\CariWeb\AM\CasualtionBodyEdit.aspx.cs 修改
	01-UI\CariWeb\AM\CasualtionInjuryEdit.aspx 修改
	01-UI\CariWeb\AM\CasualtionInjuryEdit.aspx.cs 修改
	01-UI\CariWeb\AM\CasualtionReasonEdit.aspx.cs 修改
	01-UI\CariWeb\AM\Shared\Dialog.Master 修改

	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\CasualtionAdapter.cs 修改
	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\NonCasualtionAdapter.cs 修改
	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\CasualtionBaseAdapter.cs 修改

	06-Moadel\Cari.Safety.Tian.Model.AM\BaseInfo.cs 修改
	06-Moadel\Cari.Safety.Tian.Model.AM\Casualtion.cs 修改
	06-Moadel\Cari.Safety.Tian.Model.AM\CasualtionInjury.cs 修改
	06-Moadel\Cari.Safety.Tian.Model.AM\NonCasualtion.cs 修改


	 新增事故录入页面：
	 
	01-UI\CariWeb\AM\CasualtionRecordMainForm.aspx 新增
	01-UI\CariWeb\AM\CasualtionRecordMainForm.aspx.cs 新增
	01-UI\CariWeb\AM\CasualtionRecordEditForm.aspx 新增
	01-UI\CariWeb\AM\CasualtionRecordEditForm.aspx.cs 新增


	

======================【Modify by XYP】=====================
2018-10-16

	数据库结构变化：添加涉险等级字段
	alter table [CariAM].[dbo].[CasualtionReasons] add RiskRating nvarchar(50) null
	alter table [CariAM].[dbo].[NonCasualtionReasons] add RiskRating nvarchar(50) null
	配置变化：无
	配置数据增加： 
	01-UI/CariWeb/settings.json
	SQL:
	insert into CariSafetyMain.dbo.systemconfigs
	select newid(),'涉险等级','涉险等级','涉险等级','','事故管理',0,0,0,0,getdate(),null,null,null

	insert into CariSafetyMain.dbo.systemconfigparams
	select newid(),'涉险等级','一般','一般','一般',1,1,0,getdate(),null,null,null union
	select newid(),'涉险等级','典型','典型','典型',2,1,0,getdate(),null,null,null union
	select newid(),'涉险等级','较大','较大','较大',3,1,0,getdate(),null,null,null union
	select newid(),'涉险等级','重大','重大','重大',4,1,0,getdate(),null,null,null

	1	调查认定的调查记录页面添加涉险等级字段
		修改页面：
		01-UI/CariWeb/AM/CasualtionReasonEdit.aspx
		06-Model/Cari.Safety.Tian.Model.AM/CasualtionReason.cs
		06-Model/Cari.Safety.Tian.Model.AM/Reasons.cs

	2	调查认定添加消息推送
		01-UI/CariWeb/AM/PunishmentEdit.aspx.cs
		
	

======================【Modify by XYP】=====================
2018-10-17

	数据库结构变化：无
	配置变化：无
	配置数据增加： 无

	1	调查认定添加消息推送
		修改页面：
		01-UI/CariWeb/Controllers/AmController.cs