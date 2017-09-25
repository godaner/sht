级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
	

/**
 * 10:42	alls
 */
/*修改表region的字段名*/
ALTER TABLE region RENAME COLUMN REGION_ID TO ID
ALTER TABLE region RENAME COLUMN REGION_CODE TO code
ALTER TABLE region RENAME COLUMN REGION_NAME TO NAME
ALTER TABLE region RENAME COLUMN PARENT_ID TO pid
ALTER TABLE region RENAME COLUMN REGION_LEVEL TO LEVE
ALTER TABLE region RENAME COLUMN REGION_ORDER TO ORDE
ALTER TABLE region RENAME COLUMN REGION_NAME_EN TO enNAME
ALTER TABLE region RENAME COLUMN REGION_SHORTNAME_EN TO enshortname



/**
 * 11:33	alls
 */
/*通过region表baseid查询详细地址,即:通过县的id向上查询:省-市-县*/

CREATE OR REPLACE FUNCTION getRegionByBaseId(baseid IN NUMBER)
RETURN NVARCHAR2
AS
       province region.NAME%TYPE;
       city region.NAME%TYPE;
       county region.NAME%TYPE;
       currid region.id%TYPE;
BEGIN
       currid := baseid;
       SELECT region.name,region.pid INTO county,currid FROM region WHERE REGION.ID = currid;
       SELECT region.name,region.pid INTO city,currid FROM region WHERE REGION.ID = currid;
       SELECT region.name,region.pid INTO province,currid FROM region WHERE REGION.ID = currid;
       RETURN province||'-'||city||'-'||county;
END;

/**
 * 11:33	ignoreable
 */
/*修改商品的新旧度范围*/
COMMENT on COLUMN goods.CONDITION
IS '商品成色,1-9'



/**
 * 20:56	ignoreable
 */
/*重新定义goods的status的属性*/
COMMENT ON COLUMN GOODS.STATUS
IS '-6:待审核状态,(不可以被显示,不可以购买)
      -7:审核未通过,(不可以被显示,不可以购买)
      0:审核通过,(可以被显示,可以购买)
      1:购买了且待发货,
      2:已发货,
      -1:买家收货后交易正常结束,
      -2:卖家取消了出售本商品,
			-3:买家取消购买本商品,
			-5:管理员删除本商品'