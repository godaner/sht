
/**
 * 修改users表的状态选项;
 * 状态:1为激活，,0为冻结,-1为删除 ,-2为注册未激活
 */
COMMENT ON COLUMN  users.status 
IS '状态:1为激活，,0为冻结,-1为删除 ,-2为注册未激活'
/**
 * 向users表添加余额字段
 */
alter table users add (money number);

UPDATE USERS
SET money = 9999

ALTER TABLE users MODIFY (money number NOT NULL )

COMMENT ON COLUMN users.MONEY
IS '用户余额'



/**
 * 时间:11:11
 */
/*更正users表的错误额度外键约束SHT.USERS_FK_HEADIMG*/
ALTER TABLE USERS DROP CONSTRAINT USERS_FK_HEADIMG;


/**
 * 时间:20:55
 */
/*更新goods*/
/*添加字段BUYTIME*/
ALTER TABLE goods ADD (BUYTIME TIMESTAMP(6))

COMMENT ON COLUMN goods.BUYTIME 
IS '商品被购买时写入购买时间'
/*添加字段BUYTIME*/
ALTER TABLE goods ADD (finishtime TIMESTAMP(6))

COMMENT ON COLUMN goods.finishtime 
IS '商品交易正常完成时的时间'
