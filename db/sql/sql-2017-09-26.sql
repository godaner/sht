级别:
	goods模块需立即更新:goods
	users模块需立即更新:users
	admins模块需立即更新:admins
	全部模块都需立即更新:alls
	可忽略的,暂时可不更新的:ignoreable
	

/**
 * 10:05	alls
 */
/*創建函數*/
/*通過商品id查詢其類型,返回格式為:類型1-類型二-類型三*/
CREATE OR REPLACE FUNCTION getClazzsBYgoodsid(goodsid IN NVARCHAR2)
RETURN NVARCHAR2
AS
       type table_my IS TABLE OF CLAZZS.TEXT%TYPE NOT NULL INDEX by binary_integer;
       
       cr table_my;
       r NVARCHAR2(255);
BEGIN
      
       select c.text BULK COLLECT into cr from goods g,goods_clazzs gc,clazzs c WHERE g.ID = gc.GOODS AND gc.CLAZZ=c.ID AND g.ID=goodsid;
       
       for i in cr.first..cr.last loop
           r := cr(i)||'-'||r;
       end loop;
       
       r:=substr(r,0,length(r)-1);
       
       RETURN r;
END;


/**
 * 10:45	修復函數在無返回集時出現的bug
 */
/*通過商品id查詢其類型,返回格式為:類型1-類型二-類型三*/
CREATE OR REPLACE FUNCTION getClazzsBYgoodsid(goodsid IN NVARCHAR2)
RETURN NVARCHAR2
AS
       type table_my IS TABLE OF CLAZZS.TEXT%TYPE NOT NULL INDEX by binary_integer;
       
       cr table_my;
       r NVARCHAR2(255);
BEGIN
      
       select c.text BULK COLLECT into cr from goods g,goods_clazzs gc,clazzs c WHERE g.ID = gc.GOODS AND gc.CLAZZ=c.ID AND g.ID=goodsid;
       
       IF  cr.count() >0 THEN

         for i in cr.first..cr.last loop
             r := cr(i)||'-'||r;
         end loop;
         
         r:=substr(r,0,length(r)-1);

       END IF;
       
       RETURN r;
END;


/**
 * 19:44	alls
 */
/*通过goodsid获取主图的path,例如a.jpg*/
CREATE OR REPLACE FUNCTION getGoodsMainImgPath(goodsid IN NVARCHAR2)
RETURN NVARCHAR2
AS
       
       r NVARCHAR2(255);
BEGIN

       select f.path into r
       from  files f,goods_imgs gi
       where f.id=gi.img and gi.main = 1 and gi.owner = goodsid;

       RETURN r;
END;

/**
 * 20:06	alls
 */
/*通过goodsid获取留言数量*/
CREATE OR REPLACE FUNCTION getGoodsMessageNum(goodsid IN NVARCHAR2)
RETURN NUMBER 
AS
       
       r NUMBER;
BEGIN

       select count(messages.id) into r
       from  messages
       where  messages.receiver = goodsid;

       RETURN r;
END;
