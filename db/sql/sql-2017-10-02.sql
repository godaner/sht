级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
/**
 * 21:33	alls
 */
/*增加roles字段DESCRIPTION*/
ALTER TABLE ROLES ADD (DESCRIPTION NVARCHAR2(255))