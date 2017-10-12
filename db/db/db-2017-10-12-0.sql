--------------------------------------------------
-- Export file for user SHT                     --
-- Created by Kor_Zhang on 2017/10/12, 14:47:10 --
--------------------------------------------------

spool db-2017-10-12-0.log

prompt
prompt Creating table REGION
prompt =====================
prompt
create table REGION
(
  ID          NUMBER not null,
  CODE        VARCHAR2(100) not null,
  NAME        VARCHAR2(100) not null,
  PID         NUMBER not null,
  LEVE        NUMBER not null,
  ORDE        NUMBER not null,
  ENNAME      VARCHAR2(100) default 1 not null,
  ENSHORTNAME VARCHAR2(10) default 2 not null
)
;
comment on column REGION.ID
  is '行政区划id';
comment on column REGION.CODE
  is '行政区划代码';
comment on column REGION.NAME
  is '行政区划名称';
comment on column REGION.PID
  is '父行政区划';
comment on column REGION.LEVE
  is '层级';
comment on column REGION.ORDE
  is '排序，用来调整顺序';
comment on column REGION.ENNAME
  is '行政区划英文名称';
comment on column REGION.ENSHORTNAME
  is '行政区划简称';
alter table REGION
  add constraint REGION_KEY primary key (ID);

prompt
prompt Creating table USERS
prompt ====================
prompt
create table USERS
(
  ID          NVARCHAR2(40) not null,
  USERNAME    NVARCHAR2(255) not null,
  EMAIL       NVARCHAR2(255) not null,
  PASSWORD    NVARCHAR2(40) not null,
  SALT        NVARCHAR2(40),
  HEADIMG     NVARCHAR2(255),
  SEX         NUMBER(1) default -1 not null,
  BIRTHDAY    DATE,
  DESCRIPTION NVARCHAR2(100),
  SCORE       NUMBER default 0 not null,
  REGISTTIME  TIMESTAMP(6) not null,
  STATUS      NUMBER(1) not null,
  MONEY       NUMBER not null
)
;
comment on column USERS.ID
  is '用户主键';
comment on column USERS.USERNAME
  is '唯一用户名称;如果用户被删除,那么在其username前加上uuid_;避免干擾管理員對其他賬戶名的修改;';
comment on column USERS.EMAIL
  is '唯一用户邮箱;如果用户被删除,那么在其EMAIL前加上uuid_;避免干擾管理員對其他賬戶郵箱的修改;';
comment on column USERS.PASSWORD
  is '用户密码';
comment on column USERS.SALT
  is '盐';
comment on column USERS.HEADIMG
  is '用户头像的图片名';
comment on column USERS.SEX
  is '-1为未设置性别,1为男,0为女';
comment on column USERS.BIRTHDAY
  is '用户生日,可计算出年龄';
comment on column USERS.DESCRIPTION
  is '用户描述';
comment on column USERS.SCORE
  is '用户积分';
comment on column USERS.REGISTTIME
  is '用户注册时间';
comment on column USERS.STATUS
  is '状态:1为激活，,0为冻结,-1为删除 ,-2为注册未激活';
comment on column USERS.MONEY
  is '用户余额';
alter table USERS
  add constraint USERS_PK_ID primary key (ID);
alter table USERS
  add constraint USERS_UK_EMAIL unique (EMAIL);
alter table USERS
  add constraint USERS_UK_USERNAME unique (USERNAME);
alter table USERS
  add constraint USERS_CK_SEX
  check (SEX IN (-1,1,0) );

prompt
prompt Creating table ADDRS
prompt ====================
prompt
create table ADDRS
(
  ID        NVARCHAR2(40) not null,
  MASTER    NVARCHAR2(40) not null,
  REGION    NUMBER not null,
  DETAIL    NVARCHAR2(40) not null,
  PHONE     NVARCHAR2(20) not null,
  REALNAME  NVARCHAR2(20) not null,
  ISDEFAULT NUMBER(1) not null,
  POSTCODE  VARCHAR2(10)
)
;
comment on column ADDRS.ID
  is '主键';
comment on column ADDRS.MASTER
  is '指向用户的id';
comment on column ADDRS.REGION
  is '指向地址最低级的id;省-市-县;如:湖南省-张家界-慈利县';
comment on column ADDRS.DETAIL
  is '地址详情;如:吉首大学张家界校区1食堂';
comment on column ADDRS.PHONE
  is '联系电话';
comment on column ADDRS.REALNAME
  is '收货人姓名';
comment on column ADDRS.ISDEFAULT
  is '是否为默认地址';
comment on column ADDRS.POSTCODE
  is '邮编';
alter table ADDRS
  add constraint ADDRS_PK_ID primary key (ID);
alter table ADDRS
  add constraint ADDRS_FK_MASTER foreign key (MASTER)
  references USERS (ID) on delete cascade;
alter table ADDRS
  add constraint ADDRS_FK_REGION foreign key (REGION)
  references REGION (ID) on delete cascade;

prompt
prompt Creating table ADMINS
prompt =====================
prompt
create table ADMINS
(
  ID          NVARCHAR2(40) not null,
  USERNAME    NVARCHAR2(255) not null,
  PASSWORD    NVARCHAR2(40) not null,
  SALT        NVARCHAR2(40),
  STATUS      NUMBER not null,
  CREATETIME  TIMESTAMP(6) not null,
  CREATOR     NVARCHAR2(40),
  THEME       NVARCHAR2(40),
  EMAIL       NVARCHAR2(255) not null,
  STATICC     NUMBER(1) not null,
  DESCRIPTION NVARCHAR2(255)
)
;
comment on column ADMINS.ID
  is '主键';
comment on column ADMINS.USERNAME
  is '用户名';
comment on column ADMINS.PASSWORD
  is '密码';
comment on column ADMINS.SALT
  is '盐';
comment on column ADMINS.STATUS
  is '状态;1为激活,0为冻结,-1为删除,';
comment on column ADMINS.CREATETIME
  is '创建时间';
comment on column ADMINS.CREATOR
  is '创建者';
comment on column ADMINS.THEME
  is '管理员的界面主题';
comment on column ADMINS.EMAIL
  is '管理员的邮箱';
comment on column ADMINS.STATICC
  is '是否为内置对象;1代表内置管理员,不可删除,修改权限,0代表不是';
comment on column ADMINS.DESCRIPTION
  is '描述';
alter table ADMINS
  add constraint ADS_PK_ID primary key (ID);
alter table ADMINS
  add constraint ADS_UK_USERNAME unique (USERNAME);
alter table ADMINS
  add constraint ADS_FK_CREATOR foreign key (CREATOR)
  references ADMINS (ID) on delete set null;

prompt
prompt Creating table ADMINS_LOGIN_LOG
prompt ===============================
prompt
create table ADMINS_LOGIN_LOG
(
  ID          NVARCHAR2(40) not null,
  LOGIN_ADMIN NVARCHAR2(40) not null,
  IP          NVARCHAR2(20) not null,
  SYSTEM      NVARCHAR2(40) not null,
  DPI         NVARCHAR2(40),
  BROWSER     NVARCHAR2(255) not null,
  COUNTRY     NVARCHAR2(40) not null,
  PROVINCE    NVARCHAR2(40) not null,
  CITY        NVARCHAR2(40) not null,
  TIME        TIMESTAMP(6) not null,
  RESULT      NUMBER(1) not null
)
;
comment on column ADMINS_LOGIN_LOG.ID
  is '主键';
comment on column ADMINS_LOGIN_LOG.LOGIN_ADMIN
  is '登录的管理员';
comment on column ADMINS_LOGIN_LOG.IP
  is 'ip地址';
comment on column ADMINS_LOGIN_LOG.SYSTEM
  is '系统,例如windows';
comment on column ADMINS_LOGIN_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column ADMINS_LOGIN_LOG.BROWSER
  is '浏览器';
comment on column ADMINS_LOGIN_LOG.COUNTRY
  is '登录国家';
comment on column ADMINS_LOGIN_LOG.PROVINCE
  is '登录省份';
comment on column ADMINS_LOGIN_LOG.CITY
  is '登录城市';
comment on column ADMINS_LOGIN_LOG.TIME
  is '登陆时间';
comment on column ADMINS_LOGIN_LOG.RESULT
  is '1为登录成功,0为因为登录失败';
alter table ADMINS_LOGIN_LOG
  add primary key (ID);
alter table ADMINS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_ADMIN foreign key (LOGIN_ADMIN)
  references ADMINS (ID);

prompt
prompt Creating table ROLES
prompt ====================
prompt
create table ROLES
(
  ID          NVARCHAR2(40) not null,
  NAME        NVARCHAR2(255) not null,
  STATUS      NUMBER(1) not null,
  DESCRIPTION NVARCHAR2(255) not null,
  STATICC     NUMBER(1) not null,
  CREATETIME  TIMESTAMP(6) not null,
  CREATOR     NVARCHAR2(40)
)
;
comment on column ROLES.ID
  is '主键';
comment on column ROLES.NAME
  is '角色名';
comment on column ROLES.STATUS
  is '状态;1为激活,0为冻结,-1为删除';
comment on column ROLES.DESCRIPTION
  is '角色描述';
comment on column ROLES.STATICC
  is '是否为内置对象;1代表内置管理员,不可删除,修改权限,0代表不是';
comment on column ROLES.CREATETIME
  is '创建时间';
comment on column ROLES.CREATOR
  is '创建者,指向adminid';
alter table ROLES
  add constraint ROLES_PK_ID primary key (ID);
alter table ROLES
  add constraint UK_ROLES_NAME unique (NAME);
alter table ROLES
  add constraint FK_ROLES_CREATOR foreign key (CREATOR)
  references ADMINS (ID) on delete set null;

prompt
prompt Creating table ADMINS_ROLES
prompt ===========================
prompt
create table ADMINS_ROLES
(
  ID        NVARCHAR2(40) not null,
  ADMIN     NVARCHAR2(40) not null,
  ROLE      NVARCHAR2(40) not null,
  GRANTTIME TIMESTAMP(6) not null
)
;
comment on column ADMINS_ROLES.ID
  is '主键';
comment on column ADMINS_ROLES.ADMIN
  is '管理员';
comment on column ADMINS_ROLES.ROLE
  is '角色';
comment on column ADMINS_ROLES.GRANTTIME
  is '赋权时间';
alter table ADMINS_ROLES
  add constraint A_R_PK_ID primary key (ID);
alter table ADMINS_ROLES
  add constraint A_R_FK_ADMIN foreign key (ADMIN)
  references ADMINS (ID) on delete cascade;
alter table ADMINS_ROLES
  add constraint A_R_FK_ROLE foreign key (ROLE)
  references ROLES (ID) on delete cascade;

prompt
prompt Creating table CLAZZS
prompt =====================
prompt
create table CLAZZS
(
  ID   NVARCHAR2(40) not null,
  TEXT NVARCHAR2(30) not null,
  NUM  NUMBER default 0 not null
)
;
comment on column CLAZZS.ID
  is '类型id';
comment on column CLAZZS.TEXT
  is '唯一的类型名';
comment on column CLAZZS.NUM
  is '各个类别商品总数';
alter table CLAZZS
  add constraint CLAZZS_PK_ID primary key (ID);
alter table CLAZZS
  add constraint CLAZZS_UK_TEXT unique (TEXT);

prompt
prompt Creating table FILES
prompt ====================
prompt
create table FILES
(
  ID   NVARCHAR2(40) not null,
  PATH NVARCHAR2(45),
  NAME NVARCHAR2(50)
)
;
comment on column FILES.ID
  is '文件主键';
comment on column FILES.PATH
  is '文件在服务器的储存路径例如:a.jpg;不要带上路径;例如：d:\floder\a.png错误,';
comment on column FILES.NAME
  is '文件原名';
alter table FILES
  add constraint FILES_PK_ID primary key (ID);

prompt
prompt Creating table GOODS
prompt ====================
prompt
create table GOODS
(
  ID                    NVARCHAR2(40) not null,
  TITLE                 NVARCHAR2(20) not null,
  DESCRIPTION           NVARCHAR2(100) not null,
  SPRICE                NUMBER not null,
  PRICE                 NUMBER not null,
  CONDITION             NUMBER(1) not null,
  REGION                NUMBER not null,
  STATUS                NUMBER(1) not null,
  CREATETIME            TIMESTAMP(6) not null,
  OWNER                 NVARCHAR2(40) not null,
  BUYER                 NVARCHAR2(40),
  BROWSENUMBER          NUMBER not null,
  LASTUPDATETIME        TIMESTAMP(6) not null,
  BUYTIME               TIMESTAMP(6),
  FINISHTIME            TIMESTAMP(6),
  TOPROVINCE            NVARCHAR2(20),
  TOCITY                NVARCHAR2(20),
  TOCOUNTY              NVARCHAR2(20),
  TODETAIL              NVARCHAR2(40),
  PHONE                 NVARCHAR2(20),
  TOREALNAME            NVARCHAR2(20),
  POSTCODE              NVARCHAR2(10),
  REFUSERETURNMONEYBILL NVARCHAR2(40)
)
;
comment on column GOODS.ID
  is '商品主键';
comment on column GOODS.TITLE
  is '商品标题';
comment on column GOODS.DESCRIPTION
  is '商品介绍';
comment on column GOODS.SPRICE
  is 'second price；商品的二手价,即转卖价';
comment on column GOODS.PRICE
  is '商品原价';
comment on column GOODS.CONDITION
  is '商品成色,1-9';
comment on column GOODS.REGION
  is '商品地区';
comment on column GOODS.STATUS
  is '-6:待审核状态,(不可以被显示,不可以购买)
          -7:审核未通过,(不可以被显示,不可以购买)
          0:审核通过,(可以被显示,可以购买)
          1:购买了且待发货,
          2:已发货,
          -1:买家收货后交易正常结束,
          -2:卖家取消了出售本商品,
        -3:买家取消购买本商品,
        -5:管理员删除本商品,
          -8:买家申请退款,
          -9:退款成功（失败则保持-1状态）';
comment on column GOODS.CREATETIME
  is '创建时间';
comment on column GOODS.OWNER
  is '发布本商品的用户';
comment on column GOODS.BUYER
  is '购买本商品的用户,没有用户购买是null';
comment on column GOODS.BROWSENUMBER
  is '浏览次数';
comment on column GOODS.LASTUPDATETIME
  is '最后一次更新时间';
comment on column GOODS.BUYTIME
  is '商品被购买时写入购买时间';
comment on column GOODS.FINISHTIME
  is '商品交易正常完成时的时间';
comment on column GOODS.TOPROVINCE
  is '收件省份';
comment on column GOODS.TOCITY
  is '收件城市';
comment on column GOODS.TOCOUNTY
  is '收件县区';
comment on column GOODS.TODETAIL
  is '收件详细地址';
comment on column GOODS.PHONE
  is '收件人电话';
comment on column GOODS.TOREALNAME
  is '收件人名字';
comment on column GOODS.POSTCODE
  is '收件地址邮编';
comment on column GOODS.REFUSERETURNMONEYBILL
  is '商家拒绝退款的凭证';
alter table GOODS
  add constraint GOODS_PK_ID primary key (ID);
alter table GOODS
  add constraint GOODS_FK_BUYER foreign key (BUYER)
  references USERS (ID) on delete cascade;
alter table GOODS
  add constraint GOODS_FK_OWNER foreign key (OWNER)
  references USERS (ID) on delete cascade;
alter table GOODS
  add constraint GOODS_FK_REGION foreign key (REGION)
  references REGION (ID) on delete cascade;
alter table GOODS
  add constraint GOODS_CK_CONDITION
  check (CONDITION BETWEEN 1 AND 10);

prompt
prompt Creating table GOODS_CLAZZS
prompt ===========================
prompt
create table GOODS_CLAZZS
(
  ID    NVARCHAR2(40) not null,
  GOODS NVARCHAR2(40) not null,
  CLAZZ NVARCHAR2(40) not null
)
;
comment on column GOODS_CLAZZS.ID
  is '主键';
comment on column GOODS_CLAZZS.GOODS
  is '指向商品的id';
comment on column GOODS_CLAZZS.CLAZZ
  is '指向类型的id';
alter table GOODS_CLAZZS
  add constraint GC_PK_ID primary key (ID);
alter table GOODS_CLAZZS
  add constraint GC_FK_CLAZZ foreign key (CLAZZ)
  references CLAZZS (ID) on delete cascade;
alter table GOODS_CLAZZS
  add constraint GC_FK_GOODS foreign key (GOODS)
  references GOODS (ID) on delete cascade;

prompt
prompt Creating table GOODS_IMGS
prompt =========================
prompt
create table GOODS_IMGS
(
  ID    NVARCHAR2(40) not null,
  OWNER NVARCHAR2(40) not null,
  IMG   NVARCHAR2(40) not null,
  MAIN  NUMBER(1) not null
)
;
comment on column GOODS_IMGS.ID
  is '商品和图片对应表的id';
comment on column GOODS_IMGS.OWNER
  is '指向商品id';
comment on column GOODS_IMGS.IMG
  is '指向文件id';
comment on column GOODS_IMGS.MAIN
  is '是否为主图:1是0否,主图只有一张';
alter table GOODS_IMGS
  add constraint GI_PK_ID primary key (ID);
alter table GOODS_IMGS
  add constraint GI_FK_IMG foreign key (IMG)
  references FILES (ID) on delete cascade;
alter table GOODS_IMGS
  add constraint GI_FK_OWNER foreign key (OWNER)
  references GOODS (ID) on delete cascade;

prompt
prompt Creating table MESSAGES
prompt =======================
prompt
create table MESSAGES
(
  ID         NVARCHAR2(40) not null,
  TEXT       VARCHAR2(100) not null,
  CREATETIME TIMESTAMP(6) not null,
  STATUS     NUMBER(1) not null,
  USERS      NVARCHAR2(40) not null,
  MESSAGE    NVARCHAR2(40),
  GOODS      NVARCHAR2(40) not null
)
;
comment on column MESSAGES.ID
  is '留言主键';
comment on column MESSAGES.TEXT
  is '留言内容';
comment on column MESSAGES.CREATETIME
  is '留言时间';
comment on column MESSAGES.STATUS
  is '状态,1已读,0未读,-1删除';
comment on column MESSAGES.USERS
  is '留言者,指向userdid';
comment on column MESSAGES.MESSAGE
  is '对那条留言回复,指向messageid';
comment on column MESSAGES.GOODS
  is '指向商品';
alter table MESSAGES
  add constraint MSGS_PK_ID primary key (ID);
alter table MESSAGES
  add constraint MSGS_FK_MSG foreign key (MESSAGE)
  references MESSAGES (ID) on delete cascade;
alter table MESSAGES
  add constraint MSGS_FK_USER foreign key (USERS)
  references USERS (ID) on delete cascade;

prompt
prompt Creating table PERMISSIONS
prompt ==========================
prompt
create table PERMISSIONS
(
  ID     NVARCHAR2(40) not null,
  TEXT   NVARCHAR2(128) not null,
  TYPE   NVARCHAR2(128),
  URL    NVARCHAR2(128),
  CODE   NVARCHAR2(128),
  PID    NVARCHAR2(40),
  PIDS   NVARCHAR2(128),
  SORT   NUMBER(2),
  STATUS NUMBER(1) not null
)
;
comment on column PERMISSIONS.ID
  is '主键';
comment on column PERMISSIONS.TEXT
  is '资源名';
comment on column PERMISSIONS.TYPE
  is '资源类型：menu,button等';
comment on column PERMISSIONS.URL
  is '访问资源url地址';
comment on column PERMISSIONS.CODE
  is '权限代码';
comment on column PERMISSIONS.PID
  is '父节点id';
comment on column PERMISSIONS.PIDS
  is '祖先节点的id,用-分割';
comment on column PERMISSIONS.SORT
  is '排序号';
comment on column PERMISSIONS.STATUS
  is '是否可用,1:可用,0:删除';
alter table PERMISSIONS
  add constraint PERMISSIONS_PK_ID primary key (ID);
alter table PERMISSIONS
  add constraint PERMISSIONS_FK_PARENTID foreign key (PID)
  references PERMISSIONS (ID) on delete cascade;

prompt
prompt Creating table ROLES_PERMISSIONS
prompt ================================
prompt
create table ROLES_PERMISSIONS
(
  ID         NVARCHAR2(40) not null,
  ROLE       NVARCHAR2(40) not null,
  PERMISSION NVARCHAR2(40) not null,
  GRANTTIME  TIMESTAMP(6) not null
)
;
comment on column ROLES_PERMISSIONS.ID
  is '主键';
comment on column ROLES_PERMISSIONS.ROLE
  is '角色id';
comment on column ROLES_PERMISSIONS.PERMISSION
  is '权限id';
comment on column ROLES_PERMISSIONS.GRANTTIME
  is '权限赋予时间';
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_PK primary key (ID);
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_P foreign key (PERMISSION)
  references PERMISSIONS (ID) on delete cascade;
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_ROLES_ID foreign key (ROLE)
  references ROLES (ID) on delete cascade;

prompt
prompt Creating table USERS_LOGIN_LOG
prompt ==============================
prompt
create table USERS_LOGIN_LOG
(
  ID         NVARCHAR2(40) not null,
  LOGIN_USER NVARCHAR2(40) not null,
  IP         NVARCHAR2(20) not null,
  SYSTEM     NVARCHAR2(40) not null,
  DPI        NVARCHAR2(40),
  BROWSER    NVARCHAR2(255) not null,
  COUNTRY    NVARCHAR2(40) not null,
  PROVINCE   NVARCHAR2(40) not null,
  CITY       NVARCHAR2(40) not null,
  TIME       TIMESTAMP(6) not null,
  RESULT     NUMBER(1) not null
)
;
comment on column USERS_LOGIN_LOG.ID
  is '主键';
comment on column USERS_LOGIN_LOG.LOGIN_USER
  is '登录的用户';
comment on column USERS_LOGIN_LOG.IP
  is 'ip地址';
comment on column USERS_LOGIN_LOG.SYSTEM
  is '系统,例如windows';
comment on column USERS_LOGIN_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column USERS_LOGIN_LOG.BROWSER
  is '浏览器';
comment on column USERS_LOGIN_LOG.COUNTRY
  is '登录国家';
comment on column USERS_LOGIN_LOG.PROVINCE
  is '登录省份';
comment on column USERS_LOGIN_LOG.CITY
  is '登录城市';
comment on column USERS_LOGIN_LOG.TIME
  is '登陆时间';
comment on column USERS_LOGIN_LOG.RESULT
  is '1为登录成功,0为因为登录失败';
alter table USERS_LOGIN_LOG
  add primary key (ID);
alter table USERS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_USER foreign key (LOGIN_USER)
  references USERS (ID);

prompt
prompt Creating table WANDER_LOG
prompt =========================
prompt
create table WANDER_LOG
(
  ID       NVARCHAR2(40) not null,
  IP       NVARCHAR2(20) not null,
  PAGE     NVARCHAR2(255) not null,
  OLD_LINK NVARCHAR2(40),
  TITLE    NVARCHAR2(40),
  SYSTEM   NVARCHAR2(40) not null,
  DPI      NVARCHAR2(40),
  BROWSER  NVARCHAR2(40) not null,
  COUNTRY  NVARCHAR2(40) not null,
  PROVINCE NVARCHAR2(40) not null,
  CITY     NVARCHAR2(40) not null,
  KEYWORD  NVARCHAR2(40),
  TIME     TIMESTAMP(6) not null
)
;
comment on column WANDER_LOG.ID
  is '主键';
comment on column WANDER_LOG.IP
  is 'ip地址';
comment on column WANDER_LOG.PAGE
  is '访问的页面';
comment on column WANDER_LOG.OLD_LINK
  is '上一个连接';
comment on column WANDER_LOG.TITLE
  is '页面标题';
comment on column WANDER_LOG.SYSTEM
  is '系统,例如windows';
comment on column WANDER_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column WANDER_LOG.BROWSER
  is '浏览器';
comment on column WANDER_LOG.COUNTRY
  is '登录国家';
comment on column WANDER_LOG.PROVINCE
  is '登录省份';
comment on column WANDER_LOG.CITY
  is '登录城市';
comment on column WANDER_LOG.KEYWORD
  is '关键字';
comment on column WANDER_LOG.TIME
  is '登陆时间';
alter table WANDER_LOG
  add primary key (ID);

prompt
prompt Creating function GETCLAZZSBYGOODSID
prompt ====================================
prompt
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
/

prompt
prompt Creating function GETGOODSMAINIMGPATH
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION getGoodsMainImgPath(goodsid IN NVARCHAR2)
/*通过商品id获取图片路径,如:a.jpg*/
RETURN NVARCHAR2
AS

       r NVARCHAR2(255);
BEGIN

       select f.path into r
       from  files f,goods_imgs gi
       where f.id=gi.img and gi.main = 1 and gi.owner = goodsid;

       RETURN r;
END;
/

prompt
prompt Creating function GETGOODSMESSAGENUM
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION getGoodsMessageNum(goodsid IN NVARCHAR2)
RETURN NUMBER
AS

       r NUMBER;
BEGIN

       select count(messages.id 

) into r
       from  messages
       where  messages.goods = goodsid;

       RETURN r;
END;
/

prompt
prompt Creating function GETIMGSPATHBYGOODSID
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION getImgsPathByGoodsId(goodsid IN NVARCHAR2)
RETURN NVARCHAR2
AS
    type table_imgs IS TABLE OF files.path%TYPE NOT NULL INDEX by binary_integer;

    cr table_imgs;
    r NVARCHAR2(255);
BEGIN
    select path BULK COLLECT into cr from files where id in(
           select img from goods_imgs
           where owner=goodsid);

    IF  cr.count() >0 THEN

         for i in cr.first..cr.last loop
             r := cr(i)||'/'||r;
         end loop;

         r:=substr(r,0,length(r)-1);

     END IF;
     RETURN r;
END;
/

prompt
prompt Creating function GETMSGRECIVERID
prompt =================================
prompt
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
/

prompt
prompt Creating function GETMSGRECIVERNAME
prompt ===================================
prompt
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
/

prompt
prompt Creating function GETREGIONBYBASEID
prompt ===================================
prompt
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
/

prompt
prompt Creating function GETROLESBYADMINID
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION getRolesByAdminId(adminId IN VARCHAR2)
RETURN VARCHAR2
AS
       type table_my IS TABLE OF roles.name%TYPE NOT NULL INDEX BY BINARY_INTEGER;
       cr table_my;
       r NVARCHAR2(255);
BEGIN

       SELECT r.name BULK COLLECT INTO cr FROM ROLES r,ADMINS_ROLES AR WHERE r.ID = ar.ROLE AND ar.ADMIN = adminId;


       IF  cr.count() >0 THEN

         for i in cr.first..cr.last loop
             r := cr(i)||','||r;
         end loop;

         r:=substr(r,0,length(r)-1);

       END IF;

       RETURN r;
END;
/

prompt
prompt Creating procedure RECEIVERGOODS
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE receiverGoods
IS
       type table_my IS TABLE OF goods.id%TYPE NOT NULL INDEX by binary_integer;
       cr table_my;
       type table_my_0 IS TABLE OF goods.owner%TYPE NOT NULL INDEX by binary_integer;
       cr_0 table_my_0;

       type table_my_1 IS TABLE OF goods.SPRICE%TYPE NOT NULL INDEX by binary_integer;
       cr_1 table_my_1;

BEGIN
       /*过期的goods*/
       SELECT goods.id, goods.owner,goods.SPRICE BULK COLLECT into cr,cr_0,cr_1  FROM goods WHERE goods.STATUS = 2 AND (SYSDATE - Cast(goods.BUYTIME As Date))>7;


        IF  cr.count() >0 THEN

         for i in cr.first..cr.last loop

            /*已收货状态*/
           UPDATE goods g
           SET g.STATUS = -1 WHERE  g.id = cr(i);
           /*已收货时间*/
           UPDATE goods g
           SET g.FINISHTIME = SYSDATE WHERE  g.id = cr(i);
           /*打钱*/
            UPDATE users u
           SET u.MONEY = u.MONEY + cr_1(i) WHERE  u.id = cr_0(i);

         end loop;

       END IF;
END;
/

prompt
prompt Creating procedure SYNCCLAZZSNUM
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE syncClazzsNum
IS

BEGIN
       UPDATE clazzs c
       SET c.NUM = (SELECT COUNT(g.id) FROM GOODS_CLAZZS gc,goods g WHERE gc.clazz = c.ID AND gc.GOODS= g.id AND g.STATUS = 0);
END;
/

prompt
prompt Creating trigger UPDATECLAZZNUMBYGOODSSTATUS
prompt ============================================
prompt
CREATE OR REPLACE TRIGGER updateClazzNumByGoodsStatus
BEFORE UPDATE OF status
ON goods
FOR EACH ROW
declare

  type table_my IS TABLE OF CLAZZS.id%TYPE NOT NULL INDEX by binary_integer;
  cr table_my;
  newStatus goods.STATUS%TYPE;
  oldStatus goods.STATUS%TYPE;
  d NUMBER :=0;
begin
  oldStatus := :OLD.status;
  newStatus := :NEW.status;
  IF newStatus = 1 OR newStatus = 0 OR newStatus = -5 OR newStatus=-7 THEN
      select gc.CLAZZ BULK COLLECT into cr FROM goods_clazzs gc WHERE gc.GOODS = :OLD.id;
      IF newStatus = 0 THEN

       d := 1;

     END IF;

    IF newStatus = 1 OR newStatus = -5 OR newStatus=-7 THEN
       d := -1;

    END IF;
    IF  cr.count() >0 THEN
      FOR i IN cr.first .. cr.last loop
         UPDATE clazzs SET num = num+d WHERE ID=cr(i);
      END LOOP;
    END IF;

  END IF;
END;
/


spool off
