USE [SafetySysNew]
GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDefinedResourceDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountDefinedResourceDelete]

	(
		@UserDefinedRoleID varchar(50)
	)

AS
/* SET NOCOUNT ON */

/*
declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountUserDefinedRole	 where UserDefinedRoleID in '+ @pkidstring

exec(@deletestring)	
	
	*/
	Delete from AccountUserDefinedResource	 where UserDefinedRoleID=@UserDefinedRoleID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentNameGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
Author      :shenyi
Date        :2012-6-12
Description :返回所有部门
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentNameGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT DepartmentRoleName AS [key],DepartmentRoleName  AS [value]
from AccountDepartmentRole 
	RETURN



GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRoleAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountDepartmentRole表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentRoleAdd]

	(
		@departmentId varchar(50),
		@DepartmentRoleParentID varchar(50), 
		@DepartmentRoleName varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO 
AccountDepartmentRole(DepartmentRoleID ,DepartmentRoleParentID, DepartmentRoleName) 
values(@departmentId, @DepartmentRoleParentID, @DepartmentRoleName)	


	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRoleDeleteByDepartmentRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentRoleDeleteByDepartmentRoleID]

	(
		@DepartmentRoleID varchar(50)
		
	)

AS
/* SET NOCOUNT ON */

   declare @returnValue bit
	
	
	set @returnValue = 0 
	
	if  (exists (select DepartmentRoleID from AccountDepartmentRole where DepartmentRoleParentID = @DepartmentRoleID))
	set @returnValue = 0 
	
	
	else if (exists (select RoleID from AccountRoleCatalog where RoleID = @DepartmentRoleID and flag=1))
	set @returnValue = 0
	
	else
	begin
	
	Delete from AccountDepartmentRole where DepartmentRoleID=@DepartmentRoleID
	 if @@RowCount>0
	set @returnValue = 1
	
	end
	
	
	select @returnValue
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRoleGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[Account_AccountDepartmentRoleGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT DepartmentRoleID, DepartmentRoleParentID, DepartmentRoleName FROM dbo.AccountDepartmentRole	
order by DepartmentRoleID
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRoleGetName]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-21
Description :获取部门角色名称
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentRoleGetName]

	(
	  @DepartmentRoleID int
	)

AS
SELECT  DepartmentRoleName,DepartmentRoleParentID  FROM dbo.AccountDepartmentRole where  DepartmentRoleID =@DepartmentRoleID

	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRoleModifyByDepartmentRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :根据DepartmentRoleID修改DepartmentRoleName
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentRoleModifyByDepartmentRoleID]

	(
		@DepartmentRoleID varchar(50),
		@DepartmentRoleName varchar(50)
	)

AS

UPDATE AccountDepartmentRole set DepartmentRoleName=@DepartmentRoleName where DepartmentRoleID=@DepartmentRoleID
--SELECT 1 FROM dbo.AccountDepartmentRole where DepartmentRoleName=@DepartmentRoleName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountDepartmentRolePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountDepartmentRolePK]

	(
		@DepartmentRoleName varchar(50)
	)

AS

SELECT 1 FROM dbo.AccountDepartmentRole where DepartmentRoleName=@DepartmentRoleName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountGetEmployeeUserRight]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-5-6
Description :返回指定用户 根据用户的编号(EmployeeID)返回其所有的资源；返回资源的内容由两个部分组成（1）、将用户表和AccountUserResource关联取出次用户的权限信息；（2）、根据当前用户的所属组找出这组的相关资源信息
*/

CREATE PROCEDURE [dbo].[Account_AccountGetEmployeeUserRight]

	(
		@EmployeeID varchar(50)
	)

AS

SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUserResource.UserResourceRight, 
      dbo.AccountResourceData.ResourcePath, dbo.AccountResourceData.ResourceName, 
      dbo.AccountResourceData.ResourceID, dbo.AccountResourceData.ResourceRemark, 
      dbo.AccountResourceData.ResourceTypeID, 
      dbo.AccountResourceData.ResourceIsBeControl, 
      dbo.AccountUser.UserDefinedRoleID, 
      dbo.AccountUserDefinedRole.UserDefinedRoleName, 
      dbo.AccountUserResource.UserResourceID
FROM dbo.AccountUser INNER JOIN
      dbo.AccountUserResource ON 
      dbo.AccountUser.EmployeeID = dbo.AccountUserResource.EmployeeID INNER JOIN
      dbo.AccountResourceData ON 
      dbo.AccountUserResource.ResourceID = dbo.AccountResourceData.ResourceID INNER
       JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID

where AccountUser.EmployeeID=@EmployeeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRoleAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountDepartmentRole表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountLevelRoleAdd]

	(
		@LevelRoleID varchar(50),
		@LevelRoleParentID varchar(50), 
		@LevelRoleName varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountLevelRole(LevelRoleID, LevelRoleParentID, LevelRoleName ) 
values(@LevelRoleID, @LevelRoleParentID, @LevelRoleName )	
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRoleDeleteByLevelRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountLevelRoleDeleteByLevelRoleID]

	(
		@LevelRoleID int
	)

AS
/* SET NOCOUNT ON */

	

	
	declare @returnValue bit
	
	set @returnValue = 0
	
	if (exists (select LevelRoleID from AccountLevelRole where LevelRoleParentID = @LevelRoleID))
	set @returnValue = 0
	
	else if (exists (select RoleID from AccountRoleCatalog where RoleID = @LevelRoleID and flag=2))
	set @returnValue = 0
	
	else
	begin
	
    Delete from AccountLevelRole where LevelRoleID=@LevelRoleID
	 if @@RowCount>0
	set @returnValue =1
	end
	
	select @returnValue
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRoleGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[Account_AccountLevelRoleGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT LevelRoleID, LevelRoleParentID, LevelRoleName 	FROM dbo.AccountLevelRole
order by LevelRoleID
	RETURN
	
GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRoleGetName]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-21
Description :获取级别角色名称
*/

CREATE PROCEDURE [dbo].[Account_AccountLevelRoleGetName]

	(
	  @LevelRoleID int
	)

AS

SELECT  LevelRoleName, LevelRoleParentID  	FROM dbo.AccountLevelRole where LevelRoleID=@LevelRoleID

	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRoleModifyByLevelRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :修改
*/

CREATE PROCEDURE [dbo].[Account_AccountLevelRoleModifyByLevelRoleID]

	(	
		@LevelRoleID varchar(50),
		@LevelRoleParentID varchar(50),
		@LevelRoleName varchar(50)
	)

AS

--SELECT LevelRoleID, LevelRoleParentID, LevelRoleName 	FROM dbo.AccountLevelRole

update AccountLevelRole set LevelRoleParentID=@LevelRoleParentID ,LevelRoleName=@LevelRoleName where  LevelRoleID =@LevelRoleID 
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountLevelRolePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountLevelRolePK]

	(
		@LevelRoleName varchar(50)
	)

AS

SELECT 1 FROM dbo.AccountLevelRole
	where LevelRoleName=@LevelRoleName 
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_AccountMenuAdd] 
	(
		@DefinedRoleID int, 
		@DefinedRoleParentID int, 
		@MenuName varchar(50)
	)

AS
--declare @userdefinedroleid int

INSERT INTO AccountMenu(DefinedRoleID,DefinedRoleParentID, MenuName) values(@DefinedRoleID,@DefinedRoleParentID, @MenuName)	

	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuAllResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_AccountMenuAllResource]

	

AS
/* SET NOCOUNT ON */

SELECT *	FROM dbo.AccountResourceData 
			
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuDefinedResourceAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountMenuDefinedResourceAdd]

	(
		@DefinedRoleID int, 
		@ResourceID int,
		@DefinedResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountMenuDefinedResource(DefinedRoleID, ResourceID,DefinedResourceRight) values(@DefinedRoleID, @ResourceID,@DefinedResourceRight)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuDefinedResourceDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Author      :xiaolinchen
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountMenuDefinedResourceDelete]

	(
		@DefinedRoleID int
	)

AS
/* SET NOCOUNT ON */

/*
declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountUserDefinedRole	 where UserDefinedRoleID in '+ @pkidstring

exec(@deletestring)	
	
	*/
	Delete from AccountMenuDefinedResource	 where DefinedRoleID=@DefinedRoleID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Account_AccountMenuDelete]

	(
		@pkidstring int
	)

AS
	Delete from AccountMenu	 where DefinedRoleID =@pkidstring or DefinedRoleParentID=@pkidstring
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuGetMain]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回所有自定义角色
*/

CREATE PROCEDURE [dbo].[Account_AccountMenuGetMain]  

	

AS
/* SET NOCOUNT ON */

SELECT DefinedRoleID, DefinedRoleParentID, MenuName, PKID, OrderID
FROM dbo.AccountMenu  order by  OrderID asc
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Creator:xiaolinchen
DateTime:2005-6-9
Description:修改AccountMenu
*/
CREATE PROCEDURE [dbo].[Account_AccountMenuModify]

(
				@DefinedRoleID   int,
				@MenuName varchar(50),
				@PKID int
)

AS
	DECLARE @OldDefinedRoleID int 
	
	BEGIN TRANSACTION
	
		
	Select @OldDefinedRoleID = DefinedRoleID  from AccountMenu where PKID=@PKID
	 
	UPDATE AccountMenu set DefinedRoleID=@DefinedRoleID , MenuName=@MenuName where PKID=@PKID
	
	UPDATE AccountMenu set DefinedRoleParentID = @DefinedRoleID where DefinedRoleParentID = @OldDefinedRoleID

             UPDATE AccountResourceData set SystemID=@DefinedRoleID where SystemID = @OldDefinedRoleID

	COMMIT TRANSACTION

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountMenuModifyByPKID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:xiaolinchen
 DateTime:2005-6-9
 Description:修改AccountMenu
*/
CREATE PROCEDURE [dbo].[Account_AccountMenuModifyByPKID]

(
				@DefinedRoleID   int,
				@DefinedRoleParentID   int,
				@MenuName varchar(50),
				@PKID int
)

AS
	DECLARE @OldDefinedRoleID int 
	
	BEGIN TRANSACTION

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRoleAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountDepartmentRole表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountRankRoleAdd]

	(
		@RankRoleID varchar(50), 
		@RankRoleParentID varchar(50), 
		@RankRoleName varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountRankRole(RankRoleID ,RankRoleParentID, RankRoleName) 
values(@RankRoleID ,@RankRoleParentID, @RankRoleName)	
	
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRoleDeleteByRankRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountRankRoleDeleteByRankRoleID]

	(
		@RankRoleID VARCHAR(50)
	)

AS
/* SET NOCOUNT ON */

	

	
	
	declare @returnValue bit
	set @returnValue = 0
	
	if exists (select RankRoleID from AccountRankRole where RankRoleParentID = @RankRoleID)
	 set @returnValue = 0
	 
	 else if (exists (select RoleID from AccountRoleCatalog where RoleID = @RankRoleID and flag=3))
	set @returnValue = 0
	else
	begin
	
  	Delete from AccountRankRole where RankRoleID=@RankRoleID
	 if @@RowCount>0
	set @returnValue =1
	end
	
	select @returnValue
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRoleGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_AccountRankRoleGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT RankRoleID, RankRoleParentID, RankRoleName FROM dbo.AccountRankRole
order by RankRoleID
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRoleGetName]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-21
Description :获取RankRoleName
*/

CREATE PROCEDURE [dbo].[Account_AccountRankRoleGetName]

	(
	  @RankRoleID int
	)

AS

SELECT  RankRoleName,RankRoleParentID  FROM AccountRankRole where  RankRoleID=@RankRoleID

	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRoleModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-7
Description :根据RankRoleID修改RankRoleName
*/

CREATE PROCEDURE [dbo].[Account_AccountRankRoleModify]

	(
		@RankRoleParentID varchar(50),
		@RankRoleName varchar(50),
		@RankRoleID varchar(50)
	)

AS

update AccountRankRole set RankRoleParentID=@RankRoleParentID,RankRoleName=@RankRoleName where RankRoleID=@RankRoleID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRankRolePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-7
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountRankRolePK]

	(
		@RankRoleName varchar(50)
	)

AS

SELECT 1 FROM dbo.AccountRankRole where RankRoleName=@RankRoleName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountResourceData表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataAdd]

	(
		@ResourcePath varchar(300), 
		@ResourceName varchar(300),
		@ResourceRemark varchar(300),
		@ResourceTypeID int
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountResourceData( ResourcePath,  ResourceName,  ResourceRemark,ResourceTypeID) values(@ResourcePath,  @ResourceName,  @ResourceRemark,@ResourceTypeID)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataAddMul]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountResourceData表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataAddMul]

	(
		@ResourcePath varchar(300), 
		@ResourceName varchar(300),
		@ResourceRemark varchar(300),
		@ResourceTypeID int,
		@ResourceIsBeControl char(10),
		@SystemID int,
		@IsActive bit,
		@DisplayName varchar(300),
		@OrderID int
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountResourceData( ResourcePath,  ResourceName,  ResourceRemark,ResourceTypeID,ResourceIsBeControl,SystemID,IsActive,DisplayName,OrderID) values(@ResourcePath,  @ResourceName,  @ResourceRemark,@ResourceTypeID,@ResourceIsBeControl,@SystemID,@IsActive,@DisplayName,@OrderID)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除资源--批量删除
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataDelete]

	(
		@parmPKID varchar(1000)
	)

AS
/* SET NOCOUNT ON */


	declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountResourceData	 where ResourceID in '+ @parmPKID

exec(@deletestring)	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataModify]

	(
		@ResourcePath varchar(300), 
		@ResourceName varchar(300), 
		@ResourceRemark varchar(300),
		@ResourceTypeID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	ResourcePath=@ResourcePath,ResourceRemark=@ResourceRemark,ResourceTypeID=@ResourceTypeID
	 where ResourceName=@ResourceName
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataModifyByDisplayName]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Author      :tang
Date        :2005-6-8
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataModifyByDisplayName]

	(
		@ResourceID int,
		@SystemID int, 
		@DisplayName varchar(300)
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	DisplayName =@DisplayName ,SystemID=@SystemID
	 where ResourceID=@ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataModifyByResourceID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Author      :tang
Date        :2005-6-8
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataModifyByResourceID]

	(
		@ResourceID int,
		@DisplayName varchar(300)
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	DisplayName =@DisplayName 
	 where ResourceID=@ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataModifyMul]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataModifyMul]

	(
		@ResourcePath varchar(300), 
		@ResourceName varchar(300),
		@ResourceRemark varchar(300),
		@ResourceTypeID int,
		@ResourceIsBeControl varchar(10),
		@SystemID int,
		@IsActive bit,
		@DisplayName varchar(300),
		@ResourceID int,
		@OrderID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	ResourcePath=@ResourcePath,ResourceName=@ResourceName,ResourceRemark=@ResourceRemark,ResourceTypeID=@ResourceTypeID,ResourceIsBeControl=@ResourceIsBeControl,SystemID=@SystemID,IsActive=@IsActive,DisplayName=@DisplayName,OrderID=@OrderID
	 where ResourceID=@ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataRemoveByResourceID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Author      :tang
Date        :2005-6-8
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataRemoveByResourceID]

	(
		@ResourceID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	SystemID=-1
	 where ResourceID=@ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataRemoveBySystemID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Author      :tang
Date        :2005-6-8
Description :修改资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataRemoveBySystemID]
	(
		@SystemID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountResourceData SET 
	SystemID=-1
	 where SystemID=@SystemID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataSetBarring]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaoinchen	
Date        :2005-4-24
Description :设置那些资源需要被排除
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataSetBarring]

	(
		@ResourceID int, 
		
		@ResourceIsBeControl varchar(10)
	)

AS
/* SET NOCOUNT ON */

update AccountResourceData set ResourceIsBeControl =@ResourceIsBeControl where ResourceID = @ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceDataSetDisplay]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaoinchen	
Date        :2005-4-24
Description :设置那些资源需要被排除
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceDataSetDisplay]

	(
		@ResourceID int, 
		
		@IsDisplay bit
	)

AS
/* SET NOCOUNT ON */

update AccountResourceData set IsDisplay =@IsDisplay where ResourceID = @ResourceID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回所有资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT ResourceID, ResourcePath, ResourceName, ResourceRemark,ResourceTypeID 	FROM dbo.AccountResourceData
			
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetAllByControl]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen	
Date        :2005-4-26
Description :根据是否受控返回所有资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetAllByControl]

	

AS
/* SET NOCOUNT ON */

SELECT ResourceID, ResourcePath, ResourceName, ResourceRemark,ResourceTypeID,SystemID,IsActive,DisplayName	FROM dbo.AccountResourceData where ResourceIsBeControl='是'
			
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetAllByNoControl]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen	
Date        :2005-4-26
Description :根据是否受控返回所有资源
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetAllByNoControl]

	

AS
/* SET NOCOUNT ON */

SELECT ResourceID, ResourcePath, ResourceName, ResourceRemark,ResourceTypeID 	FROM dbo.AccountResourceData where ResourceIsBeControl='否'
			
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetAllRel]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen	
Date        :2005-4-26 
Description :返回所有资源
modify      :chenxiaolin
Date        :2005-6-9
Modify      :chenxiaolin
Date        :2005-8-3
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetAllRel]

	

AS
/* SET NOCOUNT ON */

SELECT dbo.AccountResourceType.ResourceTypeName, 
      dbo.AccountResourceType.ResourceTypePath, 
      dbo.AccountResourceData.ResourceID, dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName,dbo.AccountResourceData.IsDisplay, 
      dbo.AccountResourceData.ResourceRemark, 
      dbo.AccountResourceData.ResourceIsBeControl, 
      dbo.AccountResourceData.ResourceTypeID, dbo.AccountResourceData.SystemID, 
      dbo.AccountResourceData.IsActive, dbo.AccountResourceData.DisplayName, 
      dbo.AccountResourceData.OrderID, dbo.AccountMenu.MenuName
FROM dbo.AccountResourceData INNER JOIN
      dbo.AccountResourceType ON 
      dbo.AccountResourceData.ResourceTypeID = dbo.AccountResourceType.ResourceTypeID
       INNER JOIN
      dbo.AccountMenu ON 
      dbo.AccountResourceData.SystemID = dbo.AccountMenu.DefinedRoleID order by dbo.AccountResourceData.OrderID  asc
			
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetByActive]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen	
Date        :2005-6-9
Description :返回所有资源，根据是否动态
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetByActive]
(
   @IsActive bit
)
	

AS
/* SET NOCOUNT ON */

SELECT  
      dbo.AccountResourceData.ResourceID, dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName, 
      dbo.AccountResourceData.ResourceRemark, 
      dbo.AccountResourceData.ResourceIsBeControl, 
      dbo.AccountResourceData.ResourceTypeID,
      dbo.AccountResourceData.SystemID,
      dbo.AccountResourceData.IsActive,
      dbo.AccountResourceData.DisplayName
FROM dbo.AccountResourceData 
where IsActive = @IsActive
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetMenuByIsDisplay]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_AccountResourceGetMenuByIsDisplay]



AS
/* SET NOCOUNT ON */

SELECT SitePrefix , SystemID,ResourceID,DisplayName,ResourceRemark,ResourcePath,ResourceName,OrderID 
FROM dbo.AccountResourceData where IsDisplay=1 order by SystemID,OrderID asc 
 

RETURN
GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceGetSpec]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen	
Date        :2005-6-9
Description :返回所有资源，返回所有字段
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceGetSpec]
(
   @ResourceID int
)
	

AS
/* SET NOCOUNT ON */

SELECT dbo.AccountResourceType.ResourceTypeName, 
      dbo.AccountResourceType.ResourceTypePath, 
      dbo.AccountResourceData.ResourceID, dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName, 
      dbo.AccountResourceData.ResourceRemark, 
      dbo.AccountResourceData.ResourceIsBeControl, 
      dbo.AccountResourceData.ResourceTypeID,
      dbo.AccountResourceData.SystemID,
      dbo.AccountResourceData.IsActive,
      dbo.AccountResourceData.DisplayName,
      dbo.AccountResourceData.OrderID
FROM dbo.AccountResourceData INNER JOIN
      dbo.AccountResourceType ON 
      dbo.AccountResourceData.ResourceTypeID = dbo.AccountResourceType.ResourceTypeID
where dbo.AccountResourceData.ResourceID = @ResourceID order by OrderID asc 
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourcePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountResourcePK]

	(
		@ResourcePath varchar(300),
		@ResourceName varchar(300)
	)

AS

SELECT 1 FROM dbo.AccountResourceData
	where ResourcePath=@ResourcePath and ResourceName=@ResourceName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypeAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountResourceType表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypeAdd]

	(
		@ResourceTypeParentID int, 
		@ResourceTypeName varchar(50),
		@ResourceTypePath varchar(300)
	)

AS
--declare @userdefinedroleid int
--SELECT FileID, MailID, FileName, FileSize, FileAttribute, FileVisualPath, FileAuthor, FileCatlog, FileAddedDate FROM dbo.MailAttachFiles

INSERT INTO AccountResourceType(ResourceTypeParentID, ResourceTypeName, ResourceTypePath) values(@ResourceTypeParentID, @ResourceTypeName,@ResourceTypePath)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
	select max(ResourceTypeID) ResourceTypeID from AccountResourceType 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypeDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypeDelete]

	(
		@ResourceTypeID int
	)

AS
/* SET NOCOUNT ON */

	
	Delete from AccountResourceType where ResourceTypeID=@ResourceTypeID OR ResourceTypeParentID=@ResourceTypeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypeGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :返回所有自定义角色
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypeGetAll]


AS
/* SET NOCOUNT ON */

SELECT ResourceTypeID, ResourceTypeParentID, ResourceTypeName, 	ResourceTypePath		FROM dbo.AccountResourceType

	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypeGetResourceTypeIDByResourceTypePath]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :根据ResourceTypePath返回ResourceTypeID；
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypeGetResourceTypeIDByResourceTypePath]

	(
	@ResourceTypePath varchar(300)
	)

AS
/* SET NOCOUNT ON */
SELECT ResourceTypeID, ResourceTypeParentID, ResourceTypeName, 	ResourceTypePath FROM dbo.AccountResourceType
where ResourceTypePath=@ResourceTypePath

	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypeModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-7
Description :根据ResourceTypeID修改资源类型
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypeModify]

	(
		@ResourceTypeParentID int,
		@ResourceTypeName varchar(50),
		@ResourceTypePath varchar(50),
		@ResourceTypeID int
	)

AS
/* SET NOCOUNT ON */
--SELECT ResourceTypeID, ResourceTypeParentID, ResourceTypeName, 	ResourceTypePath		FROM dbo.AccountResourceType

UPDATE AccountResourceType set ResourceTypeParentID=@ResourceTypeParentID,ResourceTypeName=@ResourceTypeName, ResourceTypePath=@ResourceTypePath where ResourceTypeID=@ResourceTypeID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountResourceTypePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :测试是否在表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountResourceTypePK]

	(
		@ResourceTypeName varchar(50)
	)

AS

SELECT 1 FROM dbo.AccountResourceType where ResourceTypeName=@ResourceTypeName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRoleCatalogAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-22
Description :测试是否在AccountRoleCatalog表中添加记录
*/

CREATE PROCEDURE [dbo].[Account_AccountRoleCatalogAdd]

	(
		@EmployeeID varchar(50),
		@RoleID varchar(50),
		@Flag int
	)

AS

SET NOCOUNT ON 
begin tran
declare @ReturnValue bit

if @Flag = 1
begin
	if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and DepartmentRoleID=@RoleID)
	begin
		set @ReturnValue = 0
	end
	else
	begin
		if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and DepartmentRoleID=1)
		begin
			update AccountUser set DepartmentRoleID=@RoleID where EmployeeID=@EmployeeID
			set @ReturnValue = 1
		end
		else
		begin
			if exists(select EmployeeID from AccountRoleCatalog where EmployeeID=@EmployeeID and RoleID=@RoleID and Flag=@Flag)
			begin
				set @ReturnValue = 0
			end
			else
			begin
				insert into AccountRoleCatalog(EmployeeID, RoleID, Flag) values(@EmployeeID, @RoleID, @Flag)
				set @ReturnValue = 1
			end
		end
	end
end
if @Flag = 2
begin
	if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and LevelRoleID=@RoleID)
	begin
		set @ReturnValue = 0
	end
	else
	begin
		if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and LevelRoleID=1)
		begin
			update AccountUser set LevelRoleID=@RoleID where EmployeeID=@EmployeeID
			set @ReturnValue = 1
		end
		else
		begin
			if exists(select EmployeeID from AccountRoleCatalog where EmployeeID=@EmployeeID and RoleID=@RoleID and Flag=@Flag)
			begin
				set @ReturnValue = 0
			end
			else
			begin
				insert into AccountRoleCatalog(EmployeeID, RoleID, Flag) values(@EmployeeID, @RoleID, @Flag)
				set @ReturnValue = 1
			end
		end
	end
end
if @Flag =3
begin
	if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and RankRoleID=@RoleID)
	begin
		set @ReturnValue = 0
	end
	else
	begin
		if exists(select EmployeeID from AccountUser where EmployeeID=@EmployeeID and RankRoleID=1)
		begin
			update AccountUser set RankRoleID=@RoleID where EmployeeID=@EmployeeID
			set @ReturnValue = 1
		end
		else
		begin
			if exists(select EmployeeID from AccountRoleCatalog where EmployeeID=@EmployeeID and RoleID=@RoleID and Flag=@Flag)
			begin
				set @ReturnValue = 0
			end
			else
			begin
				insert into AccountRoleCatalog(EmployeeID, RoleID, Flag) values(@EmployeeID, @RoleID, @Flag)
				set @ReturnValue = 1
			end
		end
	end
end

if @@error!= 0
	rollback
	
commit tran


select @ReturnValue
SET NOCOUNT OFF
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRoleCatalogDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-22
Description :删除记录，与AcccountUser表关联，现在表AccountRoleCatalog找是否有记录，有则删之，无则将AcccountUser中的相关记录的自动置为1--存储过程实现
*/

CREATE PROCEDURE [dbo].[Account_AccountRoleCatalogDelete]

	(
		@EmployeeID varchar(50),
		@RoleID varchar(50),
		@Flag int
	)

AS

--SELECT EmployeeID, RoleID, Flag	FROM AccountRoleCatalog
SET NOCOUNT ON 
begin tran
declare @ReturnValue bit

if exists(SELECT EmployeeID	FROM AccountRoleCatalog where EmployeeID=@EmployeeID and RoleID=@RoleID and Flag=@Flag)
	begin
		delete from  AccountRoleCatalog where EmployeeID=@EmployeeID and RoleID=@RoleID and Flag=@Flag
		set @ReturnValue = 1
	end
else
	begin
		if @Flag = 1
		begin
		if exists(SELECT EmployeeID	FROM AccountRoleCatalog where EmployeeID=@EmployeeID and Flag=1)
		set @ReturnValue = 0
		else
		
			begin
				update AccountUser set DepartmentRoleID=null where EmployeeID=@EmployeeID
				set @ReturnValue = 1
			end
		end
		else if @Flag = 2
			begin
		if exists(SELECT EmployeeID	FROM AccountRoleCatalog where EmployeeID=@EmployeeID and Flag=2)
		set @ReturnValue = 0
		else
		
			begin
				update AccountUser set LevelRoleID=null where EmployeeID=@EmployeeID
				set @ReturnValue = 1
			end
		end
		else if @Flag = 3
			begin
		if exists(SELECT EmployeeID	FROM AccountRoleCatalog where EmployeeID=@EmployeeID and Flag=3)
		set @ReturnValue = 0
		else
		
			begin
				update AccountUser set RankRoleID=null where EmployeeID=@EmployeeID
				set @ReturnValue = 1
			end
		end
	end
if @@error!= 0
	rollback
	
commit tran


select @ReturnValue
SET NOCOUNT OFF
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRoleCatalogGetRoleByFlag]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:ayong
 DateTime:2004.12.27
 Description:由flag返回Role信息
*/
CREATE PROCEDURE [dbo].[Account_AccountRoleCatalogGetRoleByFlag]

	(
		@flag int
		
	)

AS
	/* SET NOCOUNT ON */

SELECT  dbo.AccountUser.EmployeeID,EmployeeName,
       case @flag
       when 1 then  dbo.AccountUser.DepartmentRoleID
       when 2 then  dbo.AccountUser.LevelRoleID
       when 3 then  dbo.AccountUser.RankRoleID
       end  RoleID
FROM dbo.AccountUser

UNION 
SELECT dbo.AccountRoleCatalog.EmployeeID,AccountUser.EmployeeName, dbo.AccountRoleCatalog.RoleID AS DepartmentRoleID
FROM dbo.AccountRoleCatalog,AccountUser
WHERE dbo.AccountRoleCatalog.Flag = @flag  and AccountUser.EmployeeID = AccountRoleCatalog.EmployeeID
order by  case @flag
       when 1 then  dbo.AccountUser.DepartmentRoleID
       when 2 then  dbo.AccountUser.LevelRoleID
       when 3 then  dbo.AccountUser.RankRoleID
       end
	     
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRoleCatalogGetRoleByFlagRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:xiaolin
 DateTime:2004.12.27
 Description:由flag返回Role信息
*/
CREATE PROCEDURE [dbo].[Account_AccountRoleCatalogGetRoleByFlagRoleID]

	(
		@flag int,
		@RoleID int
		
	)

AS
	/* SET NOCOUNT ON */

SELECT  dbo.AccountUser.EmployeeID,EmployeeName,
       case @flag
       when 1 then  dbo.AccountUser.DepartmentRoleID
       when 2 then  dbo.AccountUser.LevelRoleID
       when 3 then  dbo.AccountUser.RankRoleID
       end  RoleID
FROM dbo.AccountUser 
where case @flag
       when 1 then  dbo.AccountUser.DepartmentRoleID
       when 2 then  dbo.AccountUser.LevelRoleID
       when 3 then  dbo.AccountUser.RankRoleID
       end = @RoleID

UNION 
SELECT dbo.AccountRoleCatalog.EmployeeID,AccountUser.EmployeeName, dbo.AccountRoleCatalog.RoleID
FROM dbo.AccountRoleCatalog,AccountUser
WHERE dbo.AccountRoleCatalog.Flag = @flag  and AccountUser.EmployeeID = AccountRoleCatalog.EmployeeID and AccountRoleCatalog.RoleID = @RoleID


/* order by  case @flag
       when 1 then  dbo.AccountUser.DepartmentRoleID
       when 2 then  dbo.AccountUser.LevelRoleID
       when 3 then  dbo.AccountUser.RankRoleID
       end
	     
	 */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountRoleCatalogPK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-22
Description :测试是否在AccountRoleCatalog表中插入重复值
*/

CREATE PROCEDURE [dbo].[Account_AccountRoleCatalogPK]

	(
		@EmployeeID varchar(50),
		@RoleID int,
		@Flag int
	)

AS

--SELECT EmployeeID, RoleID, Flag	FROM AccountRoleCatalog
SELECT 1 FROM AccountRoleCatalog where EmployeeID=@EmployeeID and  RoleID=@RoleID and Flag=@Flag

	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author      :jkliu
Date        :2004-12-3
Description :添加用户
*/

CREATE PROCEDURE [dbo].[Account_AccountUserAdd]

	(
		@EmployeeID varchar(50), 
		@EmployeeName varchar(50), 
		@UserID varchar(50), 
		@UserPass varchar(50), 
		@DepartmentRoleID varchar(50), 
		@LevelRoleID varchar(50), 
		@RankRoleID varchar(50), 
		@UserDefinedRoleID varchar(50)	,
			@PositionStatus  varchar(10),
			@Order int
	)

AS

INSERT INTO 
	AccountUser(EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID,PositionStatus ,[Order]) 
	Values(@EmployeeID, @EmployeeName, @UserID, @UserPass, @DepartmentRoleID, @LevelRoleID, @RankRoleID, @UserDefinedRoleID,@PositionStatus,@Order)	
	/* SET NOCOUNT ON */
	RETURN


GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedAddResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedAddResource]

	(
		@UserDefinedRoleID int, 
		@ResourceID int,
		@UserDefinedResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountUserDefinedResource(UserDefinedRoleID, ResourceID,UserDefinedResourceRight) values(@UserDefinedRoleID, @ResourceID,@UserDefinedResourceRight)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :测试是否在表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResource]

	(
		@UserDefinedRoleID varchar(50),
		@ResourceID int 
	)

AS

SELECT COUNT(1) FROM dbo.AccountUserDefinedResource where UserDefinedRoleID=@UserDefinedRoleID AND ResourceID=@ResourceID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResourceAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :添加AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResourceAdd]

	(
		@UserDefinedRoleID varchar(50), 
		@ResourceID int,
		@UserDefinedResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountUserDefinedResource(UserDefinedRoleID, ResourceID,UserDefinedResourceRight) values(@UserDefinedRoleID, @ResourceID,@UserDefinedResourceRight)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResourceDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-10-16
Description :删除AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResourceDelete]

	(
		@UserDefinedRoleID varchar(50), 
		@ResourceID int
	)

AS
--declare @userdefinedroleid int


delete from AccountUserDefinedResource where UserDefinedRoleID=@UserDefinedRoleID and ResourceID=@ResourceID
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResourceGetByCons]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :当flag=1根据UserDefinedRoleID返回记录；当flag=2根据ResourceID返回记录；
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResourceGetByCons]
(
	@chooseParm varchar(50),
	@flag int
)
	

AS
/* SET NOCOUNT ON */

if(@flag=1)
	begin
		SELECT dbo.AccountUserDefinedResource.UserDefinedResourceID, 
      dbo.AccountUserDefinedResource.UserDefinedRoleID, 
      dbo.AccountUserDefinedResource.ResourceID, 
      dbo.AccountUserDefinedResource.UserDefinedResourceRight, 
      dbo.AccountResourceData.ResourceName,
      dbo.AccountResourceData.ResourcePath
FROM dbo.AccountUserDefinedResource INNER JOIN
      dbo.AccountResourceData ON 
      dbo.AccountUserDefinedResource.ResourceID = dbo.AccountResourceData.ResourceID
		WHERE UserDefinedRoleID=@chooseParm
	end
else if(@flag=2)
	begin 
		declare @p int
		set @p = convert( int,@chooseParm )
		SELECT UserDefinedResourceID, UserDefinedRoleID, ResourceID,UserDefinedResourceRight	FROM dbo.AccountUserDefinedResource
		WHERE ResourceID=@p
	end

	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResourceModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-10-16
Description :修改AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResourceModify]

	(
		@UserDefinedRoleID int, 
		@ResourceID int,
		@UserDefinedResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int


update AccountUserDefinedResource set UserDefinedResourceRight=@UserDefinedResourceRight where UserDefinedRoleID=@UserDefinedRoleID and ResourceID=@ResourceID
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedResourceUpsert]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-10-16
Description :修改AccountUserDefinedResource表记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedResourceUpsert]

	(
		@UserDefinedRoleID varchar(50), 
		@ResourceID int,
		@UserDefinedResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int
if @UserDefinedResourceRight = '00000'
begin
	delete AccountUserDefinedResource where UserDefinedRoleID=@UserDefinedRoleID and ResourceID=@ResourceID
	return
end
if EXISTS (select 1 from AccountUserDefinedResource where UserDefinedRoleID=@UserDefinedRoleID and ResourceID=@ResourceID)
	update AccountUserDefinedResource set UserDefinedResourceRight=@UserDefinedResourceRight where UserDefinedRoleID=@UserDefinedRoleID and ResourceID=@ResourceID
else
	insert into AccountUserDefinedResource(UserDefinedRoleID,ResourceID ,UserDefinedResourceRight)
		values(@UserDefinedRoleID,@ResourceID,@UserDefinedResourceRight)
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	
--	select max(DepartmentRoleID) DepartmentRoleID from AccountDepartmentRole 
	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRoleAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRoleAdd] 
	(
		@UserDefinedRoleID varchar(50),
		@UserDefinedRoleParentID varchar(50), 
		@UserDefinedRoleName varchar(50)
	)

AS
--declare @userdefinedroleid int


INSERT INTO AccountUserDefinedRole(UserDefinedRoleID,UserDefinedRoleParentID, UserDefinedRoleName) values(@UserDefinedRoleID,@UserDefinedRoleParentID, @UserDefinedRoleName)	
	/* SET NOCOUNT ON */
--set @userdefinedroleid=(select @@IDENTITY)	

	
	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRoleDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :删除用户自定义角色--根据UserDefinedRoleID删除，条件为UserDefinedRoleID=@UserDefinedRoleID或者UserDefinedRoleParentID=@UserDefinedRoleID
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRoleDelete]

	(
		@pkidstring varchar(50)
	)

AS
/* SET NOCOUNT ON */

/*
declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountUserDefinedRole	 where UserDefinedRoleID in '+ @pkidstring

exec(@deletestring)	
	
	*/
	Delete from AccountUserDefinedRole	 where UserDefinedRoleID =@pkidstring or UserDefinedRoleParentID=@pkidstring
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRoleGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回所有自定义角色
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRoleGetAll]

	

AS
/* SET NOCOUNT ON */

SELECT UserDefinedRoleID, UserDefinedRoleParentID, UserDefinedRoleName FROM dbo.AccountUserDefinedRole
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRoleGetSpecial]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回指定用户
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRoleGetSpecial]

	(
		@UserDefinedRoleID int
	)

AS
/* SET NOCOUNT ON */

SELECT UserDefinedRoleID, UserDefinedRoleParentID, UserDefinedRoleName FROM dbo.AccountUserDefinedRole
where UserDefinedRoleID=@UserDefinedRoleID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRoleModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :修改用户自定义角色
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRoleModify]

	(
		@UserDefinedRoleID varchar(50), 
		@UserDefinedRoleParentID varchar(50), 
		@UserDefinedRoleName varchar(50)
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountUserDefinedRole set UserDefinedRoleParentID=@UserDefinedRoleParentID, UserDefinedRoleName=@UserDefinedRoleName where UserDefinedRoleID=@UserDefinedRoleID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDefinedRolePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDefinedRolePK]

	(
		@UserDefinedRoleID int
	)

AS

SELECT 1 FROM dbo.AccountUserDefinedRole where UserDefinedRoleID=@UserDefinedRoleID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :删除用户(删除用户时候，将AccountUserResource中对应记录也作删除)
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDelete]

	(
		@pkidstring varchar(500)
	)

AS
/* SET NOCOUNT ON */

begin tran

declare @deletestring varchar(5000)
declare @deletestring2 varchar(5000)

set @deletestring = ' Delete from AccountUser	 where EmployeeID in '+ @pkidstring
set @deletestring2 = ' delete from accountuserresource where employeeid in '+ @pkidstring

exec(@deletestring)	
exec(@deletestring2)
	
	if @@error!=0 --or @@rowcount=0
		rollback tran
commit tran
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserDepartmentGetByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :hanan
Date        :2008-10-25
Description :  
*/

CREATE PROCEDURE [dbo].[Account_AccountUserDepartmentGetByEmployeeID] 
	
	(
		@EmployeeID varchar(50)
	)
AS
	 SELECT AccountDepartmentRole.DepartmentRoleName
	 FROM AccountDepartmentRole INNER JOIN
	       AccountUser ON 
	       AccountDepartmentRole.DepartmentRoleID = AccountUser.DepartmentRoleID where EmployeeID=@EmployeeID
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetAccountuserByCons]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description : 分别根据DepartmentRoleID、LevelRoleID、RankRoleID、UserDefinedRoleID，返回所有用户列表,当flag=1时，根据DepartmentRoleID返回用户列表，当flag=2时，根据LevelRoleID返回用户列表，当flag=3时，根据RankRoleID返回用户列表,当flag=4时，根据UserDefinedRoleID返回用户列表
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetAccountuserByCons]

	(
		@chooseParm int,
		@flag varchar(10)
	)

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
	if(@flag='1')
		begin
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID, 
      dbo.AccountDepartmentRole.DepartmentRoleName, 
      dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
      dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
      dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
FROM dbo.AccountUser INNER JOIN
      dbo.AccountDepartmentRole ON 
      dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
       JOIN
      dbo.AccountLevelRole ON 
      dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
      dbo.AccountRankRole ON 
      dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
      
      where AccountUser.DepartmentRoleID=@chooseParm 
		end
	else if(@flag='2')
		begin 
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.LevelRoleID=@chooseParm
		end
	else if(@flag='3')
		begin
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.RankRoleID=@chooseParm
		end
	else if(@flag='4')
		begin 
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.UserDefinedRoleID=@chooseParm
		end	
      
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[Account_AccountUserGetAll]

	

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
SELECT AccountUser.EmployeeID, AccountUser.EmployeeName, AccountUser.UserID, 
      AccountUser.UserPass, AccountUser.DepartmentRoleID, 
      AccountDepartmentRole.DepartmentRoleName, AccountUser.LevelRoleID, 
      AccountLevelRole.LevelRoleName, AccountUser.RankRoleID, 
      AccountRankRole.RankRoleName, AccountUser.UserDefinedRoleID, 
      AccountUserDefinedRole.UserDefinedRoleName,AccountUser.IPAddress,AccountUser.[Order],
	  AccountUser.PositionStatus
FROM AccountUser INNER JOIN
      AccountDepartmentRole ON 
      AccountUser.DepartmentRoleID = AccountDepartmentRole.DepartmentRoleID INNER JOIN
      AccountLevelRole ON 
      AccountUser.LevelRoleID = AccountLevelRole.LevelRoleID INNER JOIN
      AccountRankRole ON 
      AccountUser.RankRoleID = AccountRankRole.RankRoleID INNER JOIN
      AccountUserDefinedRole ON 
      AccountUser.UserDefinedRoleID = AccountUserDefinedRole.UserDefinedRoleID 
        order by AccountUser.UserDefinedRoleID, AccountUser.EmployeeName 
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetAllAccountUser]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回所有用户
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetAllAccountUser]

	

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
SELECT AccountUser.EmployeeID, AccountUser.EmployeeName, AccountUser.UserID, 
      AccountUser.UserPass, AccountUser.DepartmentRoleID, 
      AccountDepartmentRole.DepartmentRoleName, AccountUser.LevelRoleID, 
      AccountLevelRole.LevelRoleName, AccountUser.RankRoleID, 
      AccountRankRole.RankRoleName, AccountUser.UserDefinedRoleID, 
      AccountUserDefinedRole.UserDefinedRoleName,AccountUser.IPAddress
FROM AccountUser INNER JOIN
      AccountDepartmentRole ON 
      AccountUser.DepartmentRoleID = AccountDepartmentRole.DepartmentRoleID INNER JOIN
      AccountLevelRole ON 
      AccountUser.LevelRoleID = AccountLevelRole.LevelRoleID INNER JOIN
      AccountRankRole ON 
      AccountUser.RankRoleID = AccountRankRole.RankRoleID INNER JOIN
      AccountUserDefinedRole ON 
      AccountUser.UserDefinedRoleID = AccountUserDefinedRole.UserDefinedRoleID 
      
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetAllForOther]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2007-3-19
Description :返回所有用户给其他公司，返回用户名，编号，部门编号，部门名称
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetAllForOther]

	

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
SELECT AccountUser.EmployeeID, AccountUser.EmployeeName, AccountUser.DepartmentRoleID,  AccountUser.UserDefinedRoleID,UserDefinedRoleName,
      AccountDepartmentRole.DepartmentRoleName
FROM AccountUser INNER JOIN
      AccountDepartmentRole ON 
      AccountUser.DepartmentRoleID = AccountDepartmentRole.DepartmentRoleID inner join AccountUserDefinedRole on 
       AccountUser.UserDefinedRoleID = AccountUserDefinedRole.UserDefinedRoleID
      
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetByCons]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description : 分别根据DepartmentRoleID、LevelRoleID、RankRoleID、UserDefinedRoleID，返回所有用户列表,当flag=1时，根据DepartmentRoleID返回用户列表，当flag=2时，根据LevelRoleID返回用户列表，当flag=3时，根据RankRoleID返回用户列表,当flag=4时，根据UserDefinedRoleID返回用户列表
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetByCons]

	(
		@chooseParm int,
		@flag varchar(10)
	)

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
	if(@flag='1')
		begin
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID, 
      dbo.AccountDepartmentRole.DepartmentRoleName, 
      dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
      dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
      dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
FROM dbo.AccountUser INNER JOIN
      dbo.AccountDepartmentRole ON 
      dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
       JOIN
      dbo.AccountLevelRole ON 
      dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
      dbo.AccountRankRole ON 
      dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
      
      where AccountUser.DepartmentRoleID=@chooseParm 
		end
	else if(@flag='2')
		begin 
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.LevelRoleID=@chooseParm
		end
	else if(@flag='3')
		begin
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.RankRoleID=@chooseParm
		end
	else if(@flag='4')
		begin 
			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
		dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
		dbo.AccountUser.DepartmentRoleID, 
		dbo.AccountDepartmentRole.DepartmentRoleName, 
		dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
		dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 

		dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName
	FROM dbo.AccountUser INNER JOIN
		dbo.AccountDepartmentRole ON 
		dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
		JOIN
		dbo.AccountLevelRole ON 
		dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
		dbo.AccountRankRole ON 
		dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
		dbo.AccountUserDefinedRole ON 
		dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
			where AccountUser.UserDefinedRoleID=@chooseParm
		end	
      
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetByCons2]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[Account_AccountUserGetByCons2] 
	 
	(
	@UserName varchar(50),
	@UserDefinedRoleID varchar(50),
	@DepartmentRoleID varchar(50),
	@RankRoleID varchar(50),
	@PositionStatus  varchar(10)
	)
	 
AS
	 			SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID,  dbo.AccountUser.PositionStatus ,dbo.AccountUser.[Order] ,
      dbo.AccountDepartmentRole.DepartmentRoleName, 
      dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, 
      dbo.AccountUser.LevelRoleID, dbo.AccountUserDefinedRole.UserDefinedRoleName, 
      dbo.AccountRankRole.RankRoleName, dbo.AccountLevelRole.LevelRoleName,dbo.AccountUser.LastLoginTime,dbo.AccountUser.IPAddress 
FROM dbo.AccountUser LEFT JOIN
      dbo.AccountDepartmentRole ON 
      dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID LEFT
       JOIN
      dbo.AccountLevelRole ON 
      dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID LEFT JOIN
      dbo.AccountRankRole ON 
      dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID LEFT JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
      
      where AccountUser.DepartmentRoleID=
		case 
		     when @DepartmentRoleID <> 'null' 
		     then @DepartmentRoleID 
			 else AccountUser.DepartmentRoleID
		end
         and dbo.AccountUser.UserDefinedRoleID=
		case 
			when  @UserDefinedRoleID<>'null' 
			then @UserDefinedRoleID 
			else AccountUser.UserDefinedRoleID 
		end
          and dbo.AccountUser.RankRoleID = 
		  case 
				when @RankRoleID<>'null'
				then @RankRoleID 
				else AccountUser.RankRoleID 
		  end
		   and dbo.AccountUser.PositionStatus  = 
		  case 
				when @PositionStatus<>'null'
				then @PositionStatus
				else AccountUser.PositionStatus 
		  end
		 
          and (AccountUser.EmployeeName like '%'+@UserName+'%' or AccountUser.EmployeeID=@UserName )
		  order by dbo.AccountUser.[Order]
		  print  @PositionStatus 
	RETURN




GO
/****** Object:  StoredProcedure [dbo].[Account_AccountuserGetEmployeeIDNameByEmployees]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:ayong
 DateTime:2004.12.27
 Description:根据FlowRunDealID，修改FlowRunCompleteTime，IsComplete
*/
CREATE PROCEDURE [dbo].[Account_AccountuserGetEmployeeIDNameByEmployees]

	(
		@Employees varchar(250)
		
		
	)

AS
	/* SET NOCOUNT ON */
	
	declare @sql varchar(300)
	 set @sql = ' select EmployeeID,EmployeeName	from Accountuser	where	EmployeeID in  '
	
	set  @sql = @sql + @Employees
	
	exec(@sql)
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetEmployeeRight]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回指定用户 根据用户的编号(EmployeeID)返回其所有的资源；返回资源的内容由两个部分组成（1）、将用户表和AccountUserResource关联取出次用户的权限信息；（2）、根据当前用户的所属组找出这组的相关资源信息
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetEmployeeRight]

	(
		@EmployeeID varchar(50)
	)

AS

SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUserResource.UserResourceRight, 
      dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName,dbo.AccountResourceData.ResourceID
FROM dbo.AccountUser INNER JOIN
      dbo.AccountUserResource ON 
      dbo.AccountUser.EmployeeID = dbo.AccountUserResource.EmployeeID INNER JOIN
      dbo.AccountResourceData ON 
      dbo.AccountUserResource.ResourceID = dbo.AccountResourceData.ResourceID

where AccountUser.EmployeeID=@EmployeeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetSpecial]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :返回指定用户 根据用户的编号(EmployeeID)返回其所有的资源；返回资源的内容由两个部分组成（1）、将用户表和AccountUserResource关联取出次用户的权限信息；（2）、根据当前用户的所属组找出这组的相关资源信息
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetSpecial]

	(
		@EmployeeID varchar(50)
	)

AS
/* SET NOCOUNT ON */

--SELECT EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	FROM dbo.AccountUser
--where EmployeeID=@EmployeeID
/*
	SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID, dbo.AccountUser.LevelRoleID, 
      dbo.AccountUser.RankRoleID, dbo.AccountUser.UserDefinedRoleID, 
      dbo.AccountUserDefinedRole.UserDefinedRoleName, 
      dbo.AccountUserDefinedResource.UserDefinedResourceRight, 
      dbo.AccountUserResource.UserResourceRight
FROM dbo.AccountUser INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
       INNER JOIN
      dbo.AccountUserDefinedResource ON 
      dbo.AccountUserDefinedRole.UserDefinedRoleID = dbo.AccountUserDefinedResource.UserDefinedRoleID
       INNER JOIN
      dbo.AccountUserResource ON 
      dbo.AccountUser.EmployeeID = dbo.AccountUserResource.EmployeeID
      where 
      AccountUser.EmployeeID=@EmployeeID
*/

SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
       dbo.AccountUserDefinedResource.UserDefinedResourceRight UserResourceRight, 
      dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName,dbo.AccountUserDefinedResource.ResourceID
FROM dbo.AccountUser INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
       INNER JOIN
      dbo.AccountUserDefinedResource ON 
      dbo.AccountUserDefinedRole.UserDefinedRoleID = dbo.AccountUserDefinedResource.UserDefinedRoleID
       INNER JOIN
      dbo.AccountResourceData ON 
      dbo.AccountUserDefinedResource.ResourceID = dbo.AccountResourceData.ResourceID
where AccountUser.EmployeeID=@EmployeeID

union 

SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUserResource.UserResourceRight, 
      dbo.AccountResourceData.ResourcePath, 
      dbo.AccountResourceData.ResourceName,dbo.AccountResourceData.ResourceID
FROM dbo.AccountUser INNER JOIN
      dbo.AccountUserResource ON 
      dbo.AccountUser.EmployeeID = dbo.AccountUserResource.EmployeeID INNER JOIN
      dbo.AccountResourceData ON 
      dbo.AccountUserResource.ResourceID = dbo.AccountResourceData.ResourceID

where AccountUser.EmployeeID=@EmployeeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetSpecialRoleResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xlchen
Date        :2004-12-3
Description :返回指定用户 根据用户的编号(EmployeeID)返回其所有的资源；返回资源的内容由两个部分组成（1）、将用户表和AccountUserResource关联取出次用户的权限信息；（2）、根据当前用户的所属组找出这组的相关资源信息
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetSpecialRoleResource]

	(
		@UserDefinedRoleID int
	)

AS


SELECT UserDefinedResourceID, UserDefinedRoleID, ResourceID, 
      UserDefinedResourceRight
FROM dbo.AccountUserDefinedResource

where UserDefinedRoleID=@UserDefinedRoleID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetUserByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-21
Description :返回记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetUserByEmployeeID]

	(
	  @EmployeeID varchar(50)
	)

AS
--SELECT PersonBlogTypeID, PersonBlogTypeName,EmployeeID	FROM dbo.PersonBlogType
SELECT 
	EmployeeID, EmployeeName, UserID, UserPass, DepartmentRoleID, LevelRoleID, RankRoleID, UserDefinedRoleID	
FROM 
	AccountUser
where 
	EmployeeID=@EmployeeID

	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetUserByEmployeeIDReader]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author      :jkliu
Date        :2004-12-21
Description :返回记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetUserByEmployeeIDReader]

	(
	  @EmployeeID varchar(50)
	)

AS
--SELECT PersonBlogTypeID, PersonBlogTypeName,EmployeeID	FROM dbo.PersonBlogType
SELECT 
	dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID,  dbo.AccountUser.PositionStatus,
      dbo.AccountDepartmentRole.DepartmentRoleName, dbo.AccountUser.LevelRoleID, 
      dbo.AccountLevelRole.LevelRoleName, dbo.AccountUser.RankRoleID, 
      dbo.AccountRankRole.RankRoleName, dbo.AccountUser.UserDefinedRoleID, 
      dbo.AccountUserDefinedRole.UserDefinedRoleName, dbo.AccountUser.[Order]
	
FROM dbo.AccountUser INNER JOIN
      dbo.AccountDepartmentRole ON 
      dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
       JOIN
      dbo.AccountLevelRole ON 
      dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
      dbo.AccountRankRole ON 
      dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
where 
	EmployeeID=@EmployeeID

	/* SET NOCOUNT ON */
	RETURN


GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetUserByIdentityCard]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2011-10-25
Description :返回记录
*/
create PROCEDURE [dbo].[Account_AccountUserGetUserByIdentityCard]
(
  @IdentityCard varchar(50)
)

AS
--SELECT PersonBlogTypeID, PersonBlogTypeName,EmployeeID FROM dbo.PersonBlogType
SELECT   dbo.AccountUserIdentityCard.IdentityCard, dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName
FROM      dbo.AccountUser INNER JOIN
                dbo.AccountUserIdentityCard ON dbo.AccountUser.EmployeeID = dbo.AccountUserIdentityCard.EmployeeID
where 
IdentityCard=@IdentityCard
/* SET NOCOUNT ON */
RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserGetUserInfo]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :用户登录验证(UserID,Password),验证成功返回EmployeeID；
*/

CREATE PROCEDURE [dbo].[Account_AccountUserGetUserInfo]

	(
		@UserID varchar(50),
		@UserPass varchar(50)
	)
AS
/* SET NOCOUNT ON */

SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, 
      dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
      dbo.AccountUser.DepartmentRoleID, 
      dbo.AccountDepartmentRole.DepartmentRoleName, dbo.AccountUser.LevelRoleID, 
      dbo.AccountLevelRole.LevelRoleName, dbo.AccountUser.RankRoleID, 
      dbo.AccountRankRole.RankRoleName, dbo.AccountUser.UserDefinedRoleID, 
      dbo.AccountUserDefinedRole.UserDefinedRoleName
FROM dbo.AccountUser INNER JOIN
      dbo.AccountDepartmentRole ON 
      dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER
       JOIN
      dbo.AccountLevelRole ON 
      dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
      dbo.AccountRankRole ON 
      dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
      dbo.AccountUserDefinedRole ON 
      dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID
 where 
	AccountUser.UserID=@UserID AND AccountUser.UserPass=@UserPass
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author      :jkliu
Date        :2004-12-3
Description :修改用户
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModify]

	(
		@EmployeeID varchar(50), 
		@OldEmployeeID varchar(50), 
		@EmployeeName varchar(50), 
		@UserID varchar(50), 
		@UserPass varchar(50), 
		@DepartmentRoleID varchar(50), 
		@LevelRoleID varchar(50), 
		@RankRoleID varchar(50), 
		@UserDefinedRoleID varchar(50),
	    @PositionStatus  varchar(10),
		@Order int	
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountUser SET 
	 EmployeeID=@EmployeeID,EmployeeName=@EmployeeName, UserID=@UserID, UserPass=@UserPass, DepartmentRoleID=@DepartmentRoleID, LevelRoleID=@LevelRoleID, RankRoleID=@RankRoleID, UserDefinedRoleID=@UserDefinedRoleID,PositionStatus =@PositionStatus 
	 ,[Order]=@Order
	 where EmployeeID=@OldEmployeeID
	
	
	RETURN


GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyAccountDepartmentRoleByDepartmentRoleID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :根据DepartmentRoleID修改DepartmentRoleName
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModifyAccountDepartmentRoleByDepartmentRoleID]

	(
		@DepartmentRoleID int,
		@DepartmentRoleName varchar(50)
	)

AS

UPDATE AccountDepartmentRole set DepartmentRoleName=@DepartmentRoleName where DepartmentRoleID=@DepartmentRoleID
--SELECT 1 FROM dbo.AccountDepartmentRole where DepartmentRoleName=@DepartmentRoleName
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyIPByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:ayong
 DateTime:2004.12.27
 Description:根据EmployeeID修改Ip
*/
CREATE PROCEDURE [dbo].[Account_AccountUserModifyIPByEmployeeID]

	(
		@EmployeeID varchar(50),
		@IPAddress varchar(50)
		
		
	)

AS
	/* SET NOCOUNT ON */
	update AccountUser 
	set     
		IPAddress = @IPAddress,LastLoginTime=getdate()
	
	where
		EmployeeID = @EmployeeID
	     
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyLevelRoleIDByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :根据Employee修改DepartmentRoleID
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModifyLevelRoleIDByEmployeeID]

	(
		@EmployeeID varchar(50),
		@LevelRoleID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountUser set LevelRoleID=@LevelRoleID where EmployeeID=@EmployeeID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyRankRoleIDByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :根据Employee修改RankRoleID
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModifyRankRoleIDByEmployeeID]

	(
		@EmployeeID varchar(50),
		@RankRoleID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountUser set RankRoleID=@RankRoleID where EmployeeID=@EmployeeID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyUserDefinedRoleIDByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :根据Employee修改UserDefinedRoleID
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModifyUserDefinedRoleIDByEmployeeID]

	(
		@EmployeeID varchar(50),
		@UserDefinedRoleID int
	)

AS
/* SET NOCOUNT ON */

UPDATE AccountUser set UserDefinedRoleID=@UserDefinedRoleID where EmployeeID=@EmployeeID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserModifyUserPass]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-6
Description :修改用户密码和用户登陆名
*/

CREATE PROCEDURE [dbo].[Account_AccountUserModifyUserPass]

	(
		@EmployeeID varchar(50), 
		
		@UserID varchar(50), 
		@UserPass varchar(50)
	)

AS
/* SET NOCOUNT ON */

update AccountUser set UserPass = @UserPass where EmployeeID = @EmployeeID
	
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserPK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountUserPK]

	(
		@EmployeeID varchar(50)
	)

AS

SELECT EmployeeID FROM dbo.AccountUser where EmployeeID=@EmployeeID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserPKNew]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2011-10-24
Description :测试是否在用户表中插入重复主键,专门为了手持仪登录时设计
*/
CREATE PROCEDURE [dbo].[Account_AccountUserPKNew]
	(
		@EmployeeID varchar(50)
	)

AS

SELECT EmployeeID FROM dbo.AccountUserIdentityCard where IdentityCard=@EmployeeID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserPKUserID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :测试是否在用户表中插入重复主键(UserID)
*/

CREATE PROCEDURE [dbo].[Account_AccountUserPKUserID]

	(
		@EmployeeID varchar(50),
		@UserID varchar(50)
	)

AS

SELECT 1 FROM dbo.AccountUser where UserID = @UserID AND EmployeeID <> @EmployeeID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :添加用户
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceAdd]

	(
		@EmployeeID varchar(50), 
		@ResourceID int, 
		@UserResourceRight varchar(50)

	)

AS

INSERT INTO 
	AccountUserResource(EmployeeID,ResourceID,UserResourceRight) values(@EmployeeID,@ResourceID,@UserResourceRight)
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceByConsDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录--当flag=1时，根据参数（UserResourceID）删除记录；当flag=2时，根据（ResourceID）删除记录；
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceByConsDelete]

	(
		@chooseParm int,
		@flag varchar(10)
	)

AS
/* SET NOCOUNT ON */

	if(@flag=1)
		begin
			Delete from AccountUserResource	 where UserResourceID=@chooseParm
		end
	else if(@flag=2)
		begin 
			Delete from AccountUserResource	 where ResourceID=@chooseParm
		end
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceDelete]

	(
		@UserResourceID int
	)

AS
/* SET NOCOUNT ON */

/*
declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountUserDefinedRole	 where UserDefinedRoleID in '+ @pkidstring

exec(@deletestring)	
	
	*/
	Delete from AccountUserResource	 where UserResourceID=@UserResourceID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceDeleteByCons]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录--当flag=1时，根据参数（UserResourceID）删除记录；当flag=2时，根据（ResourceID）删除记录；
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceDeleteByCons]

	(
		@chooseParm int,
		@flag varchar(10)
	)

AS
/* SET NOCOUNT ON */

	if(@flag=1)
		begin
			Delete from AccountUserResource	 where UserResourceID=@chooseParm
		end
	else if(@flag=2)
		begin 
			Delete from AccountUserResource	 where ResourceID=@chooseParm
		end
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceDeleteByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :删除记录
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceDeleteByEmployeeID]

	(
		@EmployeeID varchar(50)
	)

AS
/* SET NOCOUNT ON */

/*
declare @deletestring varchar(5000)

set @deletestring= 'Delete from AccountUserDefinedRole	 where UserDefinedRoleID in '+ @pkidstring

exec(@deletestring)	
	
	*/
	Delete from AccountUserResource	 where EmployeeID=@EmployeeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceDeleteByPrime]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-10-16
Description :根据@EmployeeID，@ResourceID用户资源
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceDeleteByPrime]

	(
		@EmployeeID varchar(50), 
		@ResourceID int

	)

AS

delete from AccountUserResource where EmployeeID=@EmployeeID and ResourceID=@ResourceID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceGetByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-3
Description :（数值返回）根据EmployeeID返回记录;
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceGetByEmployeeID]

	(
 		@EmployeeID varchar(50)
	)

AS
/* SET NOCOUNT ON */

SELECT UserResourceID, EmployeeID, ResourceID, UserResourceRight
FROM dbo.AccountUserResource 
where  EmployeeID=@EmployeeID
	
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceGetByResourceID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :（数值返回）根据ResourceID返回记录;
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceGetByResourceID]

	(
		@ResourceID int 
	)

AS
/* SET NOCOUNT ON */

SELECT UserResourceID, EmployeeID, ResourceID, UserResourceRight
FROM dbo.AccountUserResource
	where ResourceID=@ResourceID
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceModify]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :xiaolinchen
Date        :2005-10-16
Description :修改用户资源
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourceModify]

	(
		@EmployeeID varchar(50), 
		@ResourceID int, 
		@UserResourceRight varchar(50)

	)

AS

update AccountUserResource set UserResourceRight=@UserResourceRight where EmployeeID=@EmployeeID and ResourceID=@ResourceID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourcePK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :jkliu
Date        :2004-12-5
Description :测试是否在用户表中插入重复主键
*/

CREATE PROCEDURE [dbo].[Account_AccountUserResourcePK]

	(
		@EmployeeID varchar(50),
		@ResourceID int
	)

AS

SELECT 1 FROM dbo.AccountUserResource where EmployeeID=@EmployeeID and ResourceID=@ResourceID
	/* SET NOCOUNT ON */
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[Account_AccountUserResourceUpsert]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Account_AccountUserResourceUpsert]

	(
		@EmployeeID varchar(50), 
		@ResourceID int, 
		@UserResourceRight varchar(50)
	)

AS
--declare @userdefinedroleid int
if @UserResourceRight = '00000'
	begin
		delete AccountUserResource where EmployeeID=@EmployeeID and ResourceID=@ResourceID
		return
	end


if EXISTS (select 1 from AccountUserResource where EmployeeID=@EmployeeID and ResourceID=@ResourceID)
	begin
		update AccountUserResource set UserResourceRight=@UserResourceRight where EmployeeID=@EmployeeID and ResourceID=@ResourceID
	end
else
	begin
		insert into AccountUserResource(EmployeeID,ResourceID ,UserResourceRight)
			values(@EmployeeID,@ResourceID,@UserResourceRight)
	end

	RETURN --@userdefinedroleid

GO
/****** Object:  StoredProcedure [dbo].[AccountAccountUserGetSingleAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2008-11-30
Description :获取所有的用户编号以及用户名
*/
CREATE PROCEDURE [dbo].[AccountAccountUserGetSingleAll] 
	
AS
	SELECT dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName FROM dbo.AccountUser
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountRankRoleGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :zhoujun
Date        :20090626
Description :取得所有角色信息
*/


Create PROCEDURE [dbo].[AccountRankRoleGetAll] 

AS
SELECT     RankRoleID, RankRoleName
FROM         dbo.AccountRankRole
WHERE     (RankRoleID <> '1')
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountRoleCatalogGetByEmployeeID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*Creator:chenxiaolin
 DateTime:2008-12-2
 Description:由EmployeeID返回扩展角色信息
*/
CREATE PROCEDURE [dbo].[AccountRoleCatalogGetByEmployeeID] 
	
	(
	   @EmployeeID varchar(50)
	)
	
AS
	select EmployeeID, RoleID,Flag
       
FROM dbo.AccountRoleCatalog where EmployeeID=@EmployeeID
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserIdentityCardAdd]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2012-4-15
Description 添加卡与用户对应信息
*/
CREATE PROCEDURE [dbo].[AccountUserIdentityCardAdd]
	(
		@EmployeeID varchar(50),
		@IdentityCard varchar(50)
	)
AS
	insert into  dbo.AccountUserIdentityCard (EmployeeID,IdentityCard) values (@EmployeeID,@IdentityCard)
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserIdentityCardDelete]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2012-4-15
Description 删除卡与用户对应信息
*/
CREATE PROCEDURE [dbo].[AccountUserIdentityCardDelete]
	(
		@EmployeeID varchar(50),
		@IdentityCard varchar(50)
	)
AS
	delete FROM dbo.AccountUserIdentityCard where EmployeeID=@EmployeeID and IdentityCard=@IdentityCard
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserIdentityCardGetAll]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2012-4-15
Description 返回卡与用户对应信息
*/
CREATE PROCEDURE [dbo].[AccountUserIdentityCardGetAll]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM dbo.AccountUserIdentityCard

	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserIdentityCardGetByCons]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2012-4-15
Description :返回卡与用户对应信息
*/
CREATE PROCEDURE [dbo].[AccountUserIdentityCardGetByCons]
	(
	@UserName varchar(50),
	@UserDefinedRoleID varchar(50),
	@DepartmentRoleID varchar(50),
	@IdentityCard varchar(50)
	)
	 
AS
	 			SELECT   dbo.AccountUser.EmployeeID, dbo.AccountUser.EmployeeName, dbo.AccountUser.UserID, dbo.AccountUser.UserPass, 
                dbo.AccountUser.DepartmentRoleID, dbo.AccountDepartmentRole.DepartmentRoleName, 
                dbo.AccountUser.UserDefinedRoleID, dbo.AccountUser.RankRoleID, dbo.AccountUser.LevelRoleID, 
                dbo.AccountUserDefinedRole.UserDefinedRoleName, dbo.AccountRankRole.RankRoleName, 
                dbo.AccountLevelRole.LevelRoleName, dbo.AccountUser.LastLoginTime, dbo.AccountUser.IPAddress, 
                dbo.AccountUserIdentityCard.IdentityCard
FROM      dbo.AccountUser INNER JOIN
                dbo.AccountDepartmentRole ON 
                dbo.AccountUser.DepartmentRoleID = dbo.AccountDepartmentRole.DepartmentRoleID INNER JOIN
                dbo.AccountLevelRole ON dbo.AccountUser.LevelRoleID = dbo.AccountLevelRole.LevelRoleID INNER JOIN
                dbo.AccountRankRole ON dbo.AccountUser.RankRoleID = dbo.AccountRankRole.RankRoleID INNER JOIN
                dbo.AccountUserDefinedRole ON 
                dbo.AccountUser.UserDefinedRoleID = dbo.AccountUserDefinedRole.UserDefinedRoleID INNER JOIN
                dbo.AccountUserIdentityCard ON dbo.AccountUser.EmployeeID = dbo.AccountUserIdentityCard.EmployeeID
      
where 
	  AccountUser.DepartmentRoleID=
		case 
			when  @DepartmentRoleID<>'' 
				then @DepartmentRoleID 
				else AccountUser.DepartmentRoleID 
			end
    and dbo.AccountUser.UserDefinedRoleID=case when  @UserDefinedRoleID<>'' then @UserDefinedRoleID else AccountUser.UserDefinedRoleID end
    and AccountUser.EmployeeName like '%'+@UserName+'%' and dbo.AccountUserIdentityCard.IdentityCard = ISNULL(@IdentityCard,IdentityCard)
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserIdentityCardPK]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2012-4-15
Description :测试卡与用户对应信息已经存在
*/
CREATE PROCEDURE [dbo].[AccountUserIdentityCardPK]
	(
		@EmployeeID varchar(50),
		@IdentityCard varchar(50)
	)
AS
	SELECT EmployeeID FROM dbo.AccountUserIdentityCard where EmployeeID=@EmployeeID or IdentityCard=@IdentityCard

	RETURN

GO
/****** Object:  StoredProcedure [dbo].[AccountUserModifyUserPassByID]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Author      :chenxiaolin
Date        :2008-12-1
Description :根据登录用户名和密码修改密码啊
*/
CREATE PROCEDURE [dbo].[AccountUserModifyUserPassByID] 
	
	(
		@UserID varchar(50), 
		@UserPass varchar(50), 
		@UserOldPass varchar(50)
	)
	
AS
	UPDATE AccountUser SET 
	 UserPass=@UserPass
	 where UserPass=@UserOldPass  and UserID=@UserID
	RETURN

GO
/****** Object:  Table [dbo].[AccountDepartmentRole]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountDepartmentRole](
	[DepartmentRoleID] [varchar](50) NOT NULL,
	[DepartmentRoleParentID] [varchar](50) NOT NULL,
	[DepartmentRoleName] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_AccountDepartmentRole] PRIMARY KEY CLUSTERED 
(
	[DepartmentRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountLevelRole]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountLevelRole](
	[LevelRoleID] [varchar](50) NOT NULL,
	[LevelRoleParentID] [varchar](50) NOT NULL,
	[LevelRoleName] [varchar](50) NULL,
 CONSTRAINT [PK_AccountLevelRole] PRIMARY KEY CLUSTERED 
(
	[LevelRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountMenu]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountMenu](
	[DefinedRoleID] [int] NULL,
	[DefinedRoleParentID] [int] NOT NULL,
	[MenuName] [varchar](50) NOT NULL,
	[PKID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_AccountMenu_1] PRIMARY KEY CLUSTERED 
(
	[PKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountRankRole]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountRankRole](
	[RankRoleID] [varchar](50) NOT NULL,
	[RankRoleParentID] [varchar](50) NOT NULL,
	[RankRoleName] [varchar](50) NULL,
 CONSTRAINT [PK_AccountRankRole] PRIMARY KEY CLUSTERED 
(
	[RankRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountResourceData]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountResourceData](
	[ResourceID] [int] IDENTITY(1,1) NOT NULL,
	[ResourcePath] [varchar](300) NOT NULL,
	[ResourceName] [varchar](300) NULL,
	[ResourceRemark] [varchar](300) NULL,
	[ResourceTypeID] [int] NULL,
	[ResourceIsBeControl] [varchar](10) NULL,
	[SystemID] [int] NULL,
	[IsActive] [int] NULL,
	[DisplayName] [varchar](300) NULL,
	[OrderID] [int] NULL,
	[IsDisplay] [bit] NULL,
	[SitePrefix] [nvarchar](300) NULL,
 CONSTRAINT [PK_AccountResourceData] PRIMARY KEY CLUSTERED 
(
	[ResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountResourceType]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountResourceType](
	[ResourceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ResourceTypeParentID] [int] NOT NULL,
	[ResourceTypeName] [varchar](50) NULL,
	[ResourceTypePath] [varchar](300) NULL,
 CONSTRAINT [PK_AccountResourceType] PRIMARY KEY CLUSTERED 
(
	[ResourceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountRoleCatalog]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountRoleCatalog](
	[EmployeeID] [varchar](50) NULL,
	[RoleID] [varchar](50) NULL,
	[Flag] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountUser]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountUser](
	[EmployeeID] [varchar](50) NOT NULL,
	[EmployeeName] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[UserPass] [varchar](200) NOT NULL,
	[DepartmentRoleID] [varchar](50) NOT NULL,
	[LevelRoleID] [varchar](50) NOT NULL,
	[RankRoleID] [varchar](50) NOT NULL,
	[UserDefinedRoleID] [varchar](50) NOT NULL,
	[IPAddress] [varchar](50) NULL,
	[LastLoginTime] [datetime] NULL,
	[PositionStatus] [nvarchar](10) NOT NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_AccountUser] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountUserDefinedResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountUserDefinedResource](
	[UserDefinedResourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserDefinedRoleID] [varchar](50) NOT NULL,
	[ResourceID] [int] NOT NULL,
	[UserDefinedResourceRight] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AccountUserDefinedResource] PRIMARY KEY CLUSTERED 
(
	[UserDefinedResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountUserDefinedRole]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountUserDefinedRole](
	[UserDefinedRoleID] [varchar](50) NOT NULL,
	[UserDefinedRoleParentID] [varchar](50) NOT NULL,
	[UserDefinedRoleName] [varchar](50) NULL,
 CONSTRAINT [PK_AccountUserDefinedRole] PRIMARY KEY CLUSTERED 
(
	[UserDefinedRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountUserExamCatalog]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountUserExamCatalog](
	[EmployeeID] [nvarchar](50) NOT NULL,
	[ExamCatalogName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AccountUserExamCatalog] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AccountUserIdentityCard]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountUserIdentityCard](
	[IdentityCard] [varchar](50) NOT NULL,
	[EmployeeID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AccountUserIdentityCard] PRIMARY KEY CLUSTERED 
(
	[IdentityCard] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountUserResource]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountUserResource](
	[UserResourceID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[EmployeeID] [varchar](50) NOT NULL,
	[ResourceID] [int] NOT NULL,
	[UserResourceRight] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AccountUserResource] PRIMARY KEY CLUSTERED 
(
	[UserResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccountVisibleDept]    Script Date: 2016/8/16 14:03:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountVisibleDept](
	[Type] [int] NOT NULL,
	[ResourceId] [int] NOT NULL,
	[RelateId] [nvarchar](50) NOT NULL,
	[DeptId] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AccountVisibleDept] PRIMARY KEY CLUSTERED 
(
	[Type] ASC,
	[ResourceId] ASC,
	[RelateId] ASC,
	[DeptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[AccountResourceData] ADD  CONSTRAINT [DF_AccountResourceData_ResourceIsBeControl]  DEFAULT ('否') FOR [ResourceIsBeControl]
GO
ALTER TABLE [dbo].[AccountResourceData] ADD  CONSTRAINT [DF_AccountResourceData_SystemID]  DEFAULT ((-1)) FOR [SystemID]
GO
ALTER TABLE [dbo].[AccountResourceData] ADD  CONSTRAINT [DF_AccountResourceData_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AccountResourceData] ADD  CONSTRAINT [DF_AccountResourceData_OrderID]  DEFAULT ((100)) FOR [OrderID]
GO
ALTER TABLE [dbo].[AccountResourceData] ADD  CONSTRAINT [DF_AccountResourceData_IsDisplay]  DEFAULT ((0)) FOR [IsDisplay]
GO
ALTER TABLE [dbo].[AccountUser] ADD  DEFAULT ('在职') FOR [PositionStatus]
GO
ALTER TABLE [dbo].[AccountUser] ADD  DEFAULT ('9999') FOR [Order]
GO
ALTER TABLE [dbo].[AccountDepartmentRole]  WITH CHECK ADD  CONSTRAINT [FK_AccountDepartmentRole_AccountDepartmentRole] FOREIGN KEY([DepartmentRoleID])
REFERENCES [dbo].[AccountDepartmentRole] ([DepartmentRoleID])
GO
ALTER TABLE [dbo].[AccountDepartmentRole] CHECK CONSTRAINT [FK_AccountDepartmentRole_AccountDepartmentRole]
GO
ALTER TABLE [dbo].[AccountRankRole]  WITH CHECK ADD  CONSTRAINT [FK_AccountRankRole_AccountRankRole] FOREIGN KEY([RankRoleID])
REFERENCES [dbo].[AccountRankRole] ([RankRoleID])
GO
ALTER TABLE [dbo].[AccountRankRole] CHECK CONSTRAINT [FK_AccountRankRole_AccountRankRole]
GO
