级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
/**
 * 21:33	ignoreable
 */
/*添加goods两个新状态-8和-9状态*/
COMMENT ON COLUMN goods.STATUS 
IS '-6:待审核状态,(不可以被显示,不可以购买)
      -7:审核未通过,(不可以被显示,不可以购买)
      0:审核通过,(可以被显示,可以购买)
      1:购买了且待发货,
      2:已发货,
      -1:买家收货后交易正常结束,
      -2:卖家取消了出售本商品,
	  -3:买家取消购买本商品,
	  -5:管理员删除本商品,
      -8:买家申请退款,
      -9:退款成功（失败则保持-1状态）'

      
/*修改goods的RETURNMONEYBILL字段*/
ALTER TABLE goods  RENAME COLUMN RETURNMONEYBILL TO refuseReturnMoneyBill;

COMMENT ON COLUMN goods. refuseReturnMoneyBill
IS '商家拒绝退款的凭证'

