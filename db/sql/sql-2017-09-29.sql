级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
	

/**
 * 21:33	alls
 */
/*添加goods字段*/
ALTER TABLE goods ADD (toprovince NVARCHAR2(20),
tocity  NVARCHAR2(20),
tocounty  NVARCHAR2(20),
todetail  NVARCHAR2(40),
phone  NVARCHAR2(20),
torealname NVARCHAR2(20),
POSTCODE NVARCHAR2(10),
returnmoneybill NVARCHAR2(40));

COMMENT ON COLUMN  goods.toprovince
IS '收件省份'
COMMENT ON COLUMN goods.TOCITY
IS '收件城市'

COMMENT ON COLUMN goods.tocounty
IS '收件县区'
COMMENT ON COLUMN goods.todetail
IS '收件详细地址'

COMMENT ON COLUMN goods.phone
IS '收件人电话'

COMMENT ON COLUMN goods.torealname
IS '收件人名字'

COMMENT ON COLUMN goods.POSTCODE
IS '收件地址邮编'
COMMENT ON COLUMN goods.returnmoneybill
IS '退款凭证'


ALTER TABLE goods ADD CONSTRAINT fk_goods_returnmoneybill FOREIGN KEY (returnmoneybill) REFERENCES files(ID)



/*修改addrs的pohne字段为phone*/
ALTER TABLE addrs RENAME COLUMN pohne TO phone

