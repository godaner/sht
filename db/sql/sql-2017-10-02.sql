级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
/**
 * 未知	ignoreable
 */
/*增加roles字段DESCRIPTION*/
ALTER TABLE ROLES ADD (DESCRIPTION NVARCHAR2(255))

/**
 * 15:17	ignoreable
 */
/*增加roles字段DESCRIPTION*/
  COMMENT ON COLUMN roles.STATUS
  IS'是否可用,1:可用,0:删除,-1:冻结'