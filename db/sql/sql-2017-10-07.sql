级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
/**
 * 16:36 添加函數
 */
CREATE OR REPLACE FUNCTION getMsgReciverId(msg IN NVARCHAR2)
RETURN NVARCHAR2
AS

       r NVARCHAR2(255);

BEGIN
       select users into r
       from messages
       where messages.id 

=msg;
       
       RETURN r;
END;

CREATE OR REPLACE FUNCTION getMsgReciverName(usid IN NVARCHAR2)
RETURN NVARCHAR2
AS

       r NVARCHAR2(255);

BEGIN
       select users.username into r
       from users
       where users.id 

=usid;
       RETURN r;
END;
