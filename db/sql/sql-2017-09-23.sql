级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
	

/**
 * 14:51	ignoreable
 */
/*修改商品的状态注释;添加了-5状态*/
COMMENT ON COLUMN GOODS.STATUS
IS '状态:2为已发货，1为购买了且待发货，,0为创建且待购买,-1为买家收货后交易正常结束，-2为卖家取消了出售本商品，-3是用户取消购买本商品，-4管理员取消发布的商品,-5为管理员删除了商品'


/**
 * 16:42	alls
 */
/*修改商品的browse_number,LAST_UPDATE_TIME为非空字段*/
update goods
set browse_number=0;

alter table goods modify browse_number not null;

UPDATE goods
set LAST_UPDATE_TIME=sysdate;
alter table  goods modify LAST_UPDATE_TIME not null;
/**
 * 18:06	alls
 */
/*修改商品的browse_number,LAST_UPDATE_TIME为字段名*/
ALTER TABLE goods RENAME COLUMN browse_number TO browsenumber
ALTER TABLE goods RENAME COLUMN LAST_UPDATE_TIME TO LASTUPDATETIME