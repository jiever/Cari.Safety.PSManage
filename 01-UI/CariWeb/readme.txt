======================��Modify by daiyinzhu��=====================
2017/5/23
��ģ���� ��Ŀ���������࣬����WebApi����http�ķ������û�Ȩ�޽ӿڵķ�װ��ҵ��ϵͳ�е�ת���ࡣ

======================��Modify by sunkang��=====================
2018/5/28
�޸�api���ù�����������쳣��Ŀ�ָ��©��

======================��Modify by sunkang��=====================
2018/7/06
�ع�api����������ݣ�����etag���棬�����������ã�appsetting��connectionstring������


======================��Modify by jw��=====================
2018/9/18

	���ݿ�ṹ�仯����
	���ñ仯����
	�����������ӣ� ��
	1���¹�������
insert into systemconfigs
select newid(),'�¹����','�¹����','','','�¹ʹ���',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'�¹����','ԭú�����¹�','ԭú�����¹�','ԭú�����¹�',1,1,0,getdate(),null,null,null union
select newid(),'�¹����','��ԭú�����¹�','��ԭú�����¹�','��ԭú�����¹�',2,1,0,getdate(),null,null,null 


	2������ϵͳ���
insert into systemconfigs
select newid(),'����ϵͳ','����ϵͳ','','','�¹ʹ���',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'����ϵͳ','��úϵͳ','��úϵͳ','��úϵͳ',1,1,0,getdate(),null,null,null union
select newid(),'����ϵͳ','���ϵͳ','���ϵͳ','���ϵͳ',2,1,0,getdate(),null,null,null union
select newid(),'����ϵͳ','����ϵͳ','����ϵͳ','����ϵͳ',3,1,0,getdate(),null,null,null union
select newid(),'����ϵͳ','����ϵͳ','����ϵͳ','����ϵͳ',4,1,0,getdate(),null,null,null union
select newid(),'����ϵͳ','ͨ��ϵͳ','ͨ��ϵͳ','ͨ��ϵͳ',5,1,0,getdate(),null,null,null union
select newid(),'����ϵͳ','����ϵͳ','����ϵͳ','����ϵͳ',6,1,0,getdate(),null,null,null


	3���������ú�෣��¹��������ϵͳ�ֶ�
	use CariAM
alter table [dbo].[BaseInfoes] add CoalSupervisorLoss decimal(18,2) null
alter table [dbo].[BaseInfoes] add AccidentCategory nvarchar(50) null 


alter table [dbo].[Casualtions] add CoalSupervisorLoss decimal(18,2) null
alter table [dbo].[Casualtions] add AccidentCategory nvarchar(50) null 

alter table [dbo].[NonCasualtions] add CoalSupervisorLoss decimal(18,2)  null
alter table [dbo].[NonCasualtions] add AccidentCategory nvarchar(50) null 

alter table [dbo].[CasualtionInjuries] add ProduceSystem nvarchar(50) null

	4���޸��˺��̶ȶ�ֵ����
	use CariSafetyMain
delete from [dbo].[SystemConfigParams] where ConfigItemLabel = '�˺��̶�'

insert into systemconfigparams
select newid(),'�˺��̶�','����','����','',1,1,0,getdate(),null,null,null union
select newid(),'�˺��̶�','����','����','',2,1,0,getdate(),null,null,null union
select newid(),'�˺��̶�','����','����','',3,1,0,getdate(),null,null,null 


	5����ӷ�ԭú�˺��̶�
insert into systemconfigs
select newid(),'��ԭú�˺��̶�','��ԭú�˺��̶�','','','�¹ʹ���',0,0,0,0,getdate(),null,null,null

insert into systemconfigparams
select newid(),'��ԭú�˺��̶�','��ҵ����','��ҵ����','',1,1,0,getdate(),null,null,null union
select newid(),'��ԭú�˺��̶�','���没��','���没��','',2,1,0,getdate(),null,null,null union
select newid(),'��ԭú�˺��̶�','���²���','���²���','',3,1,0,getdate(),null,null,null union
select newid(),'��ԭú�˺��̶�','����','����','',4,1,0,getdate(),null,null,null union
select newid(),'��ԭú�˺��̶�','����','����','',5,1,0,getdate(),null,null,null 


	�޸��ļ���

	
	01-UI\CariWeb\AM\CasualtionBodyEdit.aspx �޸�
	01-UI\CariWeb\AM\CasualtionBodyEdit.aspx.cs �޸�
	01-UI\CariWeb\AM\CasualtionInjuryEdit.aspx �޸�
	01-UI\CariWeb\AM\CasualtionInjuryEdit.aspx.cs �޸�
	01-UI\CariWeb\AM\CasualtionReasonEdit.aspx.cs �޸�
	01-UI\CariWeb\AM\Shared\Dialog.Master �޸�

	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\CasualtionAdapter.cs �޸�
	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\NonCasualtionAdapter.cs �޸�
	04-BLL\BLL\Cari.Safety.Tian.BLL.AM\CasualtionBaseAdapter.cs �޸�

	06-Moadel\Cari.Safety.Tian.Model.AM\BaseInfo.cs �޸�
	06-Moadel\Cari.Safety.Tian.Model.AM\Casualtion.cs �޸�
	06-Moadel\Cari.Safety.Tian.Model.AM\CasualtionInjury.cs �޸�
	06-Moadel\Cari.Safety.Tian.Model.AM\NonCasualtion.cs �޸�


	 �����¹�¼��ҳ�棺
	 
	01-UI\CariWeb\AM\CasualtionRecordMainForm.aspx ����
	01-UI\CariWeb\AM\CasualtionRecordMainForm.aspx.cs ����
	01-UI\CariWeb\AM\CasualtionRecordEditForm.aspx ����
	01-UI\CariWeb\AM\CasualtionRecordEditForm.aspx.cs ����


	

======================��Modify by XYP��=====================
2018-10-16

	���ݿ�ṹ�仯��������յȼ��ֶ�
	alter table [CariAM].[dbo].[CasualtionReasons] add RiskRating nvarchar(50) null
	alter table [CariAM].[dbo].[NonCasualtionReasons] add RiskRating nvarchar(50) null
	���ñ仯����
	�����������ӣ� 
	01-UI/CariWeb/settings.json
	SQL:
	insert into CariSafetyMain.dbo.systemconfigs
	select newid(),'���յȼ�','���յȼ�','���յȼ�','','�¹ʹ���',0,0,0,0,getdate(),null,null,null

	insert into CariSafetyMain.dbo.systemconfigparams
	select newid(),'���յȼ�','һ��','һ��','һ��',1,1,0,getdate(),null,null,null union
	select newid(),'���յȼ�','����','����','����',2,1,0,getdate(),null,null,null union
	select newid(),'���յȼ�','�ϴ�','�ϴ�','�ϴ�',3,1,0,getdate(),null,null,null union
	select newid(),'���յȼ�','�ش�','�ش�','�ش�',4,1,0,getdate(),null,null,null

	1	�����϶��ĵ����¼ҳ��������յȼ��ֶ�
		�޸�ҳ�棺
		01-UI/CariWeb/AM/CasualtionReasonEdit.aspx
		06-Model/Cari.Safety.Tian.Model.AM/CasualtionReason.cs
		06-Model/Cari.Safety.Tian.Model.AM/Reasons.cs

	2	�����϶������Ϣ����
		01-UI/CariWeb/AM/PunishmentEdit.aspx.cs
		
	

======================��Modify by XYP��=====================
2018-10-17

	���ݿ�ṹ�仯����
	���ñ仯����
	�����������ӣ� ��

	1	�����϶������Ϣ����
		�޸�ҳ�棺
		01-UI/CariWeb/Controllers/AmController.cs