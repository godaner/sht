prompt PL/SQL Developer import file
prompt Created on 2017年9月27日 by Kor_Zhang
set feedback off
set define off
prompt Creating REGION...
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
  add constraint REGION_KEY primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating USERS...
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
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
  add constraint USERS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USERS
  add constraint USERS_UK_EMAIL unique (EMAIL)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USERS
  add constraint USERS_UK_USERNAME unique (USERNAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USERS
  add constraint USERS_CK_SEX
  check (SEX IN (-1,1,0) );

prompt Creating ADDRS...
create table ADDRS
(
  ID        NVARCHAR2(40) not null,
  MASTER    NVARCHAR2(40) not null,
  REGION    NUMBER not null,
  DETAIL    NVARCHAR2(40) not null,
  POHNE     NVARCHAR2(20) not null,
  REALNAME  NVARCHAR2(20) not null,
  ISDEFAULT NUMBER(1) not null,
  POSTCODE  VARCHAR2(10)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column ADDRS.ID
  is '主键';
comment on column ADDRS.MASTER
  is '指向用户的id';
comment on column ADDRS.REGION
  is '指向地址最低级的id;省-市-县;如:湖南省-张家界-慈利县';
comment on column ADDRS.DETAIL
  is '地址详情;如:吉首大学张家界校区1食堂';
comment on column ADDRS.POHNE
  is '联系电话';
comment on column ADDRS.REALNAME
  is '收货人姓名';
comment on column ADDRS.ISDEFAULT
  is '是否为默认地址';
comment on column ADDRS.POSTCODE
  is '邮编';
alter table ADDRS
  add constraint ADDRS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ADDRS
  add constraint ADDRS_FK_MASTER foreign key (MASTER)
  references USERS (ID) on delete cascade;
alter table ADDRS
  add constraint ADDRS_FK_REGION foreign key (REGION)
  references REGION (ID) on delete cascade;

prompt Creating ADMINS...
create table ADMINS
(
  ID         NVARCHAR2(40) not null,
  USERNAME   NVARCHAR2(255) not null,
  PASSWORD   NVARCHAR2(40) not null,
  SALT       NVARCHAR2(40),
  STATUS     NUMBER not null,
  CREATETIME TIMESTAMP(6) not null,
  CREATOR    NVARCHAR2(40),
  THEME      NVARCHAR2(40),
  EMAIL      NVARCHAR2(255) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column ADMINS.ID
  is '主键';
comment on column ADMINS.USERNAME
  is '用户名';
comment on column ADMINS.PASSWORD
  is '密码';
comment on column ADMINS.SALT
  is '盐';
comment on column ADMINS.STATUS
  is '状态;1为激活,0为冻结,-1为删除';
comment on column ADMINS.CREATETIME
  is '创建时间';
comment on column ADMINS.CREATOR
  is '创建者';
comment on column ADMINS.THEME
  is '管理员的界面主题';
comment on column ADMINS.EMAIL
  is '管理员的邮箱';
alter table ADMINS
  add constraint ADS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ADMINS
  add constraint ADS_UK_USERNAME unique (USERNAME)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ADMINS
  add constraint ADS_FK_CREATOR foreign key (CREATOR)
  references ADMINS (ID) on delete set null;

prompt Creating ADMINS_LOGIN_LOG...
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
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
  add primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ADMINS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_ADMIN foreign key (LOGIN_ADMIN)
  references ADMINS (ID);

prompt Creating ROLES...
create table ROLES
(
  ID     NVARCHAR2(40) not null,
  NAME   NVARCHAR2(20) not null,
  STATUS NUMBER(1) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column ROLES.ID
  is '主键';
comment on column ROLES.NAME
  is '角色名';
comment on column ROLES.STATUS
  is '是否可用,1:可用,0:删除';
alter table ROLES
  add constraint ROLES_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ADMINS_ROLES...
create table ADMINS_ROLES
(
  ID        NVARCHAR2(40) not null,
  ADMIN     NVARCHAR2(40) not null,
  ROLE      NVARCHAR2(40) not null,
  GRANTTIME TIMESTAMP(6) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column ADMINS_ROLES.ID
  is '主键';
comment on column ADMINS_ROLES.ADMIN
  is '管理员';
comment on column ADMINS_ROLES.ROLE
  is '角色';
comment on column ADMINS_ROLES.GRANTTIME
  is '赋权时间';
alter table ADMINS_ROLES
  add constraint A_R_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ADMINS_ROLES
  add constraint A_R_FK_ADMIN foreign key (ADMIN)
  references ADMINS (ID) on delete cascade;
alter table ADMINS_ROLES
  add constraint A_R_FK_ROLE foreign key (ROLE)
  references ROLES (ID) on delete cascade;

prompt Creating CLAZZS...
create table CLAZZS
(
  ID   NVARCHAR2(40) not null,
  TEXT NVARCHAR2(30) not null,
  NUM  NUMBER default 0 not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column CLAZZS.ID
  is '类型id';
comment on column CLAZZS.TEXT
  is '唯一的类型名';
comment on column CLAZZS.NUM
  is '各个类别商品总数';
alter table CLAZZS
  add constraint CLAZZS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLAZZS
  add constraint CLAZZS_UK_TEXT unique (TEXT)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating FILES...
create table FILES
(
  ID   NVARCHAR2(40) not null,
  PATH NVARCHAR2(45),
  NAME NVARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column FILES.ID
  is '文件主键';
comment on column FILES.PATH
  is '文件在服务器的储存路径例如:a.jpg;不要带上路径;例如：d:\floder\a.png错误,';
comment on column FILES.NAME
  is '文件原名';
alter table FILES
  add constraint FILES_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating GOODS...
create table GOODS
(
  ID             NVARCHAR2(40) not null,
  TITLE          NVARCHAR2(20) not null,
  DESCRIPTION    NVARCHAR2(100) not null,
  SPRICE         NUMBER not null,
  PRICE          NUMBER not null,
  CONDITION      NUMBER(1) not null,
  REGION         NUMBER not null,
  STATUS         NUMBER(1) not null,
  CREATETIME     TIMESTAMP(6) not null,
  OWNER          NVARCHAR2(40) not null,
  BUYER          NVARCHAR2(40),
  BROWSENUMBER   NUMBER not null,
  LASTUPDATETIME TIMESTAMP(6) not null,
  BUYTIME        TIMESTAMP(6),
  FINISHTIME     TIMESTAMP(6)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
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
			-5:管理员删除本商品';
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
alter table GOODS
  add constraint GOODS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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

prompt Creating GOODS_CLAZZS...
create table GOODS_CLAZZS
(
  ID    NVARCHAR2(40) not null,
  GOODS NVARCHAR2(40) not null,
  CLAZZ NVARCHAR2(40) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column GOODS_CLAZZS.ID
  is '主键';
comment on column GOODS_CLAZZS.GOODS
  is '指向商品的id';
comment on column GOODS_CLAZZS.CLAZZ
  is '指向类型的id';
alter table GOODS_CLAZZS
  add constraint GC_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GOODS_CLAZZS
  add constraint GC_FK_CLAZZ foreign key (CLAZZ)
  references CLAZZS (ID) on delete cascade;
alter table GOODS_CLAZZS
  add constraint GC_FK_GOODS foreign key (GOODS)
  references GOODS (ID) on delete cascade;

prompt Creating GOODS_IMGS...
create table GOODS_IMGS
(
  ID    NVARCHAR2(40) not null,
  OWNER NVARCHAR2(40) not null,
  IMG   NVARCHAR2(40) not null,
  MAIN  NUMBER(1) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column GOODS_IMGS.ID
  is '商品和图片对应表的id';
comment on column GOODS_IMGS.OWNER
  is '指向商品id';
comment on column GOODS_IMGS.IMG
  is '指向文件id';
comment on column GOODS_IMGS.MAIN
  is '是否为主图:1是0否,主图只有一张';
alter table GOODS_IMGS
  add constraint GI_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GOODS_IMGS
  add constraint GI_FK_IMG foreign key (IMG)
  references FILES (ID) on delete cascade;
alter table GOODS_IMGS
  add constraint GI_FK_OWNER foreign key (OWNER)
  references GOODS (ID) on delete cascade;

prompt Creating MESSAGES...
create table MESSAGES
(
  ID         NVARCHAR2(40) not null,
  LAUNCHER   NVARCHAR2(40) not null,
  RECEIVER   NVARCHAR2(40) not null,
  TEXT       VARCHAR2(100),
  CREATETIME TIMESTAMP(6)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column MESSAGES.ID
  is '留言主键';
comment on column MESSAGES.LAUNCHER
  is '留言发起者';
comment on column MESSAGES.RECEIVER
  is '接收留言的商品';
comment on column MESSAGES.TEXT
  is '留言内容';
comment on column MESSAGES.CREATETIME
  is '留言时间';
alter table MESSAGES
  add constraint MSGS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MESSAGES
  add constraint MSGS_FK_LAUNCHER foreign key (LAUNCHER)
  references USERS (ID) on delete cascade;
alter table MESSAGES
  add constraint MSGS_FK_RECEIVER foreign key (RECEIVER)
  references GOODS (ID) on delete cascade;

prompt Creating PERMISSIONS...
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
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
  add constraint PERMISSIONS_PK_ID primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PERMISSIONS
  add constraint PERMISSIONS_FK_PARENTID foreign key (PID)
  references PERMISSIONS (ID) on delete cascade;

prompt Creating ROLES_PERMISSIONS...
create table ROLES_PERMISSIONS
(
  ID         NVARCHAR2(40) not null,
  ROLE       NVARCHAR2(40) not null,
  PERMISSION NVARCHAR2(40) not null,
  GRANTTIME  TIMESTAMP(6) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
comment on column ROLES_PERMISSIONS.ID
  is '主键';
comment on column ROLES_PERMISSIONS.ROLE
  is '角色id';
comment on column ROLES_PERMISSIONS.PERMISSION
  is '权限id';
comment on column ROLES_PERMISSIONS.GRANTTIME
  is '权限赋予时间';
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_PK primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_P foreign key (PERMISSION)
  references PERMISSIONS (ID) on delete cascade;
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_ROLES_ID foreign key (ROLE)
  references ROLES (ID) on delete cascade;

prompt Creating USERS_LOGIN_LOG...
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
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
  add primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USERS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_USER foreign key (LOGIN_USER)
  references USERS (ID);

prompt Creating WANDER_LOG...
create table WANDER_LOG
(
  ID       NVARCHAR2(40) not null,
  IP       NVARCHAR2(20) not null,
  PAGE     NVARCHAR2(40) not null,
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
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 8K
    minextents 1
    maxextents unlimited
  );
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
  add primary key (ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Loading REGION...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2508, '450702', '钦南区', 259, 0, 0, 'Qinnan Qu', 'QNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2514, '450803', '港南区', 260, 0, 0, 'Gangnan Qu', 'GNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2522, '450923', '博白县', 261, 0, 0, 'Bobai Xian', 'BBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2527, '451021', '田阳县', 262, 0, 0, 'Tianyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2531, '451025', '靖西县', 262, 0, 0, 'Jingxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2534, '451028', '乐业县', 262, 0, 0, 'Leye Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2537, '451031', '隆林各族自治县', 262, 0, 0, 'Longlin Gezu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2542, '451123', '富川瑶族自治县', 263, 0, 0, 'Fuchuan Yaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2549, '451225', '罗城仫佬族自治县', 264, 0, 0, 'Luocheng Mulaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2551, '451227', '巴马瑶族自治县', 264, 0, 0, 'Bama Yaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2554, '451281', '宜州市', 264, 0, 0, 'Yizhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2559, '451323', '武宣县', 265, 0, 0, 'Wuxuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2561, '451381', '合山市', 265, 0, 0, 'Heshan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2565, '451422', '宁明县', 266, 0, 0, 'Ningming Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1648, '360481', '瑞昌市', 162, 0, 0, 'Ruichang Shi', 'RCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1650, '360502', '渝水区', 163, 0, 0, 'Yushui Qu', 'YSR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1651, '360521', '分宜县', 163, 0, 0, 'Fenyi Xian', 'FYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1652, '360601', '市辖区', 164, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1654, '360622', '余江县', 164, 0, 0, 'Yujiang Xian', 'YUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1655, '360681', '贵溪市', 164, 0, 0, 'Guixi Shi', 'GXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1656, '360701', '市辖区', 165, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1658, '360721', '赣县', 165, 0, 0, 'Gan Xian', 'GXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1659, '360722', '信丰县', 165, 0, 0, 'Xinfeng Xian ', 'XNF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1660, '360723', '大余县', 165, 0, 0, 'Dayu Xian', 'DYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1662, '360725', '崇义县', 165, 0, 0, 'Chongyi Xian', 'CYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1663, '360726', '安远县', 165, 0, 0, 'Anyuan Xian', 'AYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1664, '360727', '龙南县', 165, 0, 0, 'Longnan Xian', 'LNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1666, '360729', '全南县', 165, 0, 0, 'Quannan Xian', 'QNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1667, '360730', '宁都县', 165, 0, 0, 'Ningdu Xian', 'NDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1668, '360731', '于都县', 165, 0, 0, 'Yudu Xian', 'YUD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1670, '360733', '会昌县', 165, 0, 0, 'Huichang Xian', 'HIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1671, '360734', '寻乌县', 165, 0, 0, 'Xunwu Xian', 'XNW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1672, '360735', '石城县', 165, 0, 0, 'Shicheng Xian', 'SIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1674, '360782', '南康市', 165, 0, 0, 'Nankang Shi', 'NNK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1675, '360801', '市辖区', 166, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1676, '360802', '吉州区', 166, 0, 0, 'Jizhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1678, '360821', '吉安县', 166, 0, 0, 'Ji,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1679, '360822', '吉水县', 166, 0, 0, 'Jishui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1680, '360823', '峡江县', 166, 0, 0, 'Xiajiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1682, '360825', '永丰县', 166, 0, 0, 'Yongfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1683, '360826', '泰和县', 166, 0, 0, 'Taihe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1684, '360827', '遂川县', 166, 0, 0, 'Suichuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1686, '360829', '安福县', 166, 0, 0, 'Anfu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1687, '360830', '永新县', 166, 0, 0, 'Yongxin Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1688, '360881', '井冈山市', 166, 0, 0, 'Jinggangshan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1690, '360902', '袁州区', 167, 0, 0, 'Yuanzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1691, '360921', '奉新县', 167, 0, 0, 'Fengxin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1692, '360922', '万载县', 167, 0, 0, 'Wanzai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1694, '360924', '宜丰县', 167, 0, 0, 'Yifeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1695, '360925', '靖安县', 167, 0, 0, 'Jing,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1696, '360926', '铜鼓县', 167, 0, 0, 'Tonggu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1697, '360981', '丰城市', 167, 0, 0, 'Fengcheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1698, '360982', '樟树市', 167, 0, 0, 'Zhangshu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1699, '360983', '高安市', 167, 0, 0, 'Gao,an Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1700, '361001', '市辖区', 168, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1701, '361002', '临川区', 168, 0, 0, 'Linchuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1702, '361021', '南城县', 168, 0, 0, 'Nancheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1703, '361022', '黎川县', 168, 0, 0, 'Lichuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1704, '361023', '南丰县', 168, 0, 0, 'Nanfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1705, '361024', '崇仁县', 168, 0, 0, 'Chongren Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1706, '361025', '乐安县', 168, 0, 0, 'Le,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1707, '361026', '宜黄县', 168, 0, 0, 'Yihuang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1708, '361027', '金溪县', 168, 0, 0, 'Jinxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1709, '361028', '资溪县', 168, 0, 0, 'Zixi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1710, '361029', '东乡县', 168, 0, 0, 'Dongxiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1711, '361030', '广昌县', 168, 0, 0, 'Guangchang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1712, '361101', '市辖区', 169, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1713, '361102', '信州区', 169, 0, 0, 'Xinzhou Qu', 'XZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1714, '361121', '上饶县', 169, 0, 0, 'Shangrao Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1715, '361122', '广丰县', 169, 0, 0, 'Guangfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1716, '361123', '玉山县', 169, 0, 0, 'Yushan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1717, '361124', '铅山县', 169, 0, 0, 'Qianshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1718, '361125', '横峰县', 169, 0, 0, 'Hengfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1719, '361126', '弋阳县', 169, 0, 0, 'Yiyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1720, '361127', '余干县', 169, 0, 0, 'Yugan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1721, '361128', '鄱阳县', 169, 0, 0, 'Poyang Xian', 'PYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1722, '361129', '万年县', 169, 0, 0, 'Wannian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1723, '361130', '婺源县', 169, 0, 0, 'Wuyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1724, '361181', '德兴市', 169, 0, 0, 'Dexing Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1725, '370101', '市辖区', 170, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1726, '370102', '历下区', 170, 0, 0, 'Lixia Qu', 'LXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1727, '370101', '市中区', 170, 0, 0, 'Shizhong Qu', 'SZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1728, '370104', '槐荫区', 170, 0, 0, 'Huaiyin Qu', 'HYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1729, '370105', '天桥区', 170, 0, 0, 'Tianqiao Qu', 'TQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1730, '370112', '历城区', 170, 0, 0, 'Licheng Qu', 'LCZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1731, '370113', '长清区', 170, 0, 0, 'Changqing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1732, '370124', '平阴县', 170, 0, 0, 'Pingyin Xian', 'PYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1733, '370125', '济阳县', 170, 0, 0, 'Jiyang Xian', 'JYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1734, '370126', '商河县', 170, 0, 0, 'Shanghe Xian', 'SGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1735, '370181', '章丘市', 170, 0, 0, 'Zhangqiu Shi', 'ZQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1736, '370201', '市辖区', 171, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1737, '370202', '市南区', 171, 0, 0, 'Shinan Qu', 'SNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1738, '370203', '市北区', 171, 0, 0, 'Shibei Qu', 'SBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1739, '370205', '四方区', 171, 0, 0, 'Sifang Qu', 'SFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1740, '370211', '黄岛区', 171, 0, 0, 'Huangdao Qu', 'HDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1741, '370212', '崂山区', 171, 0, 0, 'Laoshan Qu', 'LQD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1742, '370213', '李沧区', 171, 0, 0, 'Licang Qu', 'LCT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1743, '370214', '城阳区', 171, 0, 0, 'Chengyang Qu', 'CEY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1744, '370281', '胶州市', 171, 0, 0, 'Jiaozhou Shi', 'JZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1745, '370282', '即墨市', 171, 0, 0, 'Jimo Shi', 'JMO');
commit;
prompt 100 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1746, '370283', '平度市', 171, 0, 0, 'Pingdu Shi', 'PDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1747, '370284', '胶南市', 171, 0, 0, 'Jiaonan Shi', 'JNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1748, '370285', '莱西市', 171, 0, 0, 'Laixi Shi', 'LXE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1749, '370301', '市辖区', 172, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1750, '370302', '淄川区', 172, 0, 0, 'Zichuan Qu', 'ZCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1751, '370303', '张店区', 172, 0, 0, 'Zhangdian Qu', 'ZDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1752, '370304', '博山区', 172, 0, 0, 'Boshan Qu', 'BSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1753, '370305', '临淄区', 172, 0, 0, 'Linzi Qu', 'LZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1754, '370306', '周村区', 172, 0, 0, 'Zhoucun Qu', 'ZCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1755, '370321', '桓台县', 172, 0, 0, 'Huantai Xian', 'HTL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1756, '370322', '高青县', 172, 0, 0, 'Gaoqing Xian', 'GQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1758, '370401', '市辖区', 173, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1759, '370402', '市中区', 173, 0, 0, 'Shizhong Qu', 'SZZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1760, '370403', '薛城区', 173, 0, 0, 'Xuecheng Qu', 'XEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1761, '370404', '峄城区', 173, 0, 0, 'Yicheng Qu', 'YZZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1763, '370406', '山亭区', 173, 0, 0, 'Shanting Qu', 'STG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1764, '370481', '滕州市', 173, 0, 0, 'Tengzhou Shi', 'TZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1765, '370501', '市辖区', 174, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1766, '370502', '东营区', 174, 0, 0, 'Dongying Qu', 'DYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1768, '370521', '垦利县', 174, 0, 0, 'Kenli Xian', 'KLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1769, '370522', '利津县', 174, 0, 0, 'Lijin Xian', 'LJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1771, '370601', '市辖区', 175, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1772, '370602', '芝罘区', 175, 0, 0, 'Zhifu Qu', 'ZFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1773, '370611', '福山区', 175, 0, 0, 'Fushan Qu', 'FUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1774, '370612', '牟平区', 175, 0, 0, 'Muping Qu', 'MPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1775, '370613', '莱山区', 175, 0, 0, 'Laishan Qu', 'LYT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1777, '370681', '龙口市', 175, 0, 0, 'Longkou Shi', 'LKU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1778, '370682', '莱阳市', 175, 0, 0, 'Laiyang Shi', 'LYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1780, '370684', '蓬莱市', 175, 0, 0, 'Penglai Shi', 'PLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1781, '370685', '招远市', 175, 0, 0, 'Zhaoyuan Shi', 'ZYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1783, '370687', '海阳市', 175, 0, 0, 'Haiyang Shi', 'HYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1784, '370701', '市辖区', 176, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1785, '370702', '潍城区', 176, 0, 0, 'Weicheng Qu', 'WCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1786, '370703', '寒亭区', 176, 0, 0, 'Hanting Qu', 'HNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1788, '370705', '奎文区', 176, 0, 0, 'Kuiwen Qu', 'KWN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1789, '370724', '临朐县', 176, 0, 0, 'Linqu Xian', 'LNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1791, '370781', '青州市', 176, 0, 0, 'Qingzhou Shi', 'QGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1792, '370782', '诸城市', 176, 0, 0, 'Zhucheng Shi', 'ZCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1794, '370784', '安丘市', 176, 0, 0, 'Anqiu Shi', 'AQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1795, '370785', '高密市', 176, 0, 0, 'Gaomi Shi', 'GMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1796, '370786', '昌邑市', 176, 0, 0, 'Changyi Shi', 'CYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1797, '370801', '市辖区', 177, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1798, '370802', '市中区', 177, 0, 0, 'Shizhong Qu', 'SZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1800, '370826', '微山县', 177, 0, 0, 'Weishan Xian', 'WSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1801, '370827', '鱼台县', 177, 0, 0, 'Yutai Xian', 'YTL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1802, '370828', '金乡县', 177, 0, 0, 'Jinxiang Xian', 'JXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1804, '370830', '汶上县', 177, 0, 0, 'Wenshang Xian', 'WNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1805, '370831', '泗水县', 177, 0, 0, 'Sishui Xian', 'SSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1807, '370881', '曲阜市', 177, 0, 0, 'Qufu Shi', 'QFU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1808, '370882', '兖州市', 177, 0, 0, 'Yanzhou Shi', 'YZL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1810, '370901', '市辖区', 178, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1811, '370902', '泰山区', 178, 0, 0, 'Taishan Qu', 'TSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1812, '370911', '岱岳区', 178, 0, 0, 'Daiyue Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1813, '370921', '宁阳县', 178, 0, 0, 'Ningyang Xian', 'NGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1814, '370923', '东平县', 178, 0, 0, 'Dongping Xian', 'DPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1816, '370983', '肥城市', 178, 0, 0, 'Feicheng Shi', 'FEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1817, '371001', '市辖区', 179, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1818, '371002', '环翠区', 179, 0, 0, 'Huancui Qu', 'HNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1820, '371082', '荣成市', 179, 0, 0, 'Rongcheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1821, '371083', '乳山市', 179, 0, 0, 'Rushan Shi', 'RSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1822, '371101', '市辖区', 180, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1823, '371102', '东港区', 180, 0, 0, 'Donggang Qu', 'DGR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1824, '371103', '岚山区', 180, 0, 0, 'Lanshan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1825, '371121', '五莲县', 180, 0, 0, 'Wulian Xian', 'WLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1827, '371201', '市辖区', 181, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1828, '371202', '莱城区', 181, 0, 0, 'Laicheng Qu', 'LAC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3457, '652826', '焉耆回族自治县', 369, 0, 0, 'Yanqi Huizu Zizhixian', 'YQI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3458, '652827', '和静县', 369, 0, 0, 'Hejing Xian', 'HJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3459, '652828', '和硕县', 369, 0, 0, 'Hoxud Xian', 'HOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3460, '652829', '博湖县', 369, 0, 0, 'Bohu(Bagrax) Xian', 'BHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3462, '652922', '温宿县', 370, 0, 0, 'Wensu Xian', 'WSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3463, '652923', '库车县', 370, 0, 0, 'Kuqa Xian', 'KUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3464, '652924', '沙雅县', 370, 0, 0, 'Xayar Xian', 'XYR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3465, '652925', '新和县', 370, 0, 0, 'Xinhe(Toksu) Xian', 'XHT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3466, '652926', '拜城县', 370, 0, 0, 'Baicheng(Bay) Xian', 'BCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3467, '652927', '乌什县', 370, 0, 0, 'Wushi(Uqturpan) Xian', 'WSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3468, '652928', '阿瓦提县', 370, 0, 0, 'Awat Xian', 'AWA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3469, '652929', '柯坪县', 370, 0, 0, 'Kalpin Xian', 'KAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3470, '653001', '阿图什市', 371, 0, 0, 'Artux Shi', 'ART');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3471, '653022', '阿克陶县', 371, 0, 0, 'Akto Xian', 'AKT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3473, '653024', '乌恰县', 371, 0, 0, 'Wuqia(Ulugqat) Xian', 'WQA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3474, '653101', '喀什市', 372, 0, 0, 'Kashi (Kaxgar) Shi', 'KHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3475, '653121', '疏附县', 372, 0, 0, 'Shufu Xian', 'SFU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3477, '653123', '英吉沙县', 372, 0, 0, 'Yengisar Xian', 'YEN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3478, '653124', '泽普县', 372, 0, 0, 'Zepu(Poskam) Xian', 'ZEP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3479, '653125', '莎车县', 372, 0, 0, 'Shache(Yarkant) Xian', 'SHC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3481, '653127', '麦盖提县', 372, 0, 0, 'Markit Xian', 'MAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3482, '653128', '岳普湖县', 372, 0, 0, 'Yopurga Xian', 'YOP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3484, '653130', '巴楚县', 372, 0, 0, 'Bachu(Maralbexi) Xian', 'BCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3486, '653201', '和田市', 373, 0, 0, 'Hotan Shi', 'HTS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3487, '653221', '和田县', 373, 0, 0, 'Hotan Xian', 'HOT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3488, '653222', '墨玉县', 373, 0, 0, 'Moyu(Karakax) Xian', 'MOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3489, '653223', '皮山县', 373, 0, 0, 'Pishan(Guma) Xian', 'PSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3490, '653224', '洛浦县', 373, 0, 0, 'Lop Xian', 'LOP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3491, '653225', '策勒县', 373, 0, 0, 'Qira Xian', 'QIR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3492, '653226', '于田县', 373, 0, 0, 'Yutian(Keriya) Xian', 'YUT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3493, '653227', '民丰县', 373, 0, 0, 'Minfeng(Niya) Xian', 'MFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3495, '654003', '奎屯市', 374, 0, 0, 'Kuytun Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3496, '654021', '伊宁县', 374, 0, 0, 'Yining(Gulja) Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3498, '654023', '霍城县', 374, 0, 0, 'Huocheng Xin', '2');
commit;
prompt 200 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3499, '654024', '巩留县', 374, 0, 0, 'Gongliu(Tokkuztara) Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3500, '654025', '新源县', 374, 0, 0, 'Xinyuan(Kunes) Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3501, '654026', '昭苏县', 374, 0, 0, 'Zhaosu(Mongolkure) Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3502, '654027', '特克斯县', 374, 0, 0, 'Tekes Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3503, '654028', '尼勒克县', 374, 0, 0, 'Nilka Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3505, '654202', '乌苏市', 375, 0, 0, 'Usu Shi', 'USU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3506, '654221', '额敏县', 375, 0, 0, 'Emin(Dorbiljin) Xian', 'EMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3507, '654223', '沙湾县', 375, 0, 0, 'Shawan Xian', 'SWX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3509, '654225', '裕民县', 375, 0, 0, 'Yumin(Qagantokay) Xian', 'YMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3511, '654301', '阿勒泰市', 376, 0, 0, 'Altay Shi', 'ALT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3512, '654321', '布尔津县', 376, 0, 0, 'Burqin Xian', 'BUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3513, '654322', '富蕴县', 376, 0, 0, 'Fuyun(Koktokay) Xian', 'FYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3514, '654323', '福海县', 376, 0, 0, 'Fuhai(Burultokay) Xian', 'FHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3515, '654324', '哈巴河县', 376, 0, 0, 'Habahe(Kaba) Xian', 'HBH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3516, '654325', '青河县', 376, 0, 0, 'Qinghe(Qinggil) Xian', 'QHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3518, '659001', '石河子市', 377, 0, 0, 'Shihezi Shi', 'SHZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3519, '659002', '阿拉尔市', 377, 0, 0, 'Alaer Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3521, '659004', '五家渠市', 377, 0, 0, 'Wujiaqu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (109, '320100', '南京市', 11, 0, 0, 'Nanjing Shi', 'NKG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (112, '320400', '常州市', 11, 0, 0, 'Changzhou Shi', 'CZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (116, '320800', '淮安市', 11, 0, 0, 'Huai,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (120, '321200', '泰州市', 11, 0, 0, 'Taizhou Shi', 'TZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (123, '330200', '宁波市', 12, 0, 0, 'Ningbo Shi', 'NGB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (127, '330600', '绍兴市', 12, 0, 0, 'Shaoxing Shi', 'SXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (131, '331000', '台州市', 12, 0, 0, 'Taizhou Shi', 'TZZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (135, '340300', '蚌埠市', 13, 0, 0, 'Bengbu Shi', 'BBU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (138, '340600', '淮北市', 13, 0, 0, 'Huaibei Shi', 'HBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (142, '341100', '滁州市', 13, 0, 0, 'Chuzhou Shi', 'CUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (146, '341500', '六安市', 13, 0, 0, 'Liu,an Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (150, '350100', '福州市', 14, 0, 0, 'Fuzhou Shi', 'FOC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (153, '350400', '三明市', 14, 0, 0, 'Sanming Shi', 'SMS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (157, '350800', '龙岩市', 14, 0, 0, 'Longyan Shi', 'LYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (161, '360300', '萍乡市', 15, 0, 0, 'Pingxiang Shi', 'PXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (164, '360600', '鹰潭市', 15, 0, 0, 'Yingtan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (168, '361000', '抚州市', 15, 0, 0, 'Wuzhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (172, '370300', '淄博市', 16, 0, 0, 'Zibo Shi', 'ZBO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (176, '370700', '潍坊市', 16, 0, 0, 'Weifang Shi', 'WEF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (180, '371100', '日照市', 16, 0, 0, 'Rizhao Shi', 'RZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (183, '371400', '德州市', 16, 0, 0, 'Dezhou Shi', 'DZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (187, '410100', '郑州市', 17, 0, 0, 'Zhengzhou Shi', 'CGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (191, '410500', '安阳市', 17, 0, 0, 'Anyang Shi', 'AYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (194, '410800', '焦作市', 17, 0, 0, 'Jiaozuo Shi', 'JZY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (198, '411200', '三门峡市', 17, 0, 0, 'Sanmenxia Shi', 'SMX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (202, '411600', '周口市', 17, 0, 0, 'Zhoukou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (206, '420300', '十堰市', 18, 0, 0, 'Shiyan Shi', 'SYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (210, '420800', '荆门市', 18, 0, 0, 'Jingmen Shi', 'JMS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (213, '421100', '黄冈市', 18, 0, 0, 'Huanggang Shi', 'HE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (216, '422800', '恩施土家族苗族自治州', 18, 0, 0, 'Enshi Tujiazu Miaozu Zizhizhou', 'ESH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (221, '430400', '衡阳市', 19, 0, 0, 'Hengyang Shi', 'HNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (224, '430700', '常德市', 19, 0, 0, 'Changde Shi', 'CDE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (228, '431100', '永州市', 19, 0, 0, 'Yongzhou Shi', 'YZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (231, '433100', '湘西土家族苗族自治州', 19, 0, 0, 'Xiangxi Tujiazu Miaozu Zizhizhou ', 'XXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (240, '440900', '茂名市', 20, 0, 0, 'Maoming Shi', 'MMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (244, '441500', '汕尾市', 20, 0, 0, 'Shanwei Shi', 'SWE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (289, '511900', '巴中市', 24, 0, 0, 'Bazhong Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (420, '130108', '裕华区', 37, 0, 0, 'Yuhua Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (423, '130124', '栾城县', 37, 0, 0, 'Luancheng Xian', 'LCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (427, '130128', '深泽县', 37, 0, 0, 'Shenze Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (435, '130183', '晋州市', 37, 0, 0, 'Jinzhou Shi', 'JZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (439, '130202', '路南区', 38, 0, 0, 'Lunan Qu', 'LNB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (443, '130207', '丰南区', 38, 0, 0, 'Fengnan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (447, '130225', '乐亭县', 38, 0, 0, 'Leting Xian', 'LTJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (455, '130303', '山海关区', 39, 0, 0, 'Shanhaiguan Qu', 'SHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (464, '130404', '复兴区', 40, 0, 0, 'Fuxing Qu', 'FXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (467, '130423', '临漳县', 40, 0, 0, 'Linzhang Xian ', 'LNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (472, '130428', '肥乡县', 40, 0, 0, 'Feixiang Xian', 'FXJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (476, '130432', '广平县', 40, 0, 0, 'Guangping Xian ', 'GPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (484, '130521', '邢台县', 41, 0, 0, 'Xingtai Xian', 'XTJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (488, '130525', '隆尧县', 41, 0, 0, 'Longyao Xian', 'LYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (496, '130533', '威县', 41, 0, 0, 'Wei Xian ', 'WEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (499, '130581', '南宫市', 41, 0, 0, 'Nangong Shi', 'NGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (507, '130623', '涞水县', 42, 0, 0, 'Laishui Xian', 'LSM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (511, '130627', '唐县', 42, 0, 0, 'Tang Xian ', 'TAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (518, '130634', '曲阳县', 42, 0, 0, 'Quyang Xian ', 'QUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (523, '130681', '涿州市', 42, 0, 0, 'Zhuozhou Shi', 'ZZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (531, '130706', '下花园区', 43, 0, 0, 'Xiahuayuan Qu ', 'XHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (535, '130724', '沽源县', 43, 0, 0, 'Guyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (539, '130728', '怀安县', 43, 0, 0, 'Huai,an Xian', 'HAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (547, '130803', '双滦区', 44, 0, 0, 'Shuangluan Qu', 'SLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (549, '130821', '承德县', 44, 0, 0, 'Chengde Xian', 'CDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (553, '130825', '隆化县', 44, 0, 0, 'Longhua Xian', 'LHJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (558, '130902', '新华区', 45, 0, 0, 'Xinhua Qu', 'XHF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (563, '130924', '海兴县', 45, 0, 0, 'Haixing Xian', 'HXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (566, '130927', '南皮县', 45, 0, 0, 'Nanpi Xian', 'NPI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (741, '150205', '石拐区', 60, 0, 0, 'Shiguai Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (744, '150221', '土默特右旗', 60, 0, 0, 'Tumd Youqi', 'TUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (747, '150301', '市辖区', 61, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (750, '150304', '乌达区', 61, 0, 0, 'Ud Qu', 'UDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (753, '150403', '元宝山区', 62, 0, 0, 'Yuanbaoshan Qu', 'YBO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (764, '150501', '市辖区', 63, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (766, '150521', '科尔沁左翼中旗', 63, 0, 0, 'Horqin Zuoyi Zhongqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (771, '150526', '扎鲁特旗', 63, 0, 0, 'Jarud Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (777, '150624', '鄂托克旗', 64, 0, 0, 'Otog Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (781, '150701', '市辖区', 65, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (787, '150725', '陈巴尔虎旗', 65, 0, 0, 'Chen Barag Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (790, '150781', '满洲里市', 65, 0, 0, 'Manzhouli Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (793, '150784', '额尔古纳市', 65, 0, 0, 'Ergun Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (798, '150822', '磴口县', 66, 0, 0, 'Dengkou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (801, '150825', '乌拉特后旗', 66, 0, 0, 'Urad Houqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (805, '150921', '卓资县', 67, 0, 0, 'Zhuozi Xian', '2');
commit;
prompt 300 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (811, '150927', '察哈尔右翼中旗', 67, 0, 0, 'Qahar Youyi Zhongqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (820, '152224', '突泉县', 68, 0, 0, 'Tuquan Xian', 'TUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (826, '152525', '东乌珠穆沁旗', 69, 0, 0, 'Dong Ujimqin Qi', 'DUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (833, '152921', '阿拉善左旗', 70, 0, 0, 'Alxa Zuoqi', 'ALZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (836, '210101', '市辖区', 71, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (840, '210105', '皇姑区', 71, 0, 0, 'Huanggu Qu', 'HGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (843, '210112', '东陵区', 71, 0, 0, 'Dongling Qu ', 'DLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (850, '210201', '市辖区', 72, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (995, '220623', '长白朝鲜族自治县', 90, 0, 0, 'Changbaichaoxianzuzizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1000, '220721', '前郭尔罗斯蒙古族自治县', 91, 0, 0, 'Qian Gorlos Mongolzu Zizhixian', 'QGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1011, '222402', '图们市', 93, 0, 0, 'Tumen Shi', 'TME');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1015, '222406', '和龙市', 93, 0, 0, 'Helong Shi', 'HEL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1019, '230102', '道里区', 94, 0, 0, 'Daoli Qu', 'DLH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1026, '230111', '呼兰区', 94, 0, 0, 'Hulan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1031, '230127', '木兰县', 94, 0, 0, 'Mulan Xian ', 'MUL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1034, '230112', '阿城区', 94, 0, 0, 'Acheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1038, '230201', '市辖区', 95, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1045, '230208', '梅里斯达斡尔族区', 95, 0, 0, 'Meilisidawoerzu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1051, '230229', '克山县', 95, 0, 0, 'Keshan Xian', 'KSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1055, '230301', '市辖区', 96, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1058, '230304', '滴道区', 96, 0, 0, 'Didao Qu', 'DDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1062, '230321', '鸡东县', 96, 0, 0, 'Jidong Xian', 'JID');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1066, '230402', '向阳区', 97, 0, 0, 'Xiangyang  Qu ', 'XYZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1073, '230422', '绥滨县', 97, 0, 0, 'Suibin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1077, '230505', '四方台区', 98, 0, 0, 'Sifangtai Qu', 'SFT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1081, '230523', '宝清县', 98, 0, 0, 'Baoqing Xian', 'BQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1088, '230606', '大同区', 99, 0, 0, 'Datong Qu', 'DHD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1098, '230706', '翠峦区', 100, 0, 0, 'Cuiluan Qu', 'CLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1102, '230710', '五营区', 100, 0, 0, 'Wuying Qu', 'WYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1105, '230713', '带岭区', 100, 0, 0, 'Dailing Qu', 'DLY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1108, '230716', '上甘岭区', 100, 0, 0, 'Shangganling Qu', 'SGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1121, '230881', '同江市', 101, 0, 0, 'Tongjiang Shi', 'TOJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1125, '230903', '桃山区', 102, 0, 0, 'Taoshan Qu', 'TSC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1128, '231001', '市辖区', 103, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1132, '231005', '西安区', 103, 0, 0, 'Xi,an Qu', 'XAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1297, '321324', '泗洪县', 121, 0, 0, 'Sihong Xian', 'SIH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1301, '330104', '江干区', 122, 0, 0, 'Jianggan Qu', 'JGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1305, '330109', '萧山区', 122, 0, 0, 'Xiaoshan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1309, '330182', '建德市', 122, 0, 0, 'Jiande Shi', 'JDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1313, '330203', '海曙区', 123, 0, 0, 'Haishu Qu', 'HNB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1317, '330211', '镇海区', 123, 0, 0, 'Zhenhai Qu', 'ZHF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1321, '330281', '余姚市', 123, 0, 0, 'Yuyao Shi', 'YYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1325, '330302', '鹿城区', 124, 0, 0, 'Lucheng Qu', 'LUW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1329, '330324', '永嘉县', 124, 0, 0, 'Yongjia Xian', 'YJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1333, '330329', '泰顺县', 124, 0, 0, 'Taishun Xian', 'TSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1341, '330481', '海宁市', 125, 0, 0, 'Haining Shi', 'HNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1345, '330502', '吴兴区', 126, 0, 0, 'Wuxing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1349, '330523', '安吉县', 126, 0, 0, 'Anji Xian', 'AJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1353, '330624', '新昌县', 127, 0, 0, 'Xinchang Xian', 'XCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1357, '330701', '市辖区', 128, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1361, '330726', '浦江县', 128, 0, 0, 'Pujiang Xian ', 'PJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1365, '330783', '东阳市', 128, 0, 0, 'Dongyang Shi', 'DGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1369, '330803', '衢江区', 129, 0, 0, 'Qujiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1373, '330881', '江山市', 129, 0, 0, 'Jiangshan Shi', 'JIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1377, '330921', '岱山县', 130, 0, 0, 'Daishan Xian', 'DSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1381, '331003', '黄岩区', 131, 0, 0, 'Huangyan Qu', 'HYT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1385, '331023', '天台县', 131, 0, 0, 'Tiantai Xian', 'TTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1389, '331101', '市辖区', 132, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1393, '331123', '遂昌县', 132, 0, 0, 'Suichang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1397, '331127', '景宁畲族自治县', 132, 0, 0, 'Jingning Shezu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1403, '340111', '包河区', 133, 0, 0, 'Baohe Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1407, '340201', '市辖区', 1412, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1411, '340207', '鸠江区', 1412, 0, 0, 'Jiujiang Qu', 'JJW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1581, '350626', '东山县', 155, 0, 0, 'Dongshan Xian', 'DSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1585, '350681', '龙海市', 155, 0, 0, 'Longhai Shi', 'LHM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1589, '350722', '浦城县', 156, 0, 0, 'Pucheng Xian', 'PCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1593, '350781', '邵武市', 156, 0, 0, 'Shaowu Shi', 'SWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1597, '350801', '市辖区', 157, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1601, '350823', '上杭县', 157, 0, 0, 'Shanghang Xian', 'SHF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1605, '350901', '市辖区', 158, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1609, '350923', '屏南县', 158, 0, 0, 'Pingnan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1613, '350981', '福安市', 158, 0, 0, 'Fu,an Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1617, '360103', '西湖区', 159, 0, 0, 'Xihu Qu ', 'XHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1620, '360111', '青山湖区', 159, 0, 0, 'Qingshanhu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1625, '360201', '市辖区', 160, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1629, '360281', '乐平市', 160, 0, 0, 'Leping Shi', 'LEP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1633, '360321', '莲花县', 161, 0, 0, 'Lianhua Xian', 'LHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1637, '360402', '庐山区', 162, 0, 0, 'Lushan Qu', 'LSV');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1641, '360424', '修水县', 162, 0, 0, 'Xiushui Xian', 'XSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1645, '360428', '都昌县', 162, 0, 0, 'Duchang Xian', 'DUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1649, '360501', '市辖区', 163, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1653, '360602', '月湖区', 164, 0, 0, 'Yuehu Qu', 'YHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1657, '360702', '章贡区', 165, 0, 0, 'Zhanggong Qu', 'ZGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1661, '360724', '上犹县', 165, 0, 0, 'Shangyou Xian', 'SYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1665, '360728', '定南县', 165, 0, 0, 'Dingnan Xian', 'DNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1669, '360732', '兴国县', 165, 0, 0, 'Xingguo Xian', 'XGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1673, '360781', '瑞金市', 165, 0, 0, 'Ruijin Shi', 'RJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1677, '360803', '青原区', 166, 0, 0, 'Qingyuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1681, '360824', '新干县', 166, 0, 0, 'Xingan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1685, '360828', '万安县', 166, 0, 0, 'Wan,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1689, '360901', '市辖区', 167, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1693, '360923', '上高县', 167, 0, 0, 'Shanggao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1857, '371521', '阳谷县', 184, 0, 0, 'Yanggu Xian ', 'YGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1862, '371526', '高唐县', 184, 0, 0, 'Gaotang Xian', 'GTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1866, '371621', '惠民县', 185, 0, 0, 'Huimin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1870, '371625', '博兴县', 185, 0, 0, 'Boxing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1875, '371722', '单县', 186, 0, 0, 'Shan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1878, '371725', '郓城县', 186, 0, 0, 'Yuncheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1882, '410101', '市辖区', 187, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1885, '410104', '管城回族区', 187, 0, 0, 'Guancheng Huizu Qu', 'GCH');
commit;
prompt 400 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1891, '410182', '荥阳市', 187, 0, 0, 'Xingyang Shi', 'XYK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1895, '410201', '市辖区', 188, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1903, '410223', '尉氏县', 188, 0, 0, 'Weishi Xian', 'WSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1907, '410302', '老城区', 189, 0, 0, 'Laocheng Qu', 'LLY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1910, '410305', '涧西区', 189, 0, 0, 'Jianxi Qu', 'JXL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1914, '410323', '新安县', 189, 0, 0, 'Xin,an Xian', 'XAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1919, '410328', '洛宁县', 189, 0, 0, 'Luoning Xian', 'LNI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1923, '410402', '新华区', 190, 0, 0, 'Xinhua Qu', 'XHP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1927, '410421', '宝丰县', 190, 0, 0, 'Baofeng Xian', 'BFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1931, '410481', '舞钢市', 190, 0, 0, 'Wugang Shi', 'WGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1935, '410503', '北关区', 191, 0, 0, 'Beiguan Qu', 'BGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1939, '410523', '汤阴县', 191, 0, 0, 'Tangyin Xian', 'TYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1944, '410602', '鹤山区', 192, 0, 0, 'Heshan Qu', 'HSF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1949, '410701', '市辖区', 193, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1953, '410711', '牧野区', 193, 0, 0, 'Muye Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1957, '410726', '延津县', 193, 0, 0, 'Yanjin Xian', 'YJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1961, '410782', '辉县市', 193, 0, 0, 'Huixian Shi', 'HXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1965, '410804', '马村区', 194, 0, 0, 'Macun Qu', 'MCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1969, '410823', '武陟县', 194, 0, 0, 'Wuzhi Xian', 'WZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1973, '410883', '孟州市', 194, 0, 0, 'Mengzhou Shi', 'MZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2136, '421081', '石首市', 212, 0, 0, 'Shishou Shi', 'SSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2140, '421102', '黄州区', 213, 0, 0, 'Huangzhou Qu', 'HZC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2144, '421124', '英山县', 213, 0, 0, 'Yingshan Xian', 'YSE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2148, '421181', '麻城市', 213, 0, 0, 'Macheng Shi', 'MCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2152, '421221', '嘉鱼县', 214, 0, 0, 'Jiayu Xian', 'JYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2156, '421281', '赤壁市', 214, 0, 0, 'Chibi Shi', 'CBI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2160, '422801', '恩施市', 216, 0, 0, 'Enshi Shi', 'ESS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2164, '422825', '宣恩县', 216, 0, 0, 'Xuan,en Xian', 'XEN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2168, '429004', '仙桃市', 217, 0, 0, 'Xiantao Shi', 'XNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2171, '429021', '神农架林区', 217, 0, 0, 'Shennongjia Linqu', 'SNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2177, '430111', '雨花区', 218, 0, 0, 'Yuhua Qu', 'YHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2181, '430181', '浏阳市', 218, 0, 0, 'Liuyang Shi', 'LYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2185, '430204', '石峰区', 219, 0, 0, 'Shifeng Qu', 'SFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2189, '430224', '茶陵县', 219, 0, 0, 'Chaling Xian', 'CAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2193, '430302', '雨湖区', 220, 0, 0, 'Yuhu Qu', 'YHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2197, '430382', '韶山市', 220, 0, 0, 'Shaoshan Shi', 'SSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2201, '430407', '石鼓区', 221, 0, 0, 'Shigu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2205, '430422', '衡南县', 221, 0, 0, 'Hengnan Xian', 'HNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2213, '430503', '大祥区', 222, 0, 0, 'Daxiang Qu', 'DXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2217, '430523', '邵阳县', 222, 0, 0, 'Shaoyang Xian', 'SYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2221, '430528', '新宁县', 222, 0, 0, 'Xinning Xian', 'XNI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2227, '430611', '君山区', 223, 0, 0, 'Junshan Qu', 'JUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2231, '430626', '平江县', 223, 0, 0, 'Pingjiang Xian', 'PJH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2239, '430723', '澧县', 224, 0, 0, 'Li Xian', 'LXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2243, '430781', '津市市', 224, 0, 0, 'Jinshi Shi', 'JSS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2251, '430903', '赫山区', 226, 0, 0, 'Heshan Qu', 'HSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2405, '441501', '市辖区', 244, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2409, '441581', '陆丰市', 244, 0, 0, 'Lufeng Shi', 'LUF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2413, '441622', '龙川县', 245, 0, 0, 'Longchuan Xian', 'LCY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2417, '441701', '市辖区', 246, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2425, '441823', '阳山县', 247, 0, 0, 'Yangshan Xian', 'YSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2427, '441826', '连南瑶族自治县', 247, 0, 0, 'Liannanyaozuzizhi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2433, '445121', '潮安县', 250, 0, 0, 'Chao,an Xian', 'CAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2441, '445301', '市辖区', 252, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2445, '445323', '云安县', 252, 0, 0, 'Yun,an Xian', 'YUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2449, '450103', '青秀区', 253, 0, 0, 'Qingxiu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2452, '450108', '良庆区', 253, 0, 0, 'Liangqing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2456, '450124', '马山县', 253, 0, 0, 'Mashan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2461, '450202', '城中区', 254, 0, 0, 'Chengzhong Qu', 'CZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2465, '450221', '柳江县', 254, 0, 0, 'Liujiang Xian', 'LUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2473, '450303', '叠彩区', 255, 0, 0, 'Diecai Qu', 'DCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2477, '450321', '阳朔县', 255, 0, 0, 'Yangshuo Xian', 'YSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2481, '450325', '兴安县', 255, 0, 0, 'Xing,an Xian', 'XAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2489, '450401', '市辖区', 256, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2493, '450421', '苍梧县', 256, 0, 0, 'Cangwu Xian', 'CAW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2497, '450501', '市辖区', 257, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2501, '450521', '合浦县', 257, 0, 0, 'Hepu Xian', 'HPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2505, '450621', '上思县', 258, 0, 0, 'Shangsi Xian', 'SGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2513, '450802', '港北区', 260, 0, 0, 'Gangbei Qu', 'GBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2517, '450881', '桂平市', 260, 0, 0, 'Guiping Shi', 'GPS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2525, '451001', '市辖区', 262, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2648, '510129', '大邑县', 273, 0, 0, 'Dayi Xian', 'DYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2651, '510181', '都江堰市', 273, 0, 0, 'Dujiangyan Shi', 'DJY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2656, '510302', '自流井区', 274, 0, 0, 'Ziliujing Qu', 'ZLJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2666, '510421', '米易县', 275, 0, 0, 'Miyi Xian', 'MIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2670, '510503', '纳溪区', 276, 0, 0, 'Naxi Qu', 'NXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2674, '510524', '叙永县', 276, 0, 0, 'Xuyong Xian', 'XYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2682, '510683', '绵竹市', 277, 0, 0, 'Jinzhou Shi', 'MZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2686, '510722', '三台县', 278, 0, 0, 'Santai Xian', 'SNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2690, '510726', '北川羌族自治县', 278, 0, 0, 'Beichuanqiangzuzizhi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2700, '510824', '苍溪县', 279, 0, 0, 'Cangxi Xian', 'CXC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2704, '510921', '蓬溪县', 280, 0, 0, 'Pengxi Xian', 'PXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2708, '511002', '市中区', 281, 0, 0, 'Shizhong Qu', 'SZM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2716, '511112', '五通桥区', 282, 0, 0, 'Wutongqiao Qu', 'WTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2720, '511126', '夹江县', 282, 0, 0, 'Jiajiang Xian', 'JJC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2727, '511303', '高坪区', 283, 0, 0, 'Gaoping Qu', 'GPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2731, '511323', '蓬安县', 283, 0, 0, 'Peng,an Xian', 'PGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2735, '511401', '市辖区', 284, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2739, '511423', '洪雅县', 284, 0, 0, 'Hongya Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2743, '511502', '翠屏区', 285, 0, 0, 'Cuiping Qu', 'CPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2752, '511529', '屏山县', 285, 0, 0, 'Pingshan Xian', 'PSC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2756, '511622', '武胜县', 286, 0, 0, 'Wusheng Xian', 'WSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2760, '511702', '通川区', 287, 0, 0, 'Tongchuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2769, '511821', '名山县', 288, 0, 0, 'Mingshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2773, '511825', '天全县', 288, 0, 0, 'Tianquan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2777, '511902', '巴州区', 289, 0, 0, 'Bazhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2781, '512001', '市辖区', 290, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2790, '513225', '九寨沟县', 291, 0, 0, 'Jiuzhaigou Xian', 'JZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2794, '513229', '马尔康县', 291, 0, 0, 'Barkam Xian', 'BAK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2935, '530126', '石林彝族自治县', 303, 0, 0, 'Shilin Yizu Zizhixian', 'SLY');
commit;
prompt 500 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2947, '530326', '会泽县', 304, 0, 0, 'Huize Xian', 'HUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2951, '530402', '红塔区', 305, 0, 0, 'Hongta Qu', 'HTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2955, '530424', '华宁县', 305, 0, 0, 'Huaning Xian', 'HND');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2959, '530428', '元江哈尼族彝族傣族自治县', 305, 0, 0, 'Yuanjiang Hanizu Yizu Daizu Zizhixian', 'YJA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2969, '530622', '巧家县', 307, 0, 0, 'Qiaojia Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2977, '530630', '水富县', 307, 0, 0, 'Shuifu Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2980, '530721', '玉龙纳西族自治县', 308, 0, 0, 'Yulongnaxizuzizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (514, '130630', '涞源县', 42, 0, 0, 'Laiyuan Xian ', 'LIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2989, '530824', '景谷傣族彝族自治县', 309, 0, 0, 'Jinggu Daizu Yizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2991, '530826', '江城哈尼族彝族自治县', 309, 0, 0, 'Jiangcheng Hanizu Yizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2993, '530828', '澜沧拉祜族自治县', 309, 0, 0, 'Lancang Lahuzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2999, '530923', '永德县', 310, 0, 0, 'Yongde Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3001, '530925', '双江拉祜族佤族布朗族傣族自治县', 310, 0, 0, 'Shuangjiang Lahuzu Vazu Bulangzu Daizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3008, '532325', '姚安县', 311, 0, 0, 'Yao,an Xian', 'YOA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3012, '532329', '武定县', 311, 0, 0, 'Wuding Xian', 'WDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3016, '532503', '蒙自市', 312, 0, 0, 'Mengzi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3019, '532525', '石屏县', 312, 0, 0, 'Shiping Xian', 'SPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3023, '532529', '红河县', 312, 0, 0, 'Honghe Xian', 'HHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3024, '532530', '金平苗族瑶族傣族自治县', 312, 0, 0, 'Jinping Miaozu Yaozu Daizu Zizhixian', 'JNP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3033, '532627', '广南县', 313, 0, 0, 'Guangnan Xian', 'GGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3037, '532823', '勐腊县', 314, 0, 0, 'Mengla Xian', 'MLA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3039, '532922', '漾濞彝族自治县', 315, 0, 0, 'Yangbi Yizu Zizhixian', 'YGB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3044, '532927', '巍山彝族回族自治县', 315, 0, 0, 'Weishan Yizu Huizu Zizhixian', 'WSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3050, '533102', '瑞丽市', 316, 0, 0, 'Ruili Shi', 'RUI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3054, '533124', '陇川县', 316, 0, 0, 'Longchuan Xian', 'LCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3057, '533324', '贡山独龙族怒族自治县', 317, 0, 0, 'Gongshan Dulongzu Nuzu Zizhixian', 'GSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3222, '610802', '榆阳区', 333, 0, 0, 'Yuyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3226, '610824', '靖边县', 333, 0, 0, 'Jingbian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3230, '610828', '佳县', 333, 0, 0, 'Jia Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3234, '610901', '市辖区', 334, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3238, '610923', '宁陕县', 334, 0, 0, 'Ningshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3242, '610927', '镇坪县', 334, 0, 0, 'Zhenping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3246, '611002', '商州区', 335, 0, 0, 'Shangzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3250, '611024', '山阳县', 335, 0, 0, 'Shanyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3254, '620102', '城关区', 336, 0, 0, 'Chengguan Qu', 'CLZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3257, '620105', '安宁区', 336, 0, 0, 'Anning Qu', 'ANQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3261, '620123', '榆中县', 336, 0, 0, 'Yuzhong Xian', 'YZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3265, '620321', '永昌县', 338, 0, 0, 'Yongchang Xian', 'YCF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3269, '620421', '靖远县', 339, 0, 0, 'Jingyuan Xian', 'JYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3277, '620523', '甘谷县', 340, 0, 0, 'Gangu Xian', 'GGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3279, '620525', '张家川回族自治县', 340, 0, 0, 'Zhangjiachuan Huizu Zizhixian', 'ZJC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3286, '620702', '甘州区', 342, 0, 0, 'Ganzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3288, '620722', '民乐县', 342, 0, 0, 'Minle Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3292, '620801', '市辖区', 343, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3296, '620823', '崇信县', 343, 0, 0, 'Chongxin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3300, '620901', '市辖区', 344, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3305, '620924', '阿克塞哈萨克族自治县', 344, 0, 0, 'Aksay Kazakzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3313, '621024', '合水县', 345, 0, 0, 'Heshui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3317, '621101', '市辖区', 346, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3321, '621123', '渭源县', 346, 0, 0, 'Weiyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3326, '621202', '武都区', 347, 0, 0, 'Wudu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3331, '621225', '西和县', 347, 0, 0, 'Xihe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3472, '653023', '阿合奇县', 371, 0, 0, 'Akqi Xian', 'AKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3476, '653122', '疏勒县', 372, 0, 0, 'Shule Xian', 'SHL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3480, '653126', '叶城县', 372, 0, 0, 'Yecheng(Kargilik) Xian', 'YEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3483, '653129', '伽师县', 372, 0, 0, 'Jiashi(Payzawat) Xian', 'JSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3485, '653131', '塔什库尔干塔吉克自治县', 372, 0, 0, 'Taxkorgan Tajik Zizhixian', 'TXK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3494, '654002', '伊宁市', 374, 0, 0, 'Yining(Gulja) Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3497, '654022', '察布查尔锡伯自治县', 374, 0, 0, 'Qapqal Xibe Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3504, '654201', '塔城市', 375, 0, 0, 'Tacheng(Qoqek) Shi', 'TCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3508, '654224', '托里县', 375, 0, 0, 'Toli Xian', 'TLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3510, '654226', '和布克赛尔蒙古自治县', 375, 0, 0, 'Hebukesaiermengguzizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3517, '654326', '吉木乃县', 376, 0, 0, 'Jeminay Xian', 'JEM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3520, '659003', '图木舒克市', 377, 0, 0, 'Tumushuke Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (7, '210000', '辽宁省', 1, 0, 0, 'Liaoning Sheng', 'LN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (11, '320000', '江苏省', 1, 0, 0, 'Jiangsu Sheng', 'JS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (15, '360000', '江西省', 1, 0, 0, 'Jiangxi Sheng', 'JX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (19, '430000', '湖南省', 1, 0, 0, 'Hunan Sheng', 'HN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (25, '520000', '贵州省', 1, 0, 0, 'Guizhou Sheng', 'GZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (30, '630000', '青海省', 1, 0, 0, 'Qinghai Sheng', 'QH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (23, '500000', '重庆市', 1, 0, 0, 'Chongqing Shi', 'CQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (526, '130684', '高碑店市', 42, 0, 0, 'Gaobeidian Shi', 'GBD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (543, '130732', '赤城县', 43, 0, 0, 'Chicheng Xian', 'CCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (555, '130827', '宽城满族自治县', 44, 0, 0, 'Kuancheng Manzu Zizhixian', 'KCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (569, '130930', '孟村回族自治县', 45, 0, 0, 'Mengcun Huizu Zizhixian', 'MCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (760, '150426', '翁牛特旗', 62, 0, 0, 'Ongniud Qi', 'ONG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (774, '150621', '达拉特旗', 64, 0, 0, 'Dalad Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (784, '150722', '莫力达瓦达斡尔族自治旗', 65, 0, 0, 'Morin Dawa Daurzu Zizhiqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (809, '150925', '凉城县', 67, 0, 0, 'Liangcheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (814, '150981', '丰镇市', 67, 0, 0, 'Fengzhen Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (822, '152502', '锡林浩特市', 69, 0, 0, 'Xilinhot Shi', 'XLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (829, '152528', '镶黄旗', 69, 0, 0, 'Xianghuang(Hobot Xar) Qi', 'XHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (847, '210123', '康平县', 71, 0, 0, 'Kangping Xian', 'KPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1007, '220822', '通榆县', 92, 0, 0, 'Tongyu Xian', 'TGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1042, '230205', '昂昂溪区', 95, 0, 0, 'Ang,angxi Qu', 'AAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1069, '230405', '兴安区', 97, 0, 0, 'Xing,an Qu', 'XAH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1085, '230603', '龙凤区', 99, 0, 0, 'Longfeng Qu', 'LFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1092, '230624', '杜尔伯特蒙古族自治县', 99, 0, 0, 'Dorbod Mongolzu Zizhixian', 'DOM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1117, '230822', '桦南县', 101, 0, 0, 'Huanan Xian', 'HNH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2209, '430481', '耒阳市', 221, 0, 0, 'Leiyang Shi', 'LEY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2223, '430581', '武冈市', 222, 0, 0, 'Wugang Shi', 'WGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2235, '430702', '武陵区', 224, 0, 0, 'Wuling Qu', 'WLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2246, '430811', '武陵源区', 225, 0, 0, 'Wulingyuan Qu', 'WLY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2421, '441781', '阳春市', 246, 0, 0, 'Yangchun Shi', 'YCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2437, '445221', '揭东县', 251, 0, 0, 'Jiedong Xian', 'JDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2469, '450225', '融水苗族自治县', 254, 0, 0, 'Rongshui Miaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2484, '450328', '龙胜各族自治县', 255, 0, 0, 'Longsheng Gezu Zizhixian', 'LSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2509, '450703', '钦北区', 259, 0, 0, 'Qinbei Qu', 'QBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2521, '450922', '陆川县', 261, 0, 0, 'Luchuan Xian', 'LCJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2661, '510322', '富顺县', 274, 0, 0, 'Fushun Xian', 'FSH');
commit;
prompt 600 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2678, '510623', '中江县', 277, 0, 0, 'Zhongjiang Xian', 'ZGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2696, '510812', '朝天区', 279, 0, 0, 'Chaotian Qu', 'CTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2712, '511028', '隆昌县', 281, 0, 0, 'Longchang Xian', 'LCC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2722, '511132', '峨边彝族自治县', 282, 0, 0, 'Ebian Yizu Zizhixian', 'EBN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2747, '511524', '长宁县', 285, 0, 0, 'Changning Xian', 'CNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2764, '511724', '大竹县', 287, 0, 0, 'Dazhu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2785, '512081', '简阳市', 290, 0, 0, 'Jianyang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2933, '530124', '富民县', 303, 0, 0, 'Fumin Xian', 'FMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2938, '530129', '寻甸回族彝族自治县', 303, 0, 0, 'Xundian Huizu Yizu Zizhixian', 'XDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2957, '530426', '峨山彝族自治县', 305, 0, 0, 'Eshan Yizu Zizhixian', 'ESN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2973, '530626', '绥江县', 307, 0, 0, 'Suijiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2986, '530821', '宁洱哈尼族彝族自治县', 309, 0, 0, 'Pu,er Hanizu Yizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1757, '370323', '沂源县', 172, 0, 0, 'Yiyuan Xian', 'YIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1762, '370405', '台儿庄区', 173, 0, 0, 'Tai,erzhuang Qu', 'TEZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1767, '370503', '河口区', 174, 0, 0, 'Hekou Qu', 'HKO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1770, '370523', '广饶县', 174, 0, 0, 'Guangrao Xian ', 'GRO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1776, '370634', '长岛县', 175, 0, 0, 'Changdao Xian', 'CDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1779, '370683', '莱州市', 175, 0, 0, 'Laizhou Shi', 'LZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1782, '370686', '栖霞市', 175, 0, 0, 'Qixia Shi', 'QXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (186, '371700', '菏泽市', 16, 3, 0, 'Heze Shi', 'HZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1787, '370704', '坊子区', 176, 0, 0, 'Fangzi Qu', 'FZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2645, '510121', '金堂县', 273, 0, 0, 'Jintang Xian', 'JNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2650, '510132', '新津县', 273, 0, 0, 'Xinjin Xian', 'XJC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2654, '510184', '崇州市', 273, 0, 0, 'Chongzhou Shi', 'CZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2663, '510402', '东区', 275, 0, 0, 'Dong Qu', 'DQP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2669, '510502', '江阳区', 276, 0, 0, 'Jiangyang Qu', 'JYB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2675, '510525', '古蔺县', 276, 0, 0, 'Gulin Xian', 'GUL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2680, '510681', '广汉市', 277, 0, 0, 'Guanghan Shi', 'GHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2685, '510704', '游仙区', 278, 0, 0, 'Youxian Qu', 'YXM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2691, '510727', '平武县', 278, 0, 0, 'Pingwu Xian', 'PWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2697, '510821', '旺苍县', 279, 0, 0, 'Wangcang Xian', 'WGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2705, '510922', '射洪县', 280, 0, 0, 'Shehong Xian', 'SHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2711, '511025', '资中县', 281, 0, 0, 'Zizhong Xian', 'ZZC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2718, '511123', '犍为县', 282, 0, 0, 'Qianwei Xian', 'QWE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2723, '511133', '马边彝族自治县', 282, 0, 0, 'Mabian Yizu Zizhixian', 'MBN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2730, '511322', '营山县', 283, 0, 0, 'Yingshan Xian', 'YGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2734, '511381', '阆中市', 283, 0, 0, 'Langzhong Shi', 'LZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2740, '511424', '丹棱县', 284, 0, 0, 'Danling Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2746, '511523', '江安县', 285, 0, 0, 'Jiang,an Xian', 'JAC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2750, '511527', '筠连县', 285, 0, 0, 'Junlian Xian', 'JNL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2757, '511623', '邻水县', 286, 0, 0, 'Linshui Xian', 'LSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2763, '511723', '开江县', 287, 0, 0, 'Kaijiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2771, '511823', '汉源县', 288, 0, 0, 'Hanyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2775, '511827', '宝兴县', 288, 0, 0, 'Baoxing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2780, '511923', '平昌县', 289, 0, 0, 'Pingchang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2787, '513222', '理县', 291, 0, 0, 'Li Xian', 'LXC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2791, '513226', '金川县', 291, 0, 0, 'Jinchuan Xian', 'JCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2795, '513230', '壤塘县', 291, 0, 0, 'Zamtang Xian', 'ZAM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2798, '513233', '红原县', 291, 0, 0, 'Hongyuan Xian', 'HOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2800, '513322', '泸定县', 292, 0, 0, 'Luding(Jagsamka) Xian', 'LUD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2802, '513324', '九龙县', 292, 0, 0, 'Jiulong(Gyaisi) Xian', 'JLC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2879, '522229', '松桃苗族自治县', 298, 0, 0, 'Songtao Miaozu Zizhixian', 'STM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2883, '522323', '普安县', 299, 0, 0, 'Pu,an Xian', 'PUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2886, '522326', '望谟县', 299, 0, 0, 'Wangmo Xian', 'WMO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2889, '522401', '毕节市', 300, 0, 0, 'Bijie Shi', 'BJE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2892, '522424', '金沙县', 300, 0, 0, 'Jinsha Xian', 'JSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2895, '522427', '威宁彝族回族苗族自治县', 300, 0, 0, 'Weining Yizu Huizu Miaozu Zizhixian', 'WNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2900, '522624', '三穗县', 301, 0, 0, 'Sansui Xian', 'SAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2903, '522627', '天柱县', 301, 0, 0, 'Tianzhu Xian', 'TZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2906, '522630', '台江县', 301, 0, 0, 'Taijiang Xian', 'TJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2909, '522633', '从江县', 301, 0, 0, 'Congjiang Xian', 'COJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2913, '522701', '都匀市', 302, 0, 0, 'Duyun Shi', 'DUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2916, '522723', '贵定县', 302, 0, 0, 'Guiding Xian', 'GDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2920, '522728', '罗甸县', 302, 0, 0, 'Luodian Xian', 'LOD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2923, '522731', '惠水县', 302, 0, 0, 'Huishui Xian', 'HUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2926, '530102', '五华区', 303, 0, 0, 'Wuhua Qu', 'WHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2930, '530113', '东川区', 303, 0, 0, 'Dongchuan Qu', 'DCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2934, '530125', '宜良县', 303, 0, 0, 'Yiliang Xian', 'YIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2937, '530128', '禄劝彝族苗族自治县', 303, 0, 0, 'Luchuan Yizu Miaozu Zizhixian', 'LUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2945, '530324', '罗平县', 304, 0, 0, 'Luoping Xian', 'LPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2949, '530381', '宣威市', 304, 0, 0, 'Xuanwei Shi', 'XWS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2954, '530423', '通海县', 305, 0, 0, 'Tonghai Xian', 'THI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2958, '530427', '新平彝族傣族自治县', 305, 0, 0, 'Xinping Yizu Daizu Zizhixian', 'XNP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2968, '530621', '鲁甸县', 307, 0, 0, 'Ludian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2972, '530625', '永善县', 307, 0, 0, 'Yongshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2976, '530629', '威信县', 307, 0, 0, 'Weixin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2983, '530724', '宁蒗彝族自治县', 308, 0, 0, 'Ninglang Yizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2988, '530823', '景东彝族自治县', 309, 0, 0, 'Jingdong Yizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2992, '530827', '孟连傣族拉祜族佤族自治县', 309, 0, 0, 'Menglian Daizu Lahuzu Vazu Zizixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3002, '530926', '耿马傣族佤族自治县', 310, 0, 0, 'Gengma Daizu Vazu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3005, '532322', '双柏县', 311, 0, 0, 'Shuangbai Xian', 'SBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3010, '532327', '永仁县', 311, 0, 0, 'Yongren Xian', 'YRN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3014, '532501', '个旧市', 312, 0, 0, 'Gejiu Shi', 'GJU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3017, '532523', '屏边苗族自治县', 312, 0, 0, 'Pingbian Miaozu Zizhixian', 'PBN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3103, '542330', '仁布县', 322, 0, 0, 'Rinbung Xian', 'RIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3106, '542333', '仲巴县', 322, 0, 0, 'Zhongba Xian', 'ZHB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3108, '542335', '吉隆县', 322, 0, 0, 'Gyirong Xian', 'GIR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3112, '542421', '那曲县', 323, 0, 0, 'Nagqu Xian', 'NAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3116, '542425', '安多县', 323, 0, 0, 'Amdo Xian', 'AMD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3119, '542428', '班戈县', 323, 0, 0, 'Bangoin Xian', 'BGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3123, '542522', '札达县', 324, 0, 0, 'Zanda Xian', 'ZAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3127, '542526', '改则县', 324, 0, 0, 'Gerze Xian', 'GER');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3130, '542622', '工布江达县', 325, 0, 0, 'Gongbo,gyamda Xian', 'GOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3133, '542625', '波密县', 325, 0, 0, 'Bomi(Bowo) Xian', 'BMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3140, '610111', '灞桥区', 326, 0, 0, 'Baqiao Qu', 'BQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3144, '610115', '临潼区', 326, 0, 0, 'Lintong Qu', 'LTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3148, '610125', '户县', 326, 0, 0, 'Hu Xian', 'HUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3156, '610302', '渭滨区', 328, 0, 0, 'Weibin Qu', 'WBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3160, '610323', '岐山县', 328, 0, 0, 'Qishan Xian', 'QIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3164, '610328', '千阳县', 328, 0, 0, 'Qianyang Xian', 'QNY');
commit;
prompt 700 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3169, '610402', '秦都区', 329, 0, 0, 'Qindu Qu', 'QDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3173, '610423', '泾阳县', 329, 0, 0, 'Jingyang Xian', 'JGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3176, '610426', '永寿县', 329, 0, 0, 'Yongshou Xian', 'YSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3180, '610430', '淳化县', 329, 0, 0, 'Chunhua Xian', 'CHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3185, '610521', '华县', 330, 0, 0, 'Hua Xian', 'HXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3188, '610524', '合阳县', 330, 0, 0, 'Heyang Xian', 'HYK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3191, '610527', '白水县', 330, 0, 0, 'Baishui Xian', 'BSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3194, '610582', '华阴市', 330, 0, 0, 'Huayin Shi', 'HYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3199, '610623', '子长县', 331, 0, 0, 'Zichang Xian', 'ZCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3202, '610626', '吴起县', 331, 0, 0, 'Wuqi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3206, '610630', '宜川县', 331, 0, 0, 'Yichuan Xian', 'YIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3208, '610632', '黄陵县', 331, 0, 0, 'Huangling Xian', 'HLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1790, '370725', '昌乐县', 176, 0, 0, 'Changle Xian', 'CLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1793, '370783', '寿光市', 176, 0, 0, 'Shouguang Shi', 'SGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1799, '370811', '任城区', 177, 0, 0, 'Rencheng Qu', 'RCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1803, '370829', '嘉祥县', 177, 0, 0, 'Jiaxiang Xian', 'JXP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1806, '370832', '梁山县', 177, 0, 0, 'Liangshan Xian', 'LSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1809, '370883', '邹城市', 177, 0, 0, 'Zoucheng Shi', 'ZCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1815, '370982', '新泰市', 178, 0, 0, 'Xintai Shi', 'XTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1819, '371081', '文登市', 179, 0, 0, 'Wendeng Shi', 'WDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1826, '371122', '莒县', 180, 0, 0, 'Ju Xian', 'JUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1831, '371302', '兰山区', 182, 0, 0, 'Lanshan Qu', 'LLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1835, '371322', '郯城县', 182, 0, 0, 'Tancheng Xian', 'TCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1839, '371326', '平邑县', 182, 0, 0, 'Pingyi Xian', 'PYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1842, '371329', '临沭县', 182, 0, 0, 'Linshu Xian', 'LSP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1847, '371423', '庆云县', 183, 0, 0, 'Qingyun Xian', 'QYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1850, '371426', '平原县', 183, 0, 0, 'Pingyuan Xian', 'PYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1854, '371482', '禹城市', 183, 0, 0, 'Yucheng Shi', 'YCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1859, '371523', '茌平县', 184, 0, 0, 'Chiping Xian ', 'CPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1863, '371581', '临清市', 184, 0, 0, 'Linqing Xian', 'LQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2007, '411324', '镇平县', 199, 0, 0, 'Zhenping Xian', 'ZPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2010, '411327', '社旗县', 199, 0, 0, 'Sheqi Xian', 'SEQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2013, '411330', '桐柏县', 199, 0, 0, 'Tongbai Xian', 'TBX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2018, '411421', '民权县', 200, 0, 0, 'Minquan Xian', 'MQY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2021, '411424', '柘城县', 200, 0, 0, 'Zhecheng Xian', 'ZHC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2024, '411481', '永城市', 200, 0, 0, 'Yongcheng Shi', 'YOC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2029, '411522', '光山县', 201, 0, 0, 'Guangshan Xian', 'GSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2033, '411526', '潢川县', 201, 0, 0, 'Huangchuan Xian', 'HCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2039, '411622', '西华县', 202, 0, 0, 'Xihua Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2042, '411625', '郸城县', 202, 0, 0, 'Dancheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2045, '411628', '鹿邑县', 202, 0, 0, 'Luyi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2050, '411722', '上蔡县', 203, 0, 0, 'Shangcai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2054, '411726', '泌阳县', 203, 0, 0, 'Biyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2059, '420102', '江岸区', 204, 0, 0, 'Jiang,an Qu', 'JAA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2063, '420106', '武昌区', 204, 0, 0, 'Wuchang Qu', 'WCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2068, '420114', '蔡甸区', 204, 0, 0, 'Caidian Qu', 'CDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2071, '420117', '新洲区', 204, 0, 0, 'Xinzhou Qu', 'XNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2077, '420222', '阳新县', 205, 0, 0, 'Yangxin Xian', 'YXE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2081, '420303', '张湾区', 206, 0, 0, 'Zhangwan Qu', 'ZWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2085, '420324', '竹溪县', 206, 0, 0, 'Zhuxi Xian', 'ZXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2089, '420502', '西陵区', 207, 0, 0, 'Xiling Qu', 'XLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2094, '420525', '远安县', 207, 0, 0, 'Yuan,an Xian', 'YAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2097, '420528', '长阳土家族自治县', 207, 0, 0, 'Changyang Tujiazu Zizhixian', 'CYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2100, '420582', '当阳市', 207, 0, 0, 'Dangyang Shi', 'DYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2232, '430681', '汨罗市', 223, 0, 0, 'Miluo Shi', 'MLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2237, '430721', '安乡县', 224, 0, 0, 'Anxiang Xian', 'AXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2242, '430726', '石门县', 224, 0, 0, 'Shimen Xian', 'SHM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2248, '430822', '桑植县', 225, 0, 0, 'Sangzhi Xian', 'SZT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2254, '430923', '安化县', 226, 0, 0, 'Anhua Xian', 'ANH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2259, '431021', '桂阳县', 227, 0, 0, 'Guiyang Xian', 'GYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2262, '431024', '嘉禾县', 227, 0, 0, 'Jiahe Xian', 'JAH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2265, '431027', '桂东县', 227, 0, 0, 'Guidong Xian', 'GDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2270, '431103', '冷水滩区', 228, 0, 0, 'Lengshuitan Qu', 'LST');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2273, '431123', '双牌县', 228, 0, 0, 'Shuangpai Xian', 'SPA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2277, '431127', '蓝山县', 228, 0, 0, 'Lanshan Xian', 'LNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2279, '431129', '江华瑶族自治县', 228, 0, 0, 'Jianghua Yaozu Zizhixian', 'JHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2285, '431224', '溆浦县', 229, 0, 0, 'Xupu Xian', 'XUP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2287, '431226', '麻阳苗族自治县', 229, 0, 0, 'Mayang Miaozu Zizhixian', 'MYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2289, '431228', '芷江侗族自治县', 229, 0, 0, 'Zhijiang Dongzu Zizhixian', 'ZJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2292, '431281', '洪江市', 229, 0, 0, 'Hongjiang Shi', 'HGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2297, '431381', '冷水江市', 230, 0, 0, 'Lengshuijiang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2300, '433122', '泸溪县', 231, 0, 0, 'Luxi Xian', 'LXW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2303, '433125', '保靖县', 231, 0, 0, 'Baojing Xian', 'BJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2306, '433130', '龙山县', 231, 0, 0, 'Longshan Xian', 'LSR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2312, '440106', '天河区', 232, 0, 0, 'Tianhe Qu', 'THQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2317, '440114', '花都区', 232, 0, 0, 'Huadu Qu', 'HDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2321, '440203', '武江区', 233, 0, 0, 'Wujiang Qu', 'WJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2326, '440229', '翁源县', 233, 0, 0, 'Wengyuan Xian', 'WYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2328, '440233', '新丰县', 233, 0, 0, 'Xinfeng Xian', 'XFY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2332, '440303', '罗湖区', 234, 0, 0, 'Luohu Qu', 'LHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2443, '445321', '新兴县', 252, 0, 0, 'Xinxing Xian', 'XNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2448, '450102', '兴宁区', 253, 0, 0, 'Xingning Qu', 'XNE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2457, '450125', '上林县', 253, 0, 0, 'Shanglin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2462, '450203', '鱼峰区', 254, 0, 0, 'Yufeng Qu', 'YFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2467, '450223', '鹿寨县', 254, 0, 0, 'Luzhai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2470, '450226', '三江侗族自治县', 254, 0, 0, 'Sanjiang Dongzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2478, '450322', '临桂县', 255, 0, 0, 'Lingui Xian', 'LGI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2482, '450326', '永福县', 255, 0, 0, 'Yongfu Xian', 'YFU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2488, '450332', '恭城瑶族自治县', 255, 0, 0, 'Gongcheng Yaozu Zizhixian', 'GGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2496, '450481', '岑溪市', 256, 0, 0, 'Cenxi Shi', 'CEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2500, '450512', '铁山港区', 257, 0, 0, 'Tieshangangqu ', 'TSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1829, '371203', '钢城区', 181, 0, 0, 'Gangcheng Qu', 'GCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1830, '371301', '市辖区', 182, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1832, '371311', '罗庄区', 182, 0, 0, 'Luozhuang Qu', 'LZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1833, '371301', '河东区', 182, 0, 0, 'Hedong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1834, '371321', '沂南县', 182, 0, 0, 'Yinan Xian', 'YNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1836, '371323', '沂水县', 182, 0, 0, 'Yishui Xian', 'YIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1837, '371324', '苍山县', 182, 0, 0, 'Cangshan Xian', 'CSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1838, '371325', '费县', 182, 0, 0, 'Fei Xian', 'FEI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1840, '371327', '莒南县', 182, 0, 0, 'Junan Xian', 'JNB');
commit;
prompt 800 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1841, '371328', '蒙阴县', 182, 0, 0, 'Mengyin Xian', 'MYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1843, '371401', '市辖区', 183, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1844, '371402', '德城区', 183, 0, 0, 'Decheng Qu', 'DCD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1845, '371421', '陵县', 183, 0, 0, 'Ling Xian', 'LXL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1846, '371422', '宁津县', 183, 0, 0, 'Ningjin Xian', 'NGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1848, '371424', '临邑县', 183, 0, 0, 'Linyi xian', 'LYM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1849, '371425', '齐河县', 183, 0, 0, 'Qihe Xian', 'QIH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1851, '371427', '夏津县', 183, 0, 0, 'Xiajin Xian', 'XAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1852, '371428', '武城县', 183, 0, 0, 'Wucheng Xian', 'WUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1853, '371481', '乐陵市', 183, 0, 0, 'Leling Shi', 'LEL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1855, '371501', '市辖区', 184, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1856, '371502', '东昌府区', 184, 0, 0, 'Dongchangfu Qu', 'DCF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1858, '371522', '莘县', 184, 0, 0, 'Shen Xian', 'SHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1860, '371524', '东阿县', 184, 0, 0, 'Dong,e Xian', 'DGE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1861, '371525', '冠县', 184, 0, 0, 'Guan Xian', 'GXL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1864, '371601', '市辖区', 185, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1865, '371602', '滨城区', 185, 0, 0, 'Bincheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1867, '371622', '阳信县', 185, 0, 0, 'Yangxin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1868, '371623', '无棣县', 185, 0, 0, 'Wudi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1869, '371624', '沾化县', 185, 0, 0, 'Zhanhua Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1871, '371626', '邹平县', 185, 0, 0, 'Zouping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1873, '371702', '牡丹区', 186, 0, 0, 'Mudan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1874, '371721', '曹县', 186, 0, 0, 'Cao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1876, '371723', '成武县', 186, 0, 0, 'Chengwu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1877, '371724', '巨野县', 186, 0, 0, 'Juye Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1879, '371726', '鄄城县', 186, 0, 0, 'Juancheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1880, '371727', '定陶县', 186, 0, 0, 'Dingtao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1881, '371728', '东明县', 186, 0, 0, 'Dongming Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1883, '410102', '中原区', 187, 0, 0, 'Zhongyuan Qu', 'ZYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1884, '410103', '二七区', 187, 0, 0, 'Erqi Qu', 'EQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1886, '410105', '金水区', 187, 0, 0, 'Jinshui Qu', 'JSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1887, '410106', '上街区', 187, 0, 0, 'Shangjie Qu', 'SJE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1888, '410108', '惠济区', 187, 0, 0, 'Mangshan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1889, '410122', '中牟县', 187, 0, 0, 'Zhongmou Xian', 'ZMO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1890, '410181', '巩义市', 187, 0, 0, 'Gongyi Shi', 'GYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1892, '410183', '新密市', 187, 0, 0, 'Xinmi Shi', 'XMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1893, '410184', '新郑市', 187, 0, 0, 'Xinzheng Shi', 'XZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1894, '410185', '登封市', 187, 0, 0, 'Dengfeng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1896, '410202', '龙亭区', 188, 0, 0, 'Longting Qu', 'LTK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1897, '410203', '顺河回族区', 188, 0, 0, 'Shunhe Huizu Qu', 'SHR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1899, '410205', '禹王台区', 188, 0, 0, 'Yuwangtai Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1900, '410211', '金明区', 188, 0, 0, 'Jinming Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1901, '410221', '杞县', 188, 0, 0, 'Qi Xian', 'QIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1902, '410222', '通许县', 188, 0, 0, 'Tongxu Xian', 'TXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1904, '410224', '开封县', 188, 0, 0, 'Kaifeng Xian', 'KFX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1905, '410225', '兰考县', 188, 0, 0, 'Lankao Xian', 'LKA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1906, '410301', '市辖区', 189, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1908, '410303', '西工区', 189, 0, 0, 'Xigong Qu', 'XGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1909, '410304', '瀍河回族区', 189, 0, 0, 'Chanhehuizu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1911, '410306', '吉利区', 189, 0, 0, 'Jili Qu', 'JLL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1912, '410311', '洛龙区', 189, 0, 0, 'Luolong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1913, '410322', '孟津县', 189, 0, 0, 'Mengjin Xian', 'MGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1915, '410324', '栾川县', 189, 0, 0, 'Luanchuan Xian', 'LCK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1916, '410325', '嵩县', 189, 0, 0, 'Song Xian', 'SON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1917, '410326', '汝阳县', 189, 0, 0, 'Ruyang Xian', 'RUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1918, '410327', '宜阳县', 189, 0, 0, 'Yiyang Xian', 'YYY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1920, '410329', '伊川县', 189, 0, 0, 'Yichuan Xian', 'YCZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1921, '410381', '偃师市', 189, 0, 0, 'Yanshi Shi', 'YST');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1922, '410401', '市辖区', 190, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1924, '410403', '卫东区', 190, 0, 0, 'Weidong Qu', 'WDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1925, '410404', '石龙区', 190, 0, 0, 'Shilong Qu', 'SIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1926, '410411', '湛河区', 190, 0, 0, 'Zhanhe Qu', 'ZHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1928, '410422', '叶县', 190, 0, 0, 'Ye Xian', 'YEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1929, '410423', '鲁山县', 190, 0, 0, 'Lushan Xian', 'LUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1932, '410482', '汝州市', 190, 0, 0, 'Ruzhou Shi', 'RZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1933, '410501', '市辖区', 191, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1934, '410502', '文峰区', 191, 0, 0, 'Wenfeng Qu', 'WFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1936, '410505', '殷都区', 191, 0, 0, 'Yindu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1937, '410506', '龙安区', 191, 0, 0, 'Longan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1938, '410522', '安阳县', 191, 0, 0, 'Anyang Xian', 'AYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1940, '410526', '滑县', 191, 0, 0, 'Hua Xian', 'HUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1941, '410527', '内黄县', 191, 0, 0, 'Neihuang Xian', 'NHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1942, '410581', '林州市', 191, 0, 0, 'Linzhou Shi', 'LZY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1943, '410601', '市辖区', 192, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1945, '410603', '山城区', 192, 0, 0, 'Shancheng Qu', 'SCB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1946, '410611', '淇滨区', 192, 0, 0, 'Qibin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1947, '410621', '浚县', 192, 0, 0, 'Xun Xian', 'XUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1948, '410622', '淇县', 192, 0, 0, 'Qi Xian', 'QXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1950, '410702', '红旗区', 193, 0, 0, 'Hongqi Qu', 'HQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1951, '410703', '卫滨区', 193, 0, 0, 'Weibin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1952, '410704', '凤泉区', 193, 0, 0, 'Fengquan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1954, '410721', '新乡县', 193, 0, 0, 'Xinxiang Xian', 'XXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1955, '410724', '获嘉县', 193, 0, 0, 'Huojia Xian', 'HOJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1956, '410725', '原阳县', 193, 0, 0, 'Yuanyang Xian', 'YYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1958, '410727', '封丘县', 193, 0, 0, 'Fengqiu Xian', 'FQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1959, '410728', '长垣县', 193, 0, 0, 'Changyuan Xian', 'CYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1960, '410781', '卫辉市', 193, 0, 0, 'Weihui Shi', 'WHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1962, '410801', '市辖区', 194, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1963, '410802', '解放区', 194, 0, 0, 'Jiefang Qu', 'JFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1964, '410803', '中站区', 194, 0, 0, 'Zhongzhan Qu', 'ZZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1966, '410811', '山阳区', 194, 0, 0, 'Shanyang Qu', 'SYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1967, '410821', '修武县', 194, 0, 0, 'Xiuwu Xian', 'XUW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1968, '410822', '博爱县', 194, 0, 0, 'Bo,ai Xian', 'BOA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1970, '410825', '温县', 194, 0, 0, 'Wen Xian', 'WEN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1971, '419001', '济源市', 194, 0, 0, 'Jiyuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1972, '410882', '沁阳市', 194, 0, 0, 'Qinyang Shi', 'QYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1974, '410901', '市辖区', 195, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1975, '410902', '华龙区', 195, 0, 0, 'Hualong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1976, '410922', '清丰县', 195, 0, 0, 'Qingfeng Xian', 'QFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1977, '410923', '南乐县', 195, 0, 0, 'Nanle Xian', 'NLE');
commit;
prompt 900 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1978, '410926', '范县', 195, 0, 0, 'Fan Xian', 'FAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1979, '410927', '台前县', 195, 0, 0, 'Taiqian Xian', 'TQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1980, '410928', '濮阳县', 195, 0, 0, 'Puyang Xian', 'PUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1981, '411001', '市辖区', 196, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1982, '411002', '魏都区', 196, 0, 0, 'Weidu Qu', 'WED');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1983, '411023', '许昌县', 196, 0, 0, 'Xuchang Xian', 'XUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1984, '411024', '鄢陵县', 196, 0, 0, 'Yanling Xian', 'YLY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1985, '411025', '襄城县', 196, 0, 0, 'Xiangcheng Xian', 'XAC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1986, '411081', '禹州市', 196, 0, 0, 'Yuzhou Shi', 'YUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1987, '411082', '长葛市', 196, 0, 0, 'Changge Shi', 'CGE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1988, '411101', '市辖区', 197, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1989, '411102', '源汇区', 197, 0, 0, 'Yuanhui Qu', 'YHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1990, '411103', '郾城区', 197, 0, 0, 'Yancheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1991, '411104', '召陵区', 197, 0, 0, 'Zhaoling Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1992, '411121', '舞阳县', 197, 0, 0, 'Wuyang Xian', 'WYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1993, '411122', '临颍县', 197, 0, 0, 'Linying Xian', 'LNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1994, '411201', '市辖区', 198, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1995, '411202', '湖滨区', 198, 0, 0, 'Hubin Qu', 'HBI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1996, '411221', '渑池县', 198, 0, 0, 'Mianchi Xian', 'MCI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1997, '411222', '陕县', 198, 0, 0, 'Shan Xian', 'SHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1998, '411224', '卢氏县', 198, 0, 0, 'Lushi Xian', 'LUU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1999, '411281', '义马市', 198, 0, 0, 'Yima Shi', 'YMA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2000, '411282', '灵宝市', 198, 0, 0, 'Lingbao Shi', 'LBS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2001, '411301', '市辖区', 199, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2002, '411302', '宛城区', 199, 0, 0, 'Wancheng Qu', 'WCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2003, '411303', '卧龙区', 199, 0, 0, 'Wolong Qu', 'WOL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2004, '411321', '南召县', 199, 0, 0, 'Nanzhao Xian', 'NZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2005, '411322', '方城县', 199, 0, 0, 'Fangcheng Xian', 'FCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2006, '411323', '西峡县', 199, 0, 0, 'Xixia Xian', 'XXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2008, '411325', '内乡县', 199, 0, 0, 'Neixiang Xian', 'NXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2009, '411326', '淅川县', 199, 0, 0, 'Xichuan Xian', 'XCY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2011, '411328', '唐河县', 199, 0, 0, 'Tanghe Xian', 'TGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2012, '411329', '新野县', 199, 0, 0, 'Xinye Xian', 'XYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2014, '411381', '邓州市', 199, 0, 0, 'Dengzhou Shi', 'DGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2015, '411401', '市辖区', 200, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2016, '411402', '梁园区', 200, 0, 0, 'Liangyuan Qu', 'LYY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2017, '411403', '睢阳区', 200, 0, 0, 'Suiyang Qu', 'SYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2019, '411422', '睢县', 200, 0, 0, 'Sui Xian', 'SUI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2020, '411423', '宁陵县', 200, 0, 0, 'Ningling Xian', 'NGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2022, '411425', '虞城县', 200, 0, 0, 'Yucheng Xian', 'YUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2023, '411426', '夏邑县', 200, 0, 0, 'Xiayi Xian', 'XAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2025, '411501', '市辖区', 201, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2026, '411502', '浉河区', 201, 0, 0, 'Shihe Qu', 'SHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2027, '411503', '平桥区', 201, 0, 0, 'Pingqiao Qu', 'PQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2028, '411521', '罗山县', 201, 0, 0, 'Luoshan Xian', 'LSE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2030, '411523', '新县', 201, 0, 0, 'Xin Xian', 'XXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2031, '411524', '商城县', 201, 0, 0, 'Shangcheng Xian', 'SCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2032, '411525', '固始县', 201, 0, 0, 'Gushi Xian', 'GSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2034, '411527', '淮滨县', 201, 0, 0, 'Huaibin Xian', 'HBN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2035, '411528', '息县', 201, 0, 0, 'Xi Xian', 'XIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2036, '411601', '市辖区', 202, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2037, '411602', '川汇区', 202, 0, 0, 'Chuanhui Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2038, '411621', '扶沟县', 202, 0, 0, 'Fugou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2040, '411623', '商水县', 202, 0, 0, 'Shangshui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2041, '411624', '沈丘县', 202, 0, 0, 'Shenqiu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2043, '411626', '淮阳县', 202, 0, 0, 'Huaiyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2044, '411627', '太康县', 202, 0, 0, 'Taikang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2046, '411681', '项城市', 202, 0, 0, 'Xiangcheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2047, '411701', '市辖区', 203, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2048, '411702', '驿城区', 203, 0, 0, 'Yicheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2049, '411721', '西平县', 203, 0, 0, 'Xiping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2051, '411723', '平舆县', 203, 0, 0, 'Pingyu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2052, '411724', '正阳县', 203, 0, 0, 'Zhengyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2053, '411725', '确山县', 203, 0, 0, 'Queshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2055, '411727', '汝南县', 203, 0, 0, 'Runan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2056, '411728', '遂平县', 203, 0, 0, 'Suiping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2057, '411729', '新蔡县', 203, 0, 0, 'Xincai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2058, '420101', '市辖区', 204, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2060, '420103', '江汉区', 204, 0, 0, 'Jianghan Qu', 'JHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2061, '420104', '硚口区', 204, 0, 0, 'Qiaokou Qu', 'QKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2062, '420105', '汉阳区', 204, 0, 0, 'Hanyang Qu', 'HYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2064, '420107', '青山区', 204, 0, 0, 'Qingshan Qu', 'QSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2065, '420111', '洪山区', 204, 0, 0, 'Hongshan Qu', 'HSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2066, '420112', '东西湖区', 204, 0, 0, 'Dongxihu Qu', 'DXH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2067, '420113', '汉南区', 204, 0, 0, 'Hannan Qu', 'HNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2069, '420115', '江夏区', 204, 0, 0, 'Jiangxia Qu', 'JXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2070, '420116', '黄陂区', 204, 0, 0, 'Huangpi Qu', 'HPI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2072, '420201', '市辖区', 205, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2073, '420202', '黄石港区', 205, 0, 0, 'Huangshigang Qu', 'HSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2074, '420203', '西塞山区', 205, 0, 0, 'Xisaishan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2075, '420204', '下陆区', 205, 0, 0, 'Xialu Qu', 'XAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2076, '420205', '铁山区', 205, 0, 0, 'Tieshan Qu', 'TSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2078, '420281', '大冶市', 205, 0, 0, 'Daye Shi', 'DYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2079, '420301', '市辖区', 206, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2080, '420302', '茅箭区', 206, 0, 0, 'Maojian Qu', 'MJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2082, '420321', '郧县', 206, 0, 0, 'Yun Xian', 'YUN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2083, '420322', '郧西县', 206, 0, 0, 'Yunxi Xian', 'YNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2084, '420323', '竹山县', 206, 0, 0, 'Zhushan Xian', 'ZHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2086, '420325', '房县', 206, 0, 0, 'Fang Xian', 'FAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2087, '420381', '丹江口市', 206, 0, 0, 'Danjiangkou Shi', 'DJK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2088, '420501', '市辖区', 207, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2090, '420503', '伍家岗区', 207, 0, 0, 'Wujiagang Qu', 'WJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2091, '420504', '点军区', 207, 0, 0, 'Dianjun Qu', 'DJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2092, '420505', '猇亭区', 207, 0, 0, 'Xiaoting Qu', 'XTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2093, '420506', '夷陵区', 207, 0, 0, 'Yiling Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2095, '420526', '兴山县', 207, 0, 0, 'Xingshan Xian', 'XSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2096, '420527', '秭归县', 207, 0, 0, 'Zigui Xian', 'ZGI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2098, '420529', '五峰土家族自治县', 207, 0, 0, 'Wufeng Tujiazu Zizhixian', 'WFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2099, '420581', '宜都市', 207, 0, 0, 'Yidu Shi', 'YID');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2101, '420583', '枝江市', 207, 0, 0, 'Zhijiang Shi', 'ZIJ');
commit;
prompt 1000 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2102, '420601', '市辖区', 208, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2103, '420602', '襄城区', 208, 0, 0, 'Xiangcheng Qu', 'XXF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2104, '420606', '樊城区', 208, 0, 0, 'Fancheng Qu', 'FNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2105, '420607', '襄阳区', 208, 0, 0, 'Xiangyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2106, '420624', '南漳县', 208, 0, 0, 'Nanzhang Xian', 'NZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2107, '420625', '谷城县', 208, 0, 0, 'Gucheng Xian', 'GUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2108, '420626', '保康县', 208, 0, 0, 'Baokang Xian', 'BKG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2109, '420682', '老河口市', 208, 0, 0, 'Laohekou Shi', 'LHK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2110, '420683', '枣阳市', 208, 0, 0, 'Zaoyang Shi', 'ZOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2111, '420684', '宜城市', 208, 0, 0, 'Yicheng Shi', 'YCW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2112, '420701', '市辖区', 209, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2113, '420702', '梁子湖区', 209, 0, 0, 'Liangzihu Qu', 'LZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2114, '420703', '华容区', 209, 0, 0, 'Huarong Qu', 'HRQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2115, '420704', '鄂城区', 209, 0, 0, 'Echeng Qu', 'ECQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2116, '420801', '市辖区', 210, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2117, '420802', '东宝区', 210, 0, 0, 'Dongbao Qu', 'DBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2118, '420804', '掇刀区', 210, 0, 0, 'Duodao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2119, '420821', '京山县', 210, 0, 0, 'Jingshan Xian', 'JSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2120, '420822', '沙洋县', 210, 0, 0, 'Shayang Xian', 'SYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2121, '420881', '钟祥市', 210, 0, 0, 'Zhongxiang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2122, '420901', '市辖区', 211, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2123, '420902', '孝南区', 211, 0, 0, 'Xiaonan Qu', 'XNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2124, '420921', '孝昌县', 211, 0, 0, 'Xiaochang Xian', 'XOC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2125, '420922', '大悟县', 211, 0, 0, 'Dawu Xian', 'DWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2126, '420923', '云梦县', 211, 0, 0, 'Yunmeng Xian', 'YMX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2127, '420981', '应城市', 211, 0, 0, 'Yingcheng Shi', 'YCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2128, '420982', '安陆市', 211, 0, 0, 'Anlu Shi', 'ALU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2129, '420984', '汉川市', 211, 0, 0, 'Hanchuan Shi', 'HCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2130, '421001', '市辖区', 212, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2131, '421002', '沙市区', 212, 0, 0, 'Shashi Qu', 'SSJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2132, '421003', '荆州区', 212, 0, 0, 'Jingzhou Qu', 'JZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2133, '421022', '公安县', 212, 0, 0, 'Gong,an Xian', 'GGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2134, '421023', '监利县', 212, 0, 0, 'Jianli Xian', 'JLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2135, '421024', '江陵县', 212, 0, 0, 'Jiangling Xian', 'JLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2137, '421083', '洪湖市', 212, 0, 0, 'Honghu Shi', 'HHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2138, '421087', '松滋市', 212, 0, 0, 'Songzi Shi', 'SZF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2139, '421101', '市辖区', 213, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2141, '421121', '团风县', 213, 0, 0, 'Tuanfeng Xian', 'TFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2142, '421122', '红安县', 213, 0, 0, 'Hong,an Xian', 'HGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2143, '421123', '罗田县', 213, 0, 0, 'Luotian Xian', 'LTE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2145, '421125', '浠水县', 213, 0, 0, 'Xishui Xian', 'XSE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2146, '421126', '蕲春县', 213, 0, 0, 'Qichun Xian', 'QCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2147, '421127', '黄梅县', 213, 0, 0, 'Huangmei Xian', 'HGM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2149, '421182', '武穴市', 213, 0, 0, 'Wuxue Shi', 'WXE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2150, '421201', '市辖区', 214, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2151, '421202', '咸安区', 214, 0, 0, 'Xian,an Qu', 'XAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2153, '421222', '通城县', 214, 0, 0, 'Tongcheng Xian', 'TCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2154, '421223', '崇阳县', 214, 0, 0, 'Chongyang Xian', 'CGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2155, '421224', '通山县', 214, 0, 0, 'Tongshan Xian', 'TSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2157, '421301', '市辖区', 215, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2158, '421303', '曾都区', 215, 0, 0, 'Zengdu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2159, '421381', '广水市', 215, 0, 0, 'Guangshui Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2161, '422802', '利川市', 216, 0, 0, 'Lichuan Shi', 'LCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2162, '422822', '建始县', 216, 0, 0, 'Jianshi Xian', 'JSE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2163, '422823', '巴东县', 216, 0, 0, 'Badong Xian', 'BDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2165, '422826', '咸丰县', 216, 0, 0, 'Xianfeng Xian', 'XFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2166, '422827', '来凤县', 216, 0, 0, 'Laifeng Xian', 'LFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2167, '422828', '鹤峰县', 216, 0, 0, 'Hefeng Xian', 'HEF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2169, '429005', '潜江市', 217, 0, 0, 'Qianjiang Shi', 'QNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2170, '429006', '天门市', 217, 0, 0, 'Tianmen Shi', 'TMS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2172, '430101', '市辖区', 218, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2173, '430102', '芙蓉区', 218, 0, 0, 'Furong Qu', 'FRQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2174, '430103', '天心区', 218, 0, 0, 'Tianxin Qu', 'TXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2175, '430104', '岳麓区', 218, 0, 0, 'Yuelu Qu', 'YLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2176, '430105', '开福区', 218, 0, 0, 'Kaifu Qu', 'KFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2178, '430121', '长沙县', 218, 0, 0, 'Changsha Xian', 'CSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2179, '430122', '望城县', 218, 0, 0, 'Wangcheng Xian', 'WCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2180, '430124', '宁乡县', 218, 0, 0, 'Ningxiang Xian', 'NXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2182, '430201', '市辖区', 219, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2183, '430202', '荷塘区', 219, 0, 0, 'Hetang Qu', 'HTZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2184, '430203', '芦淞区', 219, 0, 0, 'Lusong Qu', 'LZZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2186, '430211', '天元区', 219, 0, 0, 'Tianyuan Qu', 'TYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2187, '430221', '株洲县', 219, 0, 0, 'Zhuzhou Xian', 'ZZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2188, '430223', '攸县', 219, 0, 0, 'You Xian', 'YOU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2190, '430225', '炎陵县', 219, 0, 0, 'Yanling Xian', 'YLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2191, '430281', '醴陵市', 219, 0, 0, 'Liling Shi', 'LIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2192, '430301', '市辖区', 220, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2194, '430304', '岳塘区', 220, 0, 0, 'Yuetang Qu', 'YTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2195, '430321', '湘潭县', 220, 0, 0, 'Xiangtan Qu', 'XTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2196, '430381', '湘乡市', 220, 0, 0, 'Xiangxiang Shi', 'XXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2198, '430401', '市辖区', 221, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2199, '430405', '珠晖区', 221, 0, 0, 'Zhuhui Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2200, '430406', '雁峰区', 221, 0, 0, 'Yanfeng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2202, '430408', '蒸湘区', 221, 0, 0, 'Zhengxiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2203, '430412', '南岳区', 221, 0, 0, 'Nanyue Qu', 'NYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2204, '430421', '衡阳县', 221, 0, 0, 'Hengyang Xian', 'HYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2206, '430423', '衡山县', 221, 0, 0, 'Hengshan Xian', 'HSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2207, '430424', '衡东县', 221, 0, 0, 'Hengdong Xian', 'HED');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2208, '430426', '祁东县', 221, 0, 0, 'Qidong Xian', 'QDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2210, '430482', '常宁市', 221, 0, 0, 'Changning Shi', 'CNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2211, '430501', '市辖区', 222, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2212, '430502', '双清区', 222, 0, 0, 'Shuangqing Qu', 'SGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2214, '430511', '北塔区', 222, 0, 0, 'Beita Qu', 'BET');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2215, '430521', '邵东县', 222, 0, 0, 'Shaodong Xian', 'SDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2216, '430522', '新邵县', 222, 0, 0, 'Xinshao Xian', 'XSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2218, '430524', '隆回县', 222, 0, 0, 'Longhui Xian', 'LGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2219, '430525', '洞口县', 222, 0, 0, 'Dongkou Xian', 'DGK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2220, '430527', '绥宁县', 222, 0, 0, 'Suining Xian', 'SNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2222, '430529', '城步苗族自治县', 222, 0, 0, 'Chengbu Miaozu Zizhixian', 'CBU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2224, '430601', '市辖区', 223, 0, 0, 'Shixiaqu', '2');
commit;
prompt 1100 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2225, '430602', '岳阳楼区', 223, 0, 0, 'Yueyanglou Qu', 'YYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2226, '430603', '云溪区', 223, 0, 0, 'Yunxi Qu', 'YXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2228, '430621', '岳阳县', 223, 0, 0, 'Yueyang Xian', 'YYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2229, '430623', '华容县', 223, 0, 0, 'Huarong Xian', 'HRG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2230, '430624', '湘阴县', 223, 0, 0, 'Xiangyin Xian', 'XYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2233, '430682', '临湘市', 223, 0, 0, 'Linxiang Shi', 'LXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2234, '430701', '市辖区', 224, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2236, '430703', '鼎城区', 224, 0, 0, 'Dingcheng Qu', 'DCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2238, '430722', '汉寿县', 224, 0, 0, 'Hanshou Xian', 'HSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2240, '430724', '临澧县', 224, 0, 0, 'Linli Xian', 'LNL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2241, '430725', '桃源县', 224, 0, 0, 'Taoyuan Xian', 'TOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2244, '430801', '市辖区', 225, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2245, '430802', '永定区', 225, 0, 0, 'Yongding Qu', 'YDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2247, '430821', '慈利县', 225, 0, 0, 'Cili Xian', 'CLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2249, '430901', '市辖区', 226, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2250, '430902', '资阳区', 226, 0, 0, 'Ziyang Qu', 'ZYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2252, '430921', '南县', 226, 0, 0, 'Nan Xian', 'NXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2253, '430922', '桃江县', 226, 0, 0, 'Taojiang Xian', 'TJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2255, '430981', '沅江市', 226, 0, 0, 'Yuanjiang Shi', 'YJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2256, '431001', '市辖区', 227, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2257, '431002', '北湖区', 227, 0, 0, 'Beihu Qu', 'BHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2258, '431003', '苏仙区', 227, 0, 0, 'Suxian Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2260, '431022', '宜章县', 227, 0, 0, 'yizhang Xian', 'YZA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2261, '431023', '永兴县', 227, 0, 0, 'Yongxing Xian', 'YXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2263, '431025', '临武县', 227, 0, 0, 'Linwu Xian', 'LWX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2264, '431026', '汝城县', 227, 0, 0, 'Rucheng Xian', 'RCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2266, '431028', '安仁县', 227, 0, 0, 'Anren Xian', 'ARN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2267, '431081', '资兴市', 227, 0, 0, 'Zixing Shi', 'ZXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3350, '623027', '夏河县', 349, 0, 0, 'Xiahe Xian', 'XHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3351, '630101', '市辖区', 350, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3352, '630102', '城东区', 350, 0, 0, 'Chengdong Qu', 'CDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3353, '630103', '城中区', 350, 0, 0, 'Chengzhong Qu', 'CZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3354, '630104', '城西区', 350, 0, 0, 'Chengxi Qu', 'CXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3355, '630105', '城北区', 350, 0, 0, 'Chengbei Qu', 'CBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3357, '630122', '湟中县', 350, 0, 0, 'Huangzhong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3358, '630123', '湟源县', 350, 0, 0, 'Huangyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3359, '632121', '平安县', 351, 0, 0, 'Ping,an Xian', 'PAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3361, '632123', '乐都县', 351, 0, 0, 'Ledu Xian', 'LDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3362, '632126', '互助土族自治县', 351, 0, 0, 'Huzhu Tuzu Zizhixian', 'HZT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3364, '632128', '循化撒拉族自治县', 351, 0, 0, 'Xunhua Salazu Zizhixian', 'XUH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3365, '632221', '门源回族自治县', 352, 0, 0, 'Menyuan Huizu Zizhixian', 'MYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3367, '632223', '海晏县', 352, 0, 0, 'Haiyan Xian', 'HIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3368, '632224', '刚察县', 352, 0, 0, 'Gangca Xian', 'GAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3370, '632322', '尖扎县', 353, 0, 0, 'Jainca Xian', 'JAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3371, '632323', '泽库县', 353, 0, 0, 'Zekog Xian', 'ZEK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3373, '632521', '共和县', 354, 0, 0, 'Gonghe Xian', 'GHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3374, '632522', '同德县', 354, 0, 0, 'Tongde Xian', 'TDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3375, '632523', '贵德县', 354, 0, 0, 'Guide Xian', 'GID');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3376, '632524', '兴海县', 354, 0, 0, 'Xinghai Xian', 'XHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3378, '632621', '玛沁县', 355, 0, 0, 'Maqen Xian', 'MAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3379, '632622', '班玛县', 355, 0, 0, 'Baima Xian', 'BMX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3380, '632623', '甘德县', 355, 0, 0, 'Gade Xian', 'GAD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3382, '632625', '久治县', 355, 0, 0, 'Jigzhi Xian', 'JUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3383, '632626', '玛多县', 355, 0, 0, 'Madoi Xian', 'MAD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3385, '632722', '杂多县', 356, 0, 0, 'Zadoi Xian', 'ZAD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3386, '632723', '称多县', 356, 0, 0, 'Chindu Xian', 'CHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3387, '632724', '治多县', 356, 0, 0, 'Zhidoi Xian', 'ZHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3389, '632726', '曲麻莱县', 356, 0, 0, 'Qumarleb Xian', 'QUM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3390, '632801', '格尔木市', 357, 0, 0, 'Golmud Shi', 'GOS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3392, '632821', '乌兰县', 357, 0, 0, 'Ulan Xian', 'ULA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3393, '632822', '都兰县', 357, 0, 0, 'Dulan Xian', 'DUL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3394, '632823', '天峻县', 357, 0, 0, 'Tianjun Xian', 'TJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3395, '640101', '市辖区', 358, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3396, '640104', '兴庆区', 358, 0, 0, 'Xingqing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3397, '640105', '西夏区', 358, 0, 0, 'Xixia Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3398, '640106', '金凤区', 358, 0, 0, 'Jinfeng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3400, '640122', '贺兰县', 358, 0, 0, 'Helan Xian', 'HLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3401, '640181', '灵武市', 358, 0, 0, 'Lingwu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3402, '640201', '市辖区', 359, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3404, '640205', '惠农区', 359, 0, 0, 'Huinong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3405, '640221', '平罗县', 359, 0, 0, 'Pingluo Xian', 'PLO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3406, '640301', '市辖区', 360, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3407, '640302', '利通区', 360, 0, 0, 'Litong Qu', 'LTW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3408, '640323', '盐池县', 360, 0, 0, 'Yanchi Xian', 'YCY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3410, '640381', '青铜峡市', 360, 0, 0, 'Qingtongxia Xian', 'QTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3411, '640401', '市辖区', 361, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3412, '640402', '原州区', 361, 0, 0, 'Yuanzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3413, '640422', '西吉县', 361, 0, 0, 'Xiji Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3415, '640424', '泾源县', 361, 0, 0, 'Jingyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3416, '640425', '彭阳县', 361, 0, 0, 'Pengyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3417, '640501', '市辖区', 362, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3418, '640502', '沙坡头区', 362, 0, 0, 'Shapotou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3420, '640522', '海原县', 362, 0, 0, 'Haiyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3421, '650101', '市辖区', 363, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3422, '650102', '天山区', 363, 0, 0, 'Tianshan Qu', 'TSL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3423, '650103', '沙依巴克区', 363, 0, 0, 'Saybag Qu', 'SAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3424, '650104', '新市区', 363, 0, 0, 'Xinshi Qu', 'XSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3426, '650106', '头屯河区', 363, 0, 0, 'Toutunhe Qu', 'TTH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3427, '650107', '达坂城区', 363, 0, 0, 'Dabancheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3428, '650109', '米东区', 363, 0, 0, 'Midong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3429, '650121', '乌鲁木齐县', 363, 0, 0, 'Urumqi Xian', 'URX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3430, '650201', '市辖区', 364, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3432, '650203', '克拉玛依区', 364, 0, 0, 'Karamay Qu', 'KRQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3433, '650204', '白碱滩区', 364, 0, 0, 'Baijiantan Qu', 'BJT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3434, '650205', '乌尔禾区', 364, 0, 0, 'Orku Qu', 'ORK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3436, '652122', '鄯善县', 365, 0, 0, 'Shanshan(piqan) Xian', 'SSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3437, '652123', '托克逊县', 365, 0, 0, 'Toksun Xian', 'TOK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3441, '652301', '昌吉市', 367, 0, 0, 'Changji Shi', 'CJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3442, '652302', '阜康市', 367, 0, 0, 'Fukang Shi', 'FKG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3445, '652324', '玛纳斯县', 367, 0, 0, 'Manas Xian', 'MAS');
commit;
prompt 1200 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3446, '652325', '奇台县', 367, 0, 0, 'Qitai Xian', 'QTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3447, '652327', '吉木萨尔县', 367, 0, 0, 'Jimsar Xian', 'JIM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3449, '652701', '博乐市', 368, 0, 0, 'Bole(Bortala) Shi', 'BLE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3450, '652722', '精河县', 368, 0, 0, 'Jinghe(Jing) Xian', 'JGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3452, '652801', '库尔勒市', 369, 0, 0, 'Korla Shi', 'KOR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3453, '652822', '轮台县', 369, 0, 0, 'Luntai(Bugur) Xian', 'LTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3455, '652824', '若羌县', 369, 0, 0, 'Ruoqiang(Qakilik) Xian', 'RQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (492, '130529', '巨鹿县', 41, 0, 0, 'Julu Xian', 'JLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (503, '130603', '北市区', 42, 0, 0, 'Beishi Qu', 'BSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (944, '211402', '连山区', 84, 0, 0, 'Lianshan Qu', 'LSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (945, '211403', '龙港区', 84, 0, 0, 'Longgang Qu', 'LGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (946, '211404', '南票区', 84, 0, 0, 'Nanpiao Qu', 'NPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (947, '211421', '绥中县', 84, 0, 0, 'Suizhong Xian', 'SZL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (948, '211422', '建昌县', 84, 0, 0, 'Jianchang Xian', 'JCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (949, '211481', '兴城市', 84, 0, 0, 'Xingcheng Shi', 'XCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (950, '220101', '市辖区', 85, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (951, '220102', '南关区', 85, 0, 0, 'Nanguan Qu', 'NGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (952, '220103', '宽城区', 85, 0, 0, 'Kuancheng Qu', 'KCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (953, '220104', '朝阳区', 85, 0, 0, 'Chaoyang Qu ', 'CYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (954, '220105', '二道区', 85, 0, 0, 'Erdao Qu', 'EDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (955, '220106', '绿园区', 85, 0, 0, 'Lvyuan Qu', 'LYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (956, '220112', '双阳区', 85, 0, 0, 'Shuangyang Qu', 'SYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (957, '220122', '农安县', 85, 0, 0, 'Nong,an Xian ', 'NAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (958, '220181', '九台市', 85, 0, 0, 'Jiutai Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (959, '220182', '榆树市', 85, 0, 0, 'Yushu Shi', 'YSS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (960, '220183', '德惠市', 85, 0, 0, 'Dehui Shi', 'DEH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (961, '220201', '市辖区', 86, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (962, '220202', '昌邑区', 86, 0, 0, 'Changyi Qu', 'CYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (963, '220203', '龙潭区', 86, 0, 0, 'Longtan Qu', 'LTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (964, '220204', '船营区', 86, 0, 0, 'Chuanying Qu', 'CYJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (965, '220211', '丰满区', 86, 0, 0, 'Fengman Qu', 'FMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (966, '220221', '永吉县', 86, 0, 0, 'Yongji Xian', 'YOJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (967, '220281', '蛟河市', 86, 0, 0, 'Jiaohe Shi', 'JHJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (968, '220282', '桦甸市', 86, 0, 0, 'Huadian Shi', 'HDJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (969, '220283', '舒兰市', 86, 0, 0, 'Shulan Shi', 'SLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (970, '220284', '磐石市', 86, 0, 0, 'Panshi Shi', 'PSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (971, '220301', '市辖区', 87, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (972, '220302', '铁西区', 87, 0, 0, 'Tiexi Qu', 'TXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (973, '220303', '铁东区', 87, 0, 0, 'Tiedong Qu ', 'TDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (974, '220322', '梨树县', 87, 0, 0, 'Lishu Xian', 'LSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (975, '220323', '伊通满族自治县', 87, 0, 0, 'Yitong Manzu Zizhixian', 'YTO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (976, '220381', '公主岭市', 87, 0, 0, 'Gongzhuling Shi', 'GZL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (977, '220382', '双辽市', 87, 0, 0, 'Shuangliao Shi', 'SLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (978, '220401', '市辖区', 88, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (979, '220402', '龙山区', 88, 0, 0, 'Longshan Qu', 'LGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (980, '220403', '西安区', 88, 0, 0, 'Xi,an Qu', 'XAA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (981, '220421', '东丰县', 88, 0, 0, 'Dongfeng Xian', 'DGF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (982, '220422', '东辽县', 88, 0, 0, 'Dongliao Xian ', 'DLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (983, '220501', '市辖区', 89, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (984, '220502', '东昌区', 89, 0, 0, 'Dongchang Qu', 'DCT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (985, '220503', '二道江区', 89, 0, 0, 'Erdaojiang Qu', 'EDJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (986, '220521', '通化县', 89, 0, 0, 'Tonghua Xian ', 'THX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (987, '220523', '辉南县', 89, 0, 0, 'Huinan Xian ', 'HNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (988, '220524', '柳河县', 89, 0, 0, 'Liuhe Xian ', 'LHC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (990, '220582', '集安市', 89, 0, 0, 'Ji,an Shi', 'KNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (991, '220601', '市辖区', 90, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (992, '220602', '八道江区', 90, 0, 0, 'Badaojiang Qu', 'BDJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (993, '220621', '抚松县', 90, 0, 0, 'Fusong Xian', 'FSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (994, '220622', '靖宇县', 90, 0, 0, 'Jingyu Xian', 'JYJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (996, '220605', '江源区', 90, 0, 0, 'Jiangyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (997, '220681', '临江市', 90, 0, 0, 'Linjiang Shi', 'LIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (998, '220701', '市辖区', 91, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (999, '220702', '宁江区', 91, 0, 0, 'Ningjiang Qu', 'NJA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1001, '220722', '长岭县', 91, 0, 0, 'Changling Xian', 'CLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1002, '220723', '乾安县', 91, 0, 0, 'Qian,an Xian', 'QAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1003, '220724', '扶余县', 91, 0, 0, 'Fuyu Xian', 'FYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1004, '220801', '市辖区', 92, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1005, '220802', '洮北区', 92, 0, 0, 'Taobei Qu', 'TBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1006, '220821', '镇赉县', 92, 0, 0, 'Zhenlai Xian', 'ZLA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1008, '220881', '洮南市', 92, 0, 0, 'Taonan Shi', 'TNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1009, '220882', '大安市', 92, 0, 0, 'Da,an Shi', 'DNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1010, '222401', '延吉市', 93, 0, 0, 'Yanji Shi', 'YNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1012, '222403', '敦化市', 93, 0, 0, 'Dunhua Shi', 'DHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1013, '222404', '珲春市', 93, 0, 0, 'Hunchun Shi', 'HUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1014, '222405', '龙井市', 93, 0, 0, 'Longjing Shi', 'LJJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1016, '222424', '汪清县', 93, 0, 0, 'Wangqing Xian', 'WGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1017, '222426', '安图县', 93, 0, 0, 'Antu Xian', 'ATU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1018, '230101', '市辖区', 94, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1020, '230103', '南岗区', 94, 0, 0, 'Nangang Qu', 'NGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1021, '230104', '道外区', 94, 0, 0, 'Daowai Qu', 'DWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1022, '230110', '香坊区', 94, 0, 0, 'Xiangfang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1024, '230108', '平房区', 94, 0, 0, 'Pingfang Qu', 'PFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1025, '230109', '松北区', 94, 0, 0, 'Songbei Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1027, '230123', '依兰县', 94, 0, 0, 'Yilan Xian', 'YLH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1028, '230124', '方正县', 94, 0, 0, 'Fangzheng Xian', 'FZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1029, '230125', '宾县', 94, 0, 0, 'Bin Xian', 'BNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1030, '230126', '巴彦县', 94, 0, 0, 'Bayan Xian', 'BYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1032, '230128', '通河县', 94, 0, 0, 'Tonghe Xian', 'TOH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1033, '230129', '延寿县', 94, 0, 0, 'Yanshou Xian', 'YSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1035, '230182', '双城市', 94, 0, 0, 'Shuangcheng Shi', 'SCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1036, '230183', '尚志市', 94, 0, 0, 'Shangzhi Shi', 'SZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1037, '230184', '五常市', 94, 0, 0, 'Wuchang Shi', 'WCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1039, '230202', '龙沙区', 95, 0, 0, 'Longsha Qu', 'LQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1040, '230203', '建华区', 95, 0, 0, 'Jianhua Qu', 'JHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2268, '431101', '市辖区', 228, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2271, '431121', '祁阳县', 228, 0, 0, 'Qiyang Xian', 'QJY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2272, '431122', '东安县', 228, 0, 0, 'Dong,an Xian', 'DOA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2274, '431124', '道县', 228, 0, 0, 'Dao Xian', 'DAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2275, '431125', '江永县', 228, 0, 0, 'Jiangyong Xian', 'JYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2276, '431126', '宁远县', 228, 0, 0, 'Ningyuan Xian', 'NYN');
commit;
prompt 1300 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2278, '431128', '新田县', 228, 0, 0, 'Xintian Xian', 'XTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2280, '431201', '市辖区', 229, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2281, '431202', '鹤城区', 229, 0, 0, 'Hecheng Qu', 'HCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2282, '431221', '中方县', 229, 0, 0, 'Zhongfang Xian', 'ZFX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2283, '431222', '沅陵县', 229, 0, 0, 'Yuanling Xian', 'YNL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2284, '431223', '辰溪县', 229, 0, 0, 'Chenxi Xian', 'CXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2286, '431225', '会同县', 229, 0, 0, 'Huitong Xian', 'HTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2290, '431229', '靖州苗族侗族自治县', 229, 0, 0, 'Jingzhou Miaozu Dongzu Zizhixian', 'JZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2291, '431230', '通道侗族自治县', 229, 0, 0, 'Tongdao Dongzu Zizhixian', 'TDD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2293, '431301', '市辖区', 230, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2294, '431302', '娄星区', 230, 0, 0, 'Louxing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2295, '431321', '双峰县', 230, 0, 0, 'Shuangfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2296, '431322', '新化县', 230, 0, 0, 'Xinhua Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2298, '431382', '涟源市', 230, 0, 0, 'Lianyuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2299, '433101', '吉首市', 231, 0, 0, 'Jishou Shi', 'JSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2301, '433123', '凤凰县', 231, 0, 0, 'Fenghuang Xian', 'FHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2302, '433124', '花垣县', 231, 0, 0, 'Huayuan Xian', 'HYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2304, '433126', '古丈县', 231, 0, 0, 'Guzhang Xian', 'GZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2305, '433127', '永顺县', 231, 0, 0, 'Yongshun Xian', 'YSF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2307, '440101', '市辖区', 232, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2308, '440115', '南沙区', 232, 0, 0, 'Nansha Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2309, '440103', '荔湾区', 232, 0, 0, 'Liwan Qu', 'LWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2310, '440104', '越秀区', 232, 0, 0, 'Yuexiu Qu', 'YXU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2311, '440105', '海珠区', 232, 0, 0, 'Haizhu Qu', 'HZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2313, '440116', '萝岗区', 232, 0, 0, 'Luogang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2314, '440111', '白云区', 232, 0, 0, 'Baiyun Qu', 'BYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2315, '440112', '黄埔区', 232, 0, 0, 'Huangpu Qu', 'HPU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2316, '440113', '番禺区', 232, 0, 0, 'Panyu Qu', 'PNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2318, '440183', '增城市', 232, 0, 0, 'Zengcheng Shi', 'ZEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2319, '440184', '从化市', 232, 0, 0, 'Conghua Shi', 'CNH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2320, '440201', '市辖区', 233, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2322, '440204', '浈江区', 233, 0, 0, 'Zhenjiang Qu', 'ZJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2323, '440205', '曲江区', 233, 0, 0, 'Qujiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2324, '440222', '始兴县', 233, 0, 0, 'Shixing Xian', 'SXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2325, '440224', '仁化县', 233, 0, 0, 'Renhua Xian', 'RHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2327, '440232', '乳源瑶族自治县', 233, 0, 0, 'Ruyuan Yaozu Zizhixian', 'RYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2329, '440281', '乐昌市', 233, 0, 0, 'Lechang Shi', 'LEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2330, '440282', '南雄市', 233, 0, 0, 'Nanxiong Shi', 'NXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2331, '440301', '市辖区', 234, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2333, '440304', '福田区', 234, 0, 0, 'Futian Qu', 'FTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2334, '440305', '南山区', 234, 0, 0, 'Nanshan Qu', 'NSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2335, '440306', '宝安区', 234, 0, 0, 'Bao,an Qu', 'BAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2337, '440308', '盐田区', 234, 0, 0, 'Yan Tian Qu', 'YTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2338, '440401', '市辖区', 235, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2339, '440402', '香洲区', 235, 0, 0, 'Xiangzhou Qu', 'XZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2340, '440403', '斗门区', 235, 0, 0, 'Doumen Qu', 'DOU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2341, '440404', '金湾区', 235, 0, 0, 'Jinwan Qu', 'JW Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2342, '440501', '市辖区', 236, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2343, '440507', '龙湖区', 236, 0, 0, 'Longhu Qu', 'LHH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2344, '440511', '金平区', 236, 0, 0, 'Jinping Qu', 'JPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2345, '440512', '濠江区', 236, 0, 0, 'Haojiang Qu', 'HJ Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2346, '440513', '潮阳区', 236, 0, 0, 'Chaoyang  Qu', 'CHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2347, '440514', '潮南区', 236, 0, 0, 'Chaonan Qu', 'CN Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2348, '440515', '澄海区', 236, 0, 0, 'Chenghai QU', 'CHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2349, '440523', '南澳县', 236, 0, 0, 'Nan,ao Xian', 'NAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2350, '440601', '市辖区', 237, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2351, '440604', '禅城区', 237, 0, 0, 'Chancheng Qu', 'CC Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2352, '440605', '南海区', 237, 0, 0, 'Nanhai Shi', 'NAH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2353, '440606', '顺德区', 237, 0, 0, 'Shunde Shi', 'SUD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2354, '440607', '三水区', 237, 0, 0, 'Sanshui Shi', 'SJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2355, '440608', '高明区', 237, 0, 0, 'Gaoming Shi', 'GOM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2356, '440701', '市辖区', 238, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2357, '440703', '蓬江区', 238, 0, 0, 'Pengjiang Qu', 'PJJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2358, '440704', '江海区', 238, 0, 0, 'Jianghai Qu', 'JHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2359, '440705', '新会区', 238, 0, 0, 'Xinhui Shi', 'XIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2360, '440781', '台山市', 238, 0, 0, 'Taishan Shi', 'TSS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2361, '440783', '开平市', 238, 0, 0, 'Kaiping Shi', 'KPS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2362, '440784', '鹤山市', 238, 0, 0, 'Heshan Shi', 'HES');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2363, '440785', '恩平市', 238, 0, 0, 'Enping Shi', 'ENP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2364, '440801', '市辖区', 239, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2365, '440802', '赤坎区', 239, 0, 0, 'Chikan Qu', 'CKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2366, '440803', '霞山区', 239, 0, 0, 'Xiashan Qu', 'XAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2367, '440804', '坡头区', 239, 0, 0, 'Potou Qu', 'PTU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2368, '440811', '麻章区', 239, 0, 0, 'Mazhang Qu', 'MZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2369, '440823', '遂溪县', 239, 0, 0, 'Suixi Xian', 'SXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2370, '440825', '徐闻县', 239, 0, 0, 'Xuwen Xian', 'XWN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2371, '440881', '廉江市', 239, 0, 0, 'Lianjiang Shi', 'LJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2372, '440882', '雷州市', 239, 0, 0, 'Leizhou Shi', 'LEZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2373, '440883', '吴川市', 239, 0, 0, 'Wuchuan Shi', 'WCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2374, '440901', '市辖区', 240, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2375, '440902', '茂南区', 240, 0, 0, 'Maonan Qu', 'MNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2376, '440903', '茂港区', 240, 0, 0, 'Maogang Qu', 'MGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2377, '440923', '电白县', 240, 0, 0, 'Dianbai Xian', 'DBI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2378, '440981', '高州市', 240, 0, 0, 'Gaozhou Shi', 'GZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2379, '440982', '化州市', 240, 0, 0, 'Huazhou Shi', 'HZY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2380, '440983', '信宜市', 240, 0, 0, 'Xinyi Shi', 'XYY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2381, '441201', '市辖区', 241, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2382, '441202', '端州区', 241, 0, 0, 'Duanzhou Qu', 'DZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2383, '441203', '鼎湖区', 241, 0, 0, 'Dinghu Qu', 'DGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2384, '441223', '广宁县', 241, 0, 0, 'Guangning Xian', 'GNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2385, '441224', '怀集县', 241, 0, 0, 'Huaiji Xian', 'HJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2386, '441225', '封开县', 241, 0, 0, 'Fengkai Xian', 'FKX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2387, '441226', '德庆县', 241, 0, 0, 'Deqing Xian', 'DQY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2388, '441283', '高要市', 241, 0, 0, 'Gaoyao Xian', 'GYY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2389, '441284', '四会市', 241, 0, 0, 'Sihui Shi', 'SHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2390, '441301', '市辖区', 242, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2391, '441302', '惠城区', 242, 0, 0, 'Huicheng Qu', 'HCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2392, '441303', '惠阳区', 242, 0, 0, 'Huiyang Shi', 'HUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2393, '441322', '博罗县', 242, 0, 0, 'Boluo Xian', 'BOL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2394, '441323', '惠东县', 242, 0, 0, 'Huidong Xian', 'HID');
commit;
prompt 1400 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2395, '441324', '龙门县', 242, 0, 0, 'Longmen Xian', 'LMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2396, '441401', '市辖区', 243, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2397, '441402', '梅江区', 243, 0, 0, 'Meijiang Qu', 'MJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2398, '441421', '梅县', 243, 0, 0, 'Mei Xian', 'MEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2399, '441422', '大埔县', 243, 0, 0, 'Dabu Xian', 'DBX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2400, '441423', '丰顺县', 243, 0, 0, 'Fengshun Xian', 'FES');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2401, '441424', '五华县', 243, 0, 0, 'Wuhua Xian', 'WHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2402, '441426', '平远县', 243, 0, 0, 'Pingyuan Xian', 'PYY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2403, '441427', '蕉岭县', 243, 0, 0, 'Jiaoling Xian', 'JOL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2404, '441481', '兴宁市', 243, 0, 0, 'Xingning Shi', 'XNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2406, '441502', '城区', 244, 0, 0, 'Chengqu', 'CQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2407, '441521', '海丰县', 244, 0, 0, 'Haifeng Xian', 'HIF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2408, '441523', '陆河县', 244, 0, 0, 'Luhe Xian', 'LHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2410, '441601', '市辖区', 245, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2411, '441602', '源城区', 245, 0, 0, 'Yuancheng Qu', 'YCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2412, '441621', '紫金县', 245, 0, 0, 'Zijin Xian', 'ZJY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2414, '441623', '连平县', 245, 0, 0, 'Lianping Xian', 'LNP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2415, '441624', '和平县', 245, 0, 0, 'Heping Xian', 'HPY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2416, '441625', '东源县', 245, 0, 0, 'Dongyuan Xian', 'DYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2418, '441702', '江城区', 246, 0, 0, 'Jiangcheng Qu', 'JCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2419, '441721', '阳西县', 246, 0, 0, 'Yangxi Xian', 'YXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2420, '441723', '阳东县', 246, 0, 0, 'Yangdong Xian', 'YGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2422, '441801', '市辖区', 247, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2423, '441802', '清城区', 247, 0, 0, 'Qingcheng Qu', 'QCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2424, '441821', '佛冈县', 247, 0, 0, 'Fogang Xian', 'FGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2428, '441827', '清新县', 247, 0, 0, 'Qingxin Xian', 'QGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2429, '441881', '英德市', 247, 0, 0, 'Yingde Shi', 'YDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2430, '441882', '连州市', 247, 0, 0, 'Lianzhou Shi', 'LZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2431, '445101', '市辖区', 250, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2432, '445102', '湘桥区', 250, 0, 0, 'Xiangqiao Qu', 'XQO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2434, '445122', '饶平县', 250, 0, 0, 'Raoping Xian', 'RPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2435, '445201', '市辖区', 251, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2436, '445202', '榕城区', 251, 0, 0, 'Rongcheng Qu', 'RCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2438, '445222', '揭西县', 251, 0, 0, 'Jiexi Xian', 'JEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2439, '445224', '惠来县', 251, 0, 0, 'Huilai Xian', 'HLY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2440, '445281', '普宁市', 251, 0, 0, 'Puning Shi', 'PNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2442, '445302', '云城区', 252, 0, 0, 'Yuncheng Qu', 'YYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2444, '445322', '郁南县', 252, 0, 0, 'Yunan Xian', 'YNK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2446, '445381', '罗定市', 252, 0, 0, 'Luoding Shi', 'LUO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2447, '450101', '市辖区', 253, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2450, '450105', '江南区', 253, 0, 0, 'Jiangnan Qu', 'JNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2451, '450107', '西乡塘区', 253, 0, 0, 'Xixiangtang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2453, '450109', '邕宁区', 253, 0, 0, 'Yongning Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2454, '450122', '武鸣县', 253, 0, 0, 'Wuming Xian', 'WMG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2455, '450123', '隆安县', 253, 0, 0, 'Long,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2458, '450126', '宾阳县', 253, 0, 0, 'Binyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2459, '450127', '横县', 253, 0, 0, 'Heng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2460, '450201', '市辖区', 254, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2463, '450204', '柳南区', 254, 0, 0, 'Liunan Qu', 'LNU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2464, '450205', '柳北区', 254, 0, 0, 'Liubei Qu', 'LBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2466, '450222', '柳城县', 254, 0, 0, 'Liucheng Xian', 'LCB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2468, '450224', '融安县', 254, 0, 0, 'Rong,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2471, '450301', '市辖区', 255, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2472, '450302', '秀峰区', 255, 0, 0, 'Xiufeng Qu', 'XUF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2474, '450304', '象山区', 255, 0, 0, 'Xiangshan Qu', 'XSK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2475, '450305', '七星区', 255, 0, 0, 'Qixing Qu', 'QXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2476, '450311', '雁山区', 255, 0, 0, 'Yanshan Qu', 'YSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2479, '450323', '灵川县', 255, 0, 0, 'Lingchuan Xian', 'LCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2480, '450324', '全州县', 255, 0, 0, 'Quanzhou Xian', 'QZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2483, '450327', '灌阳县', 255, 0, 0, 'Guanyang Xian', 'GNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2485, '450329', '资源县', 255, 0, 0, 'Ziyuan Xian', 'ZYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2486, '450330', '平乐县', 255, 0, 0, 'Pingle Xian', 'PLE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2487, '450331', '荔蒲县', 255, 0, 0, 'Lipu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2490, '450403', '万秀区', 256, 0, 0, 'Wanxiu Qu', 'WXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2491, '450404', '蝶山区', 256, 0, 0, 'Dieshan Qu', 'DES');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2492, '450405', '长洲区', 256, 0, 0, 'Changzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2494, '450422', '藤县', 256, 0, 0, 'Teng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2495, '450423', '蒙山县', 256, 0, 0, 'Mengshan Xian', 'MSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2498, '450502', '海城区', 257, 0, 0, 'Haicheng Qu', 'HCB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2499, '450503', '银海区', 257, 0, 0, 'Yinhai Qu', 'YHB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2502, '450601', '市辖区', 258, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2503, '450602', '港口区', 258, 0, 0, 'Gangkou Qu', 'GKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2504, '450603', '防城区', 258, 0, 0, 'Fangcheng Qu', 'FCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2506, '450681', '东兴市', 258, 0, 0, 'Dongxing Shi', 'DOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2507, '450701', '市辖区', 259, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2510, '450721', '灵山县', 259, 0, 0, 'Lingshan Xian', 'LSB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2511, '450722', '浦北县', 259, 0, 0, 'Pubei Xian', 'PBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2512, '450801', '市辖区', 260, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2515, '450804', '覃塘区', 260, 0, 0, 'Tantang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2516, '450821', '平南县', 260, 0, 0, 'Pingnan Xian', 'PNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2518, '450901', '市辖区', 261, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2519, '450902', '玉州区', 261, 0, 0, 'Yuzhou Qu', 'YZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2520, '450921', '容县', 261, 0, 0, 'Rong Xian', 'ROG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2523, '450924', '兴业县', 261, 0, 0, 'Xingye Xian', 'XGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2524, '450981', '北流市', 261, 0, 0, 'Beiliu Shi', 'BLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2526, '451002', '右江区', 262, 0, 0, 'Youjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2528, '451022', '田东县', 262, 0, 0, 'Tiandong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2529, '451023', '平果县', 262, 0, 0, 'Pingguo Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2530, '451024', '德保县', 262, 0, 0, 'Debao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2532, '451026', '那坡县', 262, 0, 0, 'Napo Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2533, '451027', '凌云县', 262, 0, 0, 'Lingyun Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2535, '451029', '田林县', 262, 0, 0, 'Tianlin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2536, '451030', '西林县', 262, 0, 0, 'Xilin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2538, '451101', '市辖区', 263, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2539, '451102', '八步区', 263, 0, 0, 'Babu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2540, '451121', '昭平县', 263, 0, 0, 'Zhaoping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2541, '451122', '钟山县', 263, 0, 0, 'Zhongshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2543, '451201', '市辖区', 264, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2544, '451202', '金城江区', 264, 0, 0, 'Jinchengjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2545, '451221', '南丹县', 264, 0, 0, 'Nandan Xian', '2');
commit;
prompt 1500 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2546, '451222', '天峨县', 264, 0, 0, 'Tian,e Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2547, '451223', '凤山县', 264, 0, 0, 'Fengshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2548, '451224', '东兰县', 264, 0, 0, 'Donglan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2550, '451226', '环江毛南族自治县', 264, 0, 0, 'Huanjiang Maonanzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2552, '451228', '都安瑶族自治县', 264, 0, 0, 'Du,an Yaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2553, '451229', '大化瑶族自治县', 264, 0, 0, 'Dahua Yaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2555, '451301', '市辖区', 265, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2556, '451302', '兴宾区', 265, 0, 0, 'Xingbin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2557, '451321', '忻城县', 265, 0, 0, 'Xincheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2558, '451322', '象州县', 265, 0, 0, 'Xiangzhou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2560, '451324', '金秀瑶族自治县', 265, 0, 0, 'Jinxiu Yaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2336, '440307', '龙岗区', 234, 0, 0, 'Longgang Qu', 'LGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2562, '451401', '市辖区', 266, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2563, '451402', '江洲区', 266, 0, 0, 'Jiangzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2564, '451421', '扶绥县', 266, 0, 0, 'Fusui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2566, '451423', '龙州县', 266, 0, 0, 'Longzhou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2567, '451424', '大新县', 266, 0, 0, 'Daxin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2568, '451425', '天等县', 266, 0, 0, 'Tiandeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (236, '440500', '汕头市', 20, 0, 0, 'Shantou Shi', 'SWA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2569, '451481', '凭祥市', 266, 0, 0, 'Pingxiang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2570, '460101', '市辖区', 267, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2571, '460105', '秀英区', 267, 0, 0, 'Xiuying Qu', 'XYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2572, '460106', '龙华区', 267, 0, 0, 'LongHua Qu', 'LH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2573, '460107', '琼山区', 267, 0, 0, 'QiongShan Qu', 'QS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2574, '460108', '美兰区', 267, 0, 0, 'MeiLan Qu', 'ML');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2575, '460201', '市辖区', 268, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2576, '469001', '五指山市', 269, 0, 0, 'Wuzhishan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2577, '469002', '琼海市', 269, 0, 0, 'Qionghai Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2578, '469003', '儋州市', 269, 0, 0, 'Danzhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2579, '469005', '文昌市', 269, 0, 0, 'Wenchang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2580, '469006', '万宁市', 269, 0, 0, 'Wanning Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2581, '469007', '东方市', 269, 0, 0, 'Dongfang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2582, '469021', '定安县', 269, 0, 0, 'Ding,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2583, '469022', '屯昌县', 269, 0, 0, 'Tunchang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2584, '469023', '澄迈县', 269, 0, 0, 'Chengmai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2585, '469024', '临高县', 269, 0, 0, 'Lingao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2586, '469025', '白沙黎族自治县', 269, 0, 0, 'Baisha Lizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2588, '469027', '乐东黎族自治县', 269, 0, 0, 'Ledong Lizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2589, '469028', '陵水黎族自治县', 269, 0, 0, 'Lingshui Lizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2590, '469029', '保亭黎族苗族自治县', 269, 0, 0, 'Baoting Lizu Miaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2591, '469030', '琼中黎族苗族自治县', 269, 0, 0, 'Qiongzhong Lizu Miaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2592, '469031', '西沙群岛', 269, 0, 0, 'Xisha Qundao', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2593, '469032', '南沙群岛', 269, 0, 0, 'Nansha Qundao', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2594, '469033', '中沙群岛的岛礁及其海域', 269, 0, 0, 'Zhongsha Qundao de Daojiao Jiqi Haiyu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2595, '500101', '万州区', 270, 0, 0, 'Wanzhou Qu', 'WZO ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2596, '500102', '涪陵区', 270, 0, 0, 'Fuling Qu', 'FLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2597, '500103', '渝中区', 270, 0, 0, 'Yuzhong Qu', 'YZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2599, '500105', '江北区', 270, 0, 0, 'Jiangbei Qu', 'JBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2600, '500106', '沙坪坝区', 270, 0, 0, 'Shapingba Qu', 'SPB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2601, '500107', '九龙坡区', 270, 0, 0, 'Jiulongpo Qu', 'JLP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2602, '500108', '南岸区', 270, 0, 0, 'Nan,an Qu', 'NAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2603, '500109', '北碚区', 270, 0, 0, 'Beibei Qu', 'BBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2604, '500110', '万盛区', 270, 0, 0, 'Wansheng Qu', 'WSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2605, '500111', '双桥区', 270, 0, 0, 'Shuangqiao Qu', 'SQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2606, '500112', '渝北区', 270, 0, 0, 'Yubei Qu', 'YBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2607, '500113', '巴南区', 270, 0, 0, 'Banan Qu', 'BNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2608, '500114', '黔江区', 270, 0, 0, 'Qianjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2609, '500115', '长寿区', 270, 0, 0, 'Changshou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2610, '500222', '綦江县', 271, 0, 0, 'Qijiang Xian', 'QJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2611, '500223', '潼南县', 271, 0, 0, 'Tongnan Xian', 'TNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2612, '500224', '铜梁县', 271, 0, 0, 'Tongliang Xian', 'TGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2613, '500225', '大足县', 271, 0, 0, 'Dazu Xian', 'DZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2614, '500226', '荣昌县', 271, 0, 0, 'Rongchang Xian', 'RGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2615, '500227', '璧山县', 271, 0, 0, 'Bishan Xian', 'BSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2616, '500228', '梁平县', 271, 0, 0, 'Liangping Xian', 'LGP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2617, '500229', '城口县', 271, 0, 0, 'Chengkou Xian', 'CKO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2618, '500230', '丰都县', 271, 0, 0, 'Fengdu Xian', 'FDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2619, '500231', '垫江县', 271, 0, 0, 'Dianjiang Xian', 'DJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2620, '500232', '武隆县', 271, 0, 0, 'Wulong Xian', 'WLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2621, '500233', '忠县', 271, 0, 0, 'Zhong Xian', 'ZHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2622, '500234', '开县', 271, 0, 0, 'Kai Xian', 'KAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2623, '500235', '云阳县', 271, 0, 0, 'Yunyang Xian', 'YNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2624, '500236', '奉节县', 271, 0, 0, 'Fengjie Xian', 'FJE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2625, '500237', '巫山县', 271, 0, 0, 'Wushan Xian', 'WSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2626, '500238', '巫溪县', 271, 0, 0, 'Wuxi Xian', 'WXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2627, '500240', '石柱土家族自治县', 271, 0, 0, 'Shizhu Tujiazu Zizhixian', 'SZY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2628, '500241', '秀山土家族苗族自治县', 271, 0, 0, 'Xiushan Tujiazu Miaozu Zizhixian', 'XUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2630, '500243', '彭水苗族土家族自治县', 271, 0, 0, 'Pengshui Miaozu Tujiazu Zizhixian', 'PSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2631, '500116', '江津区', 272, 0, 0, 'Jiangjin Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2632, '500117', '合川区', 272, 0, 0, 'Hechuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2633, '500118', '永川区', 272, 0, 0, 'Yongchuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2634, '500119', '南川区', 272, 0, 0, 'Nanchuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2635, '510101', '市辖区', 273, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2636, '510104', '锦江区', 273, 0, 0, 'Jinjiang Qu', 'JJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2637, '510105', '青羊区', 273, 0, 0, 'Qingyang Qu', 'QYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2638, '510106', '金牛区', 273, 0, 0, 'Jinniu Qu', 'JNU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2639, '510107', '武侯区', 273, 0, 0, 'Wuhou Qu', 'WHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2640, '510108', '成华区', 273, 0, 0, 'Chenghua Qu', 'CHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2641, '510112', '龙泉驿区', 273, 0, 0, 'Longquanyi Qu', 'LQY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2642, '510113', '青白江区', 273, 0, 0, 'Qingbaijiang Qu', 'QBJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2643, '510114', '新都区', 273, 0, 0, 'Xindu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2644, '510115', '温江区', 273, 0, 0, 'Wenjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2646, '510122', '双流县', 273, 0, 0, 'Shuangliu Xian', 'SLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2647, '510124', '郫县', 273, 0, 0, 'Pi Xian', 'PIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2649, '510131', '蒲江县', 273, 0, 0, 'Pujiang Xian', 'PJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2652, '510182', '彭州市', 273, 0, 0, 'Pengzhou Shi', 'PZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2653, '510183', '邛崃市', 273, 0, 0, 'Qionglai Shi', 'QLA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2655, '510301', '市辖区', 274, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2657, '510303', '贡井区', 274, 0, 0, 'Gongjing Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2658, '510304', '大安区', 274, 0, 0, 'Da,an Qu', 'DAQ');
commit;
prompt 1600 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2659, '510311', '沿滩区', 274, 0, 0, 'Yantan Qu', 'YTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2660, '510321', '荣县', 274, 0, 0, 'Rong Xian', 'RGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2662, '510401', '市辖区', 275, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2664, '510403', '西区', 275, 0, 0, 'Xi Qu', 'XIQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2665, '510411', '仁和区', 275, 0, 0, 'Renhe Qu', 'RHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2667, '510422', '盐边县', 275, 0, 0, 'Yanbian Xian', 'YBN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2668, '510501', '市辖区', 276, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2671, '510504', '龙马潭区', 276, 0, 0, 'Longmatan Qu', 'LMT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2672, '510521', '泸县', 276, 0, 0, 'Lu Xian', 'LUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2673, '510522', '合江县', 276, 0, 0, 'Hejiang Xian', 'HEJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2676, '510601', '市辖区', 277, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2677, '510603', '旌阳区', 277, 0, 0, 'Jingyang Qu', 'JYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2679, '510626', '罗江县', 277, 0, 0, 'Luojiang Xian', 'LOJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2681, '510682', '什邡市', 277, 0, 0, 'Shifang Shi', 'SFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2683, '510701', '市辖区', 278, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2684, '510703', '涪城区', 278, 0, 0, 'Fucheng Qu', 'FCM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2687, '510723', '盐亭县', 278, 0, 0, 'Yanting Xian', 'YTC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2688, '510724', '安县', 278, 0, 0, 'An Xian', 'AXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2689, '510725', '梓潼县', 278, 0, 0, 'Zitong Xian', 'ZTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2692, '510781', '江油市', 278, 0, 0, 'Jiangyou Shi', 'JYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2693, '510801', '市辖区', 279, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2694, '511002', '市中区', 279, 0, 0, 'Shizhong Qu', 'SZM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2695, '510811', '元坝区', 279, 0, 0, 'Yuanba Qu', 'YBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2698, '510822', '青川县', 279, 0, 0, 'Qingchuan Xian', 'QCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2699, '510823', '剑阁县', 279, 0, 0, 'Jiange Xian', 'JGE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2701, '510901', '市辖区', 280, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2702, '510903', '船山区', 280, 0, 0, 'Chuanshan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2703, '510904', '安居区', 280, 0, 0, 'Anju Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2706, '510923', '大英县', 280, 0, 0, 'Daying Xian', 'DAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2707, '511001', '市辖区', 281, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2709, '511011', '东兴区', 281, 0, 0, 'Dongxing Qu', 'DXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2710, '511024', '威远县', 281, 0, 0, 'Weiyuan Xian', 'WYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2713, '511101', '市辖区', 282, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2714, '511102', '市中区', 282, 0, 0, 'Shizhong Qu', 'SZP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2715, '511111', '沙湾区', 282, 0, 0, 'Shawan Qu', 'SWN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2717, '511113', '金口河区', 282, 0, 0, 'Jinkouhe Qu', 'JKH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2719, '511124', '井研县', 282, 0, 0, 'Jingyan Xian', 'JYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2721, '511129', '沐川县', 282, 0, 0, 'Muchuan Xian', 'MCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2724, '511181', '峨眉山市', 282, 0, 0, 'Emeishan Shi', 'EMS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2725, '511301', '市辖区', 283, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2726, '511302', '顺庆区', 283, 0, 0, 'Shunqing Xian', 'SQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2728, '511304', '嘉陵区', 283, 0, 0, 'Jialing Qu', 'JLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2729, '511321', '南部县', 283, 0, 0, 'Nanbu Xian', 'NBU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2732, '511324', '仪陇县', 283, 0, 0, 'Yilong Xian', 'YLC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2733, '511325', '西充县', 283, 0, 0, 'Xichong Xian', 'XCO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2736, '511402', '东坡区', 284, 0, 0, 'Dongpo Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2737, '511421', '仁寿县', 284, 0, 0, 'Renshou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2738, '511422', '彭山县', 284, 0, 0, 'Pengshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2741, '511425', '青神县', 284, 0, 0, 'Qingshen Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2742, '511501', '市辖区', 285, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2744, '511521', '宜宾县', 285, 0, 0, 'Yibin Xian', 'YBX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2745, '511522', '南溪县', 285, 0, 0, 'Nanxi Xian', 'NNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2748, '511525', '高县', 285, 0, 0, 'Gao Xian', 'GAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2749, '511526', '珙县', 285, 0, 0, 'Gong Xian', 'GOG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2751, '511528', '兴文县', 285, 0, 0, 'Xingwen Xian', 'XWC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2753, '511601', '市辖区', 286, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2754, '511602', '广安区', 286, 0, 0, 'Guang,an Qu', 'GAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2755, '511621', '岳池县', 286, 0, 0, 'Yuechi Xian', 'YCC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2759, '511701', '市辖区', 287, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2761, '511721', '达县', 287, 0, 0, 'Da Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2762, '511722', '宣汉县', 287, 0, 0, 'Xuanhan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2765, '511725', '渠县', 287, 0, 0, 'Qu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2766, '511781', '万源市', 287, 0, 0, 'Wanyuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2767, '511801', '市辖区', 288, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2768, '511802', '雨城区', 288, 0, 0, 'Yucheg Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2770, '511822', '荥经县', 288, 0, 0, 'Yingjing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2772, '511824', '石棉县', 288, 0, 0, 'Shimian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2774, '511826', '芦山县', 288, 0, 0, 'Lushan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2776, '511901', '市辖区', 289, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2778, '511921', '通江县', 289, 0, 0, 'Tongjiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2779, '511922', '南江县', 289, 0, 0, 'Nanjiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2782, '512002', '雁江区', 290, 0, 0, 'Yanjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2783, '512021', '安岳县', 290, 0, 0, 'Anyue Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2784, '512022', '乐至县', 290, 0, 0, 'Lezhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2786, '513221', '汶川县', 291, 0, 0, 'Wenchuan Xian', 'WNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2788, '513223', '茂县', 291, 0, 0, 'Mao Xian', 'MAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2789, '513224', '松潘县', 291, 0, 0, 'Songpan Xian', 'SOP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2792, '513227', '小金县', 291, 0, 0, 'Xiaojin Xian', 'XJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2793, '513228', '黑水县', 291, 0, 0, 'Heishui Xian', 'HIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2796, '513231', '阿坝县', 291, 0, 0, 'Aba(Ngawa) Xian', 'ABX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2797, '513232', '若尔盖县', 291, 0, 0, 'ZoigeXian', 'ZOI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2799, '513321', '康定县', 292, 0, 0, 'Kangding(Dardo) Xian', 'KDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2801, '513323', '丹巴县', 292, 0, 0, 'Danba(Rongzhag) Xian', 'DBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2803, '513325', '雅江县', 292, 0, 0, 'Yajiang(Nyagquka) Xian', 'YAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2804, '513326', '道孚县', 292, 0, 0, 'Dawu Xian', 'DAW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (248, '441900', '东莞市', 20, 0, 0, 'Dongguan Shi', 'DGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2805, '513327', '炉霍县', 292, 0, 0, 'Luhuo(Zhaggo) Xian', 'LUH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2806, '513328', '甘孜县', 292, 0, 0, 'Garze Xian', 'GRZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2807, '513329', '新龙县', 292, 0, 0, 'Xinlong(Nyagrong) Xian', 'XLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2808, '513330', '德格县', 292, 0, 0, 'DegeXian', 'DEG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2809, '513331', '白玉县', 292, 0, 0, 'Baiyu Xian', 'BYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2810, '513332', '石渠县', 292, 0, 0, 'Serxv Xian', 'SER');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2811, '513333', '色达县', 292, 0, 0, 'Sertar Xian', 'STX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2812, '513334', '理塘县', 292, 0, 0, 'Litang Xian', 'LIT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2813, '513335', '巴塘县', 292, 0, 0, 'Batang Xian', 'BTC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2814, '513336', '乡城县', 292, 0, 0, 'Xiangcheng(Qagcheng) Xian', 'XCC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2815, '513337', '稻城县', 292, 0, 0, 'Daocheng(Dabba) Xian', 'DCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2816, '513338', '得荣县', 292, 0, 0, 'Derong Xian', 'DER');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2817, '513401', '西昌市', 293, 0, 0, 'Xichang Shi', 'XCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2818, '513422', '木里藏族自治县', 293, 0, 0, 'Muli Zangzu Zizhixian', 'MLI');
commit;
prompt 1700 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2819, '513423', '盐源县', 293, 0, 0, 'Yanyuan Xian', 'YYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2820, '513424', '德昌县', 293, 0, 0, 'Dechang Xian', 'DEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2821, '513425', '会理县', 293, 0, 0, 'Huili Xian', 'HLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2822, '513426', '会东县', 293, 0, 0, 'Huidong Xian', 'HDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2823, '513427', '宁南县', 293, 0, 0, 'Ningnan Xian', 'NIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2824, '513428', '普格县', 293, 0, 0, 'Puge Xian', 'PGE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2825, '513429', '布拖县', 293, 0, 0, 'Butuo Xian', 'BTO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2826, '513430', '金阳县', 293, 0, 0, 'Jinyang Xian', 'JYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2827, '513431', '昭觉县', 293, 0, 0, 'Zhaojue Xian', 'ZJE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2828, '513432', '喜德县', 293, 0, 0, 'Xide Xian', 'XDE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2829, '513433', '冕宁县', 293, 0, 0, 'Mianning Xian', 'MNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2830, '513434', '越西县', 293, 0, 0, 'Yuexi Xian', 'YXC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2831, '513435', '甘洛县', 293, 0, 0, 'Ganluo Xian', 'GLO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2832, '513436', '美姑县', 293, 0, 0, 'Meigu Xian', 'MEG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2833, '513437', '雷波县', 293, 0, 0, 'Leibo Xian', 'LBX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2834, '520101', '市辖区', 294, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2835, '520102', '南明区', 294, 0, 0, 'Nanming Qu', 'NMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2836, '520103', '云岩区', 294, 0, 0, 'Yunyan Qu', 'YYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2837, '520111', '花溪区', 294, 0, 0, 'Huaxi Qu', 'HXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2838, '520112', '乌当区', 294, 0, 0, 'Wudang Qu', 'WDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2839, '520113', '白云区', 294, 0, 0, 'Baiyun Qu', 'BYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2840, '520114', '小河区', 294, 0, 0, 'Xiaohe Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2841, '520121', '开阳县', 294, 0, 0, 'Kaiyang Xian', 'KYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2842, '520122', '息烽县', 294, 0, 0, 'Xifeng Xian', 'XFX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2843, '520123', '修文县', 294, 0, 0, 'Xiuwen Xian', 'XWX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2844, '520181', '清镇市', 294, 0, 0, 'Qingzhen Shi', 'QZN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2845, '520201', '钟山区', 295, 0, 0, 'Zhongshan Qu', 'ZSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2846, '520203', '六枝特区', 295, 0, 0, 'Liuzhi Tequ', 'LZT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2847, '520221', '水城县', 295, 0, 0, 'Shuicheng Xian', 'SUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2848, '520222', '盘县', 295, 0, 0, 'Pan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2849, '520301', '市辖区', 296, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2850, '520302', '红花岗区', 296, 0, 0, 'Honghuagang Qu', 'HHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2851, '520303', '汇川区', 296, 0, 0, 'Huichuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2852, '520321', '遵义县', 296, 0, 0, 'Zunyi Xian', 'ZYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2853, '520322', '桐梓县', 296, 0, 0, 'Tongzi Xian', 'TZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2854, '520323', '绥阳县', 296, 0, 0, 'Suiyang Xian', 'SUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2855, '520324', '正安县', 296, 0, 0, 'Zhengan Xan', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2856, '520325', '道真仡佬族苗族自治县', 296, 0, 0, 'Daozhen Gelaozu Miaozu Zizhixian', 'DZN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2857, '520326', '务川仡佬族苗族自治县', 296, 0, 0, 'Wuchuan Gelaozu Miaozu Zizhixian', 'WCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2858, '520327', '凤冈县', 296, 0, 0, 'Fenggang Xian', 'FGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2859, '520328', '湄潭县', 296, 0, 0, 'Meitan Xian', 'MTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2860, '520329', '余庆县', 296, 0, 0, 'Yuqing Xian', 'YUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2861, '520330', '习水县', 296, 0, 0, 'Xishui Xian', 'XSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2862, '520381', '赤水市', 296, 0, 0, 'Chishui Shi', 'CSS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2863, '520382', '仁怀市', 296, 0, 0, 'Renhuai Shi', 'RHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2864, '520401', '市辖区', 297, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2865, '520402', '西秀区', 297, 0, 0, 'Xixiu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2866, '520421', '平坝县', 297, 0, 0, 'Pingba Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2867, '520422', '普定县', 297, 0, 0, 'Puding Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2869, '520424', '关岭布依族苗族自治县', 297, 0, 0, 'Guanling Buyeizu Miaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2870, '520425', '紫云苗族布依族自治县', 297, 0, 0, 'Ziyun Miaozu Buyeizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2871, '522201', '铜仁市', 298, 0, 0, 'Tongren Shi', 'TRS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2872, '522222', '江口县', 298, 0, 0, 'Jiangkou Xian', 'JGK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2873, '522223', '玉屏侗族自治县', 298, 0, 0, 'Yuping Dongzu Zizhixian', 'YPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2874, '522224', '石阡县', 298, 0, 0, 'Shiqian Xian', 'SQI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2875, '522225', '思南县', 298, 0, 0, 'Sinan Xian', 'SNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2876, '522226', '印江土家族苗族自治县', 298, 0, 0, 'Yinjiang Tujiazu Miaozu Zizhixian', 'YJY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2877, '522227', '德江县', 298, 0, 0, 'Dejiang Xian', 'DEJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2878, '522228', '沿河土家族自治县', 298, 0, 0, 'Yanhe Tujiazu Zizhixian', 'YHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2880, '522230', '万山特区', 298, 0, 0, 'Wanshan Tequ', 'WAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2881, '522301', '兴义市', 299, 0, 0, 'Xingyi Shi', 'XYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2882, '522322', '兴仁县', 299, 0, 0, 'Xingren Xian', 'XRN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2884, '522324', '晴隆县', 299, 0, 0, 'Qinglong Xian', 'QLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2885, '522325', '贞丰县', 299, 0, 0, 'Zhenfeng Xian', 'ZFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2887, '522327', '册亨县', 299, 0, 0, 'Ceheng Xian', 'CEH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2888, '522328', '安龙县', 299, 0, 0, 'Anlong Xian', 'ALG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2890, '522422', '大方县', 300, 0, 0, 'Dafang Xian', 'DAF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2891, '522423', '黔西县', 300, 0, 0, 'Qianxi Xian', 'QNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2893, '522425', '织金县', 300, 0, 0, 'Zhijin Xian', 'ZJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2894, '522426', '纳雍县', 300, 0, 0, 'Nayong Xian', 'NYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2896, '522428', '赫章县', 300, 0, 0, 'Hezhang Xian', 'HZA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2897, '522601', '凯里市', 301, 0, 0, 'Kaili Shi', 'KLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2898, '522622', '黄平县', 301, 0, 0, 'Huangping Xian', 'HPN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2899, '522623', '施秉县', 301, 0, 0, 'Shibing Xian', 'SBG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2901, '522625', '镇远县', 301, 0, 0, 'Zhenyuan Xian', 'ZYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2902, '522626', '岑巩县', 301, 0, 0, 'Cengong Xian', 'CGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2904, '522628', '锦屏县', 301, 0, 0, 'Jinping Xian', 'JPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2905, '522629', '剑河县', 301, 0, 0, 'Jianhe Xian', 'JHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2907, '522631', '黎平县', 301, 0, 0, 'Liping Xian', 'LIP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2908, '522632', '榕江县', 301, 0, 0, 'Rongjiang Xian', 'RJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2910, '522634', '雷山县', 301, 0, 0, 'Leishan Xian', 'LSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2911, '522635', '麻江县', 301, 0, 0, 'Majiang Xian', 'MAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2912, '522636', '丹寨县', 301, 0, 0, 'Danzhai Xian', 'DZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2914, '522702', '福泉市', 302, 0, 0, 'Fuquan Shi', 'FQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2915, '522722', '荔波县', 302, 0, 0, 'Libo Xian', 'LBO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2917, '522725', '瓮安县', 302, 0, 0, 'Weng,an Xian', 'WGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2918, '522726', '独山县', 302, 0, 0, 'Dushan Xian', 'DSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2919, '522727', '平塘县', 302, 0, 0, 'Pingtang Xian', 'PTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2921, '522729', '长顺县', 302, 0, 0, 'Changshun Xian', 'CSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2922, '522730', '龙里县', 302, 0, 0, 'Longli Xian', 'LLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2924, '522732', '三都水族自治县', 302, 0, 0, 'Sandu Suizu Zizhixian', 'SDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2925, '530101', '市辖区', 303, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2927, '530103', '盘龙区', 303, 0, 0, 'Panlong Qu', 'PLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2928, '530111', '官渡区', 303, 0, 0, 'Guandu Qu', 'GDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2929, '530112', '西山区', 303, 0, 0, 'Xishan Qu', 'XSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2931, '530121', '呈贡县', 303, 0, 0, 'Chenggong Xian', 'CGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2932, '530122', '晋宁县', 303, 0, 0, 'Jinning Xian', 'JND');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2936, '530127', '嵩明县', 303, 0, 0, 'Songming Xian', 'SMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2939, '530181', '安宁市', 303, 0, 0, 'Anning Shi', 'ANG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2940, '530301', '市辖区', 304, 0, 0, 'Shixiaqu', '2');
commit;
prompt 1800 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2941, '530302', '麒麟区', 304, 0, 0, 'Qilin Xian', 'QLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2942, '530321', '马龙县', 304, 0, 0, 'Malong Xian', 'MLO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2943, '530322', '陆良县', 304, 0, 0, 'Luliang Xian', 'LLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2944, '530323', '师宗县', 304, 0, 0, 'Shizong Xian', 'SZD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2946, '530325', '富源县', 304, 0, 0, 'Fuyuan Xian', 'FYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2948, '530328', '沾益县', 304, 0, 0, 'Zhanyi Xian', 'ZYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2950, '530401', '市辖区', 305, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2952, '530421', '江川县', 305, 0, 0, 'Jiangchuan Xian', 'JGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2953, '530422', '澄江县', 305, 0, 0, 'Chengjiang Xian', 'CGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2956, '530425', '易门县', 305, 0, 0, 'Yimen Xian', 'YMD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2960, '530501', '市辖区', 306, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2961, '530502', '隆阳区', 306, 0, 0, 'Longyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2962, '530521', '施甸县', 306, 0, 0, 'Shidian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2963, '530522', '腾冲县', 306, 0, 0, 'Tengchong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2964, '530523', '龙陵县', 306, 0, 0, 'Longling Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2965, '530524', '昌宁县', 306, 0, 0, 'Changning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2966, '530601', '市辖区', 307, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2967, '530602', '昭阳区', 307, 0, 0, 'Zhaoyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2970, '530623', '盐津县', 307, 0, 0, 'Yanjin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2971, '530624', '大关县', 307, 0, 0, 'Daguan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2974, '530627', '镇雄县', 307, 0, 0, 'Zhenxiong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2975, '530628', '彝良县', 307, 0, 0, 'Yiliang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2978, '530701', '市辖区', 308, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2979, '530702', '古城区', 308, 0, 0, 'Gucheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2981, '530722', '永胜县', 308, 0, 0, 'Yongsheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2982, '530723', '华坪县', 308, 0, 0, 'Huaping Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2984, '530801', '市辖区', 309, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2985, '530802', '思茅区', 309, 0, 0, 'Simao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2987, '530822', '墨江哈尼族自治县', 309, 0, 0, 'Mojiang Hanizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2994, '530829', '西盟佤族自治县', 309, 0, 0, 'Ximeng Vazu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2995, '530901', '市辖区', 310, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2996, '530902', '临翔区', 310, 0, 0, 'Linxiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2997, '530921', '凤庆县', 310, 0, 0, 'Fengqing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2998, '530922', '云县', 310, 0, 0, 'Yun Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3000, '530924', '镇康县', 310, 0, 0, 'Zhenkang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3003, '530927', '沧源佤族自治县', 310, 0, 0, 'Cangyuan Vazu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3004, '532301', '楚雄市', 311, 0, 0, 'Chuxiong Shi', 'CXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3006, '532323', '牟定县', 311, 0, 0, 'Mouding Xian', 'MDI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3007, '532324', '南华县', 311, 0, 0, 'Nanhua Xian', 'NHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3009, '532326', '大姚县', 311, 0, 0, 'Dayao Xian', 'DYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3011, '532328', '元谋县', 311, 0, 0, 'Yuanmou Xian', 'YMO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3013, '532331', '禄丰县', 311, 0, 0, 'Lufeng Xian', 'LFX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3015, '532502', '开远市', 312, 0, 0, 'Kaiyuan Shi', 'KYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (431, '130132', '元氏县', 37, 0, 0, 'Yuanshi Xian', 'YSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (451, '130281', '遵化市', 38, 0, 0, 'Zunhua Shi', 'ZNH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (457, '130321', '青龙满族自治县', 39, 0, 0, 'Qinglong Manzu Zizhixian', 'QLM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3018, '532524', '建水县', 312, 0, 0, 'Jianshui Xian', 'JSD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3020, '532526', '弥勒县', 312, 0, 0, 'Mile Xian', 'MIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3021, '532527', '泸西县', 312, 0, 0, 'Luxi Xian', 'LXD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3022, '532528', '元阳县', 312, 0, 0, 'Yuanyang Xian', 'YYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3027, '532621', '文山县', 313, 0, 0, 'Wenshan Xian', 'WES');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3028, '532622', '砚山县', 313, 0, 0, 'Yanshan Xian', 'YSD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3029, '532623', '西畴县', 313, 0, 0, 'Xichou Xian', 'XIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3030, '532624', '麻栗坡县', 313, 0, 0, 'Malipo Xian', 'MLP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3031, '532625', '马关县', 313, 0, 0, 'Maguan Xian', 'MGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3032, '532626', '丘北县', 313, 0, 0, 'Qiubei Xian', 'QBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3034, '532628', '富宁县', 313, 0, 0, 'Funing Xian', 'FND');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3035, '532801', '景洪市', 314, 0, 0, 'Jinghong Shi', 'JHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3036, '532822', '勐海县', 314, 0, 0, 'Menghai Xian', 'MHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3038, '532901', '大理市', 315, 0, 0, 'Dali Shi', 'DLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3040, '532923', '祥云县', 315, 0, 0, 'Xiangyun Xian', 'XYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3041, '532924', '宾川县', 315, 0, 0, 'Binchuan Xian', 'BCD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3042, '532925', '弥渡县', 315, 0, 0, 'Midu Xian', 'MDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3025, '532531', '绿春县', 312, 0, 0, 'Lvchun Xian', 'LCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3043, '532926', '南涧彝族自治县', 315, 0, 0, 'Nanjian Yizu Zizhixian', 'NNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3045, '532928', '永平县', 315, 0, 0, 'Yongping Xian', 'YPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3046, '532929', '云龙县', 315, 0, 0, 'Yunlong Xian', 'YLO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3047, '532930', '洱源县', 315, 0, 0, 'Eryuan Xian', 'EYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3048, '532931', '剑川县', 315, 0, 0, 'Jianchuan Xian', 'JIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3049, '532932', '鹤庆县', 315, 0, 0, 'Heqing Xian', 'HQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3051, '533103', '芒市', 316, 0, 0, 'Luxi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3052, '533122', '梁河县', 316, 0, 0, 'Lianghe Xian', 'LHD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3053, '533123', '盈江县', 316, 0, 0, 'Yingjiang Xian', 'YGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3055, '533321', '泸水县', 317, 0, 0, 'Lushui Xian', 'LSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3056, '533323', '福贡县', 317, 0, 0, 'Fugong Xian', 'FGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3058, '533325', '兰坪白族普米族自治县', 317, 0, 0, 'Lanping Baizu Pumizu Zizhixian', 'LPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3059, '533421', '香格里拉县', 318, 0, 0, 'Xianggelila Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3060, '533422', '德钦县', 318, 0, 0, 'Deqen Xian', 'DQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3061, '533423', '维西傈僳族自治县', 318, 0, 0, 'Weixi Lisuzu Zizhixian', 'WXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3062, '540101', '市辖区', 319, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3063, '540102', '城关区', 319, 0, 0, 'Chengguang Qu', 'CGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3064, '540121', '林周县', 319, 0, 0, 'Lhvnzhub Xian', 'LZB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3065, '540122', '当雄县', 319, 0, 0, 'Damxung Xian', 'DAM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3066, '540123', '尼木县', 319, 0, 0, 'Nyemo Xian', 'NYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3067, '540124', '曲水县', 319, 0, 0, 'Qvxv Xian', 'QUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3068, '540125', '堆龙德庆县', 319, 0, 0, 'Doilungdeqen Xian', 'DOI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3069, '540126', '达孜县', 319, 0, 0, 'Dagze Xian', 'DAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3070, '540127', '墨竹工卡县', 319, 0, 0, 'Maizhokunggar Xian', 'MAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3071, '542121', '昌都县', 320, 0, 0, 'Qamdo Xian', 'QAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3072, '542122', '江达县', 320, 0, 0, 'Jomda Xian', 'JOM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3073, '542123', '贡觉县', 320, 0, 0, 'Konjo Xian', 'KON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3074, '542124', '类乌齐县', 320, 0, 0, 'Riwoqe Xian', 'RIW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3075, '542125', '丁青县', 320, 0, 0, 'Dengqen Xian', 'DEN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3076, '542126', '察雅县', 320, 0, 0, 'Chagyab Xian', 'CHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3077, '542127', '八宿县', 320, 0, 0, 'Baxoi Xian', 'BAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3078, '542128', '左贡县', 320, 0, 0, 'Zogang Xian', 'ZOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3079, '542129', '芒康县', 320, 0, 0, 'Mangkam Xian', 'MAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3080, '542132', '洛隆县', 320, 0, 0, 'Lhorong Xian', 'LHO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3081, '542133', '边坝县', 320, 0, 0, 'Banbar Xian', 'BAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3082, '542221', '乃东县', 321, 0, 0, 'Nedong Xian', 'NED');
commit;
prompt 1900 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3083, '542222', '扎囊县', 321, 0, 0, 'Chanang(Chatang) Xian', 'CNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3084, '542223', '贡嘎县', 321, 0, 0, 'Gonggar Xian', 'GON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3085, '542224', '桑日县', 321, 0, 0, 'Sangri Xian', 'SRI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3086, '542225', '琼结县', 321, 0, 0, 'Qonggyai Xian', 'QON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3087, '542226', '曲松县', 321, 0, 0, 'Qusum Xian', 'QUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3088, '542227', '措美县', 321, 0, 0, 'Comai Xian', 'COM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3089, '542228', '洛扎县', 321, 0, 0, 'Lhozhag Xian', 'LHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3090, '542229', '加查县', 321, 0, 0, 'Gyaca Xian', 'GYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3091, '542231', '隆子县', 321, 0, 0, 'Lhvnze Xian', 'LHZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3092, '542232', '错那县', 321, 0, 0, 'Cona Xian', 'CON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3093, '542233', '浪卡子县', 321, 0, 0, 'Nagarze Xian', 'NAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3094, '542301', '日喀则市', 322, 0, 0, 'Xigaze Shi', 'XIG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3095, '542322', '南木林县', 322, 0, 0, 'Namling Xian', 'NAM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3096, '542323', '江孜县', 322, 0, 0, 'Gyangze Xian', 'GYZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3097, '542324', '定日县', 322, 0, 0, 'Tingri Xian', 'TIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3098, '542325', '萨迦县', 322, 0, 0, 'Sa,gya Xian', 'SGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3099, '542326', '拉孜县', 322, 0, 0, 'Lhaze Xian', 'LAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3100, '542327', '昂仁县', 322, 0, 0, 'Ngamring Xian', 'NGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3101, '542328', '谢通门县', 322, 0, 0, 'Xaitongmoin Xian', 'XTM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3102, '542329', '白朗县', 322, 0, 0, 'Bainang Xian', 'BAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3104, '542331', '康马县', 322, 0, 0, 'Kangmar Xian', 'KAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3105, '542332', '定结县', 322, 0, 0, 'Dinggye Xian', 'DIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3107, '542334', '亚东县', 322, 0, 0, 'Yadong(Chomo) Xian', 'YDZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3109, '542336', '聂拉木县', 322, 0, 0, 'Nyalam Xian', 'NYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3110, '542337', '萨嘎县', 322, 0, 0, 'Saga Xian', 'SAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3111, '542338', '岗巴县', 322, 0, 0, 'Gamba Xian', 'GAM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3113, '542422', '嘉黎县', 323, 0, 0, 'Lhari Xian', 'LHR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3114, '542423', '比如县', 323, 0, 0, 'Biru Xian', 'BRU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3115, '542424', '聂荣县', 323, 0, 0, 'Nyainrong Xian', 'NRO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3117, '542426', '申扎县', 323, 0, 0, 'Xainza Xian', 'XZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3118, '542427', '索县', 323, 0, 0, 'Sog Xian', 'SOG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3120, '542429', '巴青县', 323, 0, 0, 'Baqen Xian', 'BQE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3121, '542430', '尼玛县', 323, 0, 0, 'Nyima Xian', 'NYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3122, '542521', '普兰县', 324, 0, 0, 'Burang Xian', 'BUR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3124, '542523', '噶尔县', 324, 0, 0, 'Gar Xian', 'GAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3125, '542524', '日土县', 324, 0, 0, 'Rutog Xian', 'RUT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3126, '542525', '革吉县', 324, 0, 0, 'Ge,gyai Xian', 'GEG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3128, '542527', '措勤县', 324, 0, 0, 'Coqen Xian', 'COQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3129, '542621', '林芝县', 325, 0, 0, 'Nyingchi Xian', 'NYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3131, '542623', '米林县', 325, 0, 0, 'Mainling Xian', 'MAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3132, '542624', '墨脱县', 325, 0, 0, 'Metog Xian', 'MET');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3134, '542626', '察隅县', 325, 0, 0, 'Zayv Xian', 'ZAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3135, '542627', '朗县', 325, 0, 0, 'Nang Xian', 'NGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3136, '610101', '市辖区', 326, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3137, '610102', '新城区', 326, 0, 0, 'Xincheng Qu', 'XCK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3138, '610103', '碑林区', 326, 0, 0, 'Beilin Qu', 'BLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3139, '610104', '莲湖区', 326, 0, 0, 'Lianhu Qu', 'LHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3141, '610112', '未央区', 326, 0, 0, 'Weiyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3142, '610113', '雁塔区', 326, 0, 0, 'Yanta Qu', 'YTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3143, '610114', '阎良区', 326, 0, 0, 'Yanliang Qu', 'YLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3145, '610116', '长安区', 326, 0, 0, 'Changan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3146, '610122', '蓝田县', 326, 0, 0, 'Lantian Xian', 'LNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3147, '610124', '周至县', 326, 0, 0, 'Zhouzhi Xian', 'ZOZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3149, '610126', '高陵县', 326, 0, 0, 'Gaoling Xian', 'GLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3150, '610201', '市辖区', 327, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3151, '610202', '王益区', 327, 0, 0, 'Wangyi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3152, '610203', '印台区', 327, 0, 0, 'Yintai Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3153, '610204', '耀州区', 327, 0, 0, 'Yaozhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3154, '610222', '宜君县', 327, 0, 0, 'Yijun Xian', 'YJU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3155, '610301', '市辖区', 328, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3157, '610303', '金台区', 328, 0, 0, 'Jintai Qu', 'JTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3158, '610304', '陈仓区', 328, 0, 0, 'Chencang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3159, '610322', '凤翔县', 328, 0, 0, 'Fengxiang Xian', 'FXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3161, '610324', '扶风县', 328, 0, 0, 'Fufeng Xian', 'FFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3162, '610326', '眉县', 328, 0, 0, 'Mei Xian', 'MEI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3163, '610327', '陇县', 328, 0, 0, 'Long Xian', 'LON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3165, '610329', '麟游县', 328, 0, 0, 'Linyou Xian', 'LYP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3166, '610330', '凤县', 328, 0, 0, 'Feng Xian', 'FEG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3167, '610331', '太白县', 328, 0, 0, 'Taibai Xian', 'TBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3168, '610401', '市辖区', 329, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3170, '610403', '杨陵区', 329, 0, 0, 'Yangling Qu', 'YGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3171, '610404', '渭城区', 329, 0, 0, 'Weicheng Qu', 'WIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3172, '610422', '三原县', 329, 0, 0, 'Sanyuan Xian', 'SYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3174, '610424', '乾县', 329, 0, 0, 'Qian Xian', 'QIA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3175, '610425', '礼泉县', 329, 0, 0, 'Liquan Xian', 'LIQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3177, '610427', '彬县', 329, 0, 0, 'Bin Xian', 'BIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3178, '610428', '长武县', 329, 0, 0, 'Changwu Xian', 'CWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3179, '610429', '旬邑县', 329, 0, 0, 'Xunyi Xian', 'XNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3181, '610431', '武功县', 329, 0, 0, 'Wugong Xian', 'WGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3182, '610481', '兴平市', 329, 0, 0, 'Xingping Shi', 'XPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3183, '610501', '市辖区', 330, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3184, '610502', '临渭区', 330, 0, 0, 'Linwei Qu', 'LWE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3186, '610522', '潼关县', 330, 0, 0, 'Tongguan Xian', 'TGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3187, '610523', '大荔县', 330, 0, 0, 'Dali Xian', 'DAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3189, '610525', '澄城县', 330, 0, 0, 'Chengcheng Xian', 'CCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3190, '610526', '蒲城县', 330, 0, 0, 'Pucheng Xian', 'PUC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3192, '610528', '富平县', 330, 0, 0, 'Fuping Xian', 'FPX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3193, '610581', '韩城市', 330, 0, 0, 'Hancheng Shi', 'HCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3195, '610601', '市辖区', 331, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3196, '610602', '宝塔区', 331, 0, 0, 'Baota Qu', 'BTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3197, '610621', '延长县', 331, 0, 0, 'Yanchang Xian', 'YCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3198, '610622', '延川县', 331, 0, 0, 'Yanchuan Xian', 'YCT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3200, '610624', '安塞县', 331, 0, 0, 'Ansai Xian', 'ANS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3201, '610625', '志丹县', 331, 0, 0, 'Zhidan Xian', 'ZDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3203, '610627', '甘泉县', 331, 0, 0, 'Ganquan Xian', 'GQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3204, '610628', '富县', 331, 0, 0, 'Fu Xian', 'FUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3205, '610629', '洛川县', 331, 0, 0, 'Luochuan Xian', 'LCW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3207, '610631', '黄龙县', 331, 0, 0, 'Huanglong Xian', 'HGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3209, '610701', '市辖区', 332, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3210, '610702', '汉台区', 332, 0, 0, 'Hantai Qu', 'HTQ');
commit;
prompt 2000 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3211, '610721', '南郑县', 332, 0, 0, 'Nanzheng Xian', 'NZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3212, '610722', '城固县', 332, 0, 0, 'Chenggu Xian', 'CGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3214, '610724', '西乡县', 332, 0, 0, 'Xixiang Xian', 'XXA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3215, '610725', '勉县', 332, 0, 0, 'Mian Xian', 'MIA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3217, '610727', '略阳县', 332, 0, 0, 'Lueyang Xian', 'LYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3218, '610728', '镇巴县', 332, 0, 0, 'Zhenba Xian', 'ZBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3219, '610729', '留坝县', 332, 0, 0, 'Liuba Xian', 'LBA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3221, '610801', '市辖区', 333, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3223, '610821', '神木县', 333, 0, 0, 'Shenmu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3224, '610822', '府谷县', 333, 0, 0, 'Fugu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3227, '610825', '定边县', 333, 0, 0, 'Dingbian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3228, '610826', '绥德县', 333, 0, 0, 'Suide Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3229, '610827', '米脂县', 333, 0, 0, 'Mizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3232, '610830', '清涧县', 333, 0, 0, 'Qingjian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3233, '610831', '子洲县', 333, 0, 0, 'Zizhou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3235, '610902', '汉滨区', 334, 0, 0, 'Hanbin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (480, '130481', '武安市', 40, 0, 0, 'Wu,an Shi', 'WUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3236, '610921', '汉阴县', 334, 0, 0, 'Hanyin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3237, '610922', '石泉县', 334, 0, 0, 'Shiquan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3239, '610924', '紫阳县', 334, 0, 0, 'Ziyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3240, '610925', '岚皋县', 334, 0, 0, 'Langao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3241, '610926', '平利县', 334, 0, 0, 'Pingli Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3243, '610928', '旬阳县', 334, 0, 0, 'Xunyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3244, '610929', '白河县', 334, 0, 0, 'Baihe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3245, '611001', '市辖区', 335, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3247, '611021', '洛南县', 335, 0, 0, 'Luonan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3248, '611022', '丹凤县', 335, 0, 0, 'Danfeng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3249, '611023', '商南县', 335, 0, 0, 'Shangnan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3251, '611025', '镇安县', 335, 0, 0, 'Zhen,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3252, '611026', '柞水县', 335, 0, 0, 'Zhashui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3253, '620101', '市辖区', 336, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3255, '620103', '七里河区', 336, 0, 0, 'Qilihe Qu', 'QLH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3256, '620104', '西固区', 336, 0, 0, 'Xigu Qu', 'XGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3258, '620111', '红古区', 336, 0, 0, 'Honggu Qu', 'HOG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3259, '620121', '永登县', 336, 0, 0, 'Yongdeng Xian', 'YDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3260, '620122', '皋兰县', 336, 0, 0, 'Gaolan Xian', 'GAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3262, '620201', '市辖区', 337, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3263, '620301', '市辖区', 338, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3264, '620302', '金川区', 338, 0, 0, 'Jinchuan Qu', 'JCU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3266, '620401', '市辖区', 339, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3267, '620402', '白银区', 339, 0, 0, 'Baiyin Qu', 'BYB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3268, '620403', '平川区', 339, 0, 0, 'Pingchuan Qu', 'PCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3270, '620422', '会宁县', 339, 0, 0, 'Huining xian', 'HNI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3271, '620423', '景泰县', 339, 0, 0, 'Jingtai Xian', 'JGT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3272, '620501', '市辖区', 340, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3274, '620502', '秦州区', 340, 0, 0, 'Beidao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3275, '620521', '清水县', 340, 0, 0, 'Qingshui Xian', 'QSG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3276, '620522', '秦安县', 340, 0, 0, 'Qin,an Xian', 'QNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3278, '620524', '武山县', 340, 0, 0, 'Wushan Xian', 'WSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3280, '620601', '市辖区', 341, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3281, '620602', '凉州区', 341, 0, 0, 'Liangzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3282, '620621', '民勤县', 341, 0, 0, 'Minqin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3283, '620622', '古浪县', 341, 0, 0, 'Gulang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3284, '620623', '天祝藏族自治县', 341, 0, 0, 'Tianzhu Zangzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3285, '620701', '市辖区', 342, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3287, '620721', '肃南裕固族自治县', 342, 0, 0, 'Sunan Yugurzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3289, '620723', '临泽县', 342, 0, 0, 'Linze Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3290, '620724', '高台县', 342, 0, 0, 'Gaotai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3291, '620725', '山丹县', 342, 0, 0, 'Shandan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3293, '620802', '崆峒区', 343, 0, 0, 'Kongdong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3294, '620821', '泾川县', 343, 0, 0, 'Jingchuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3295, '620822', '灵台县', 343, 0, 0, 'Lingtai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3297, '620824', '华亭县', 343, 0, 0, 'Huating Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3298, '620825', '庄浪县', 343, 0, 0, 'Zhuanglang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3299, '620826', '静宁县', 343, 0, 0, 'Jingning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3301, '620902', '肃州区', 344, 0, 0, 'Suzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3302, '620921', '金塔县', 344, 0, 0, 'Jinta Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3306, '620981', '玉门市', 344, 0, 0, 'Yumen Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3307, '620982', '敦煌市', 344, 0, 0, 'Dunhuang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3308, '621001', '市辖区', 345, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3309, '621002', '西峰区', 345, 0, 0, 'Xifeng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3310, '621021', '庆城县', 345, 0, 0, 'Qingcheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3311, '621022', '环县', 345, 0, 0, 'Huan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3312, '621023', '华池县', 345, 0, 0, 'Huachi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3314, '621025', '正宁县', 345, 0, 0, 'Zhengning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3315, '621026', '宁县', 345, 0, 0, 'Ning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3316, '621027', '镇原县', 345, 0, 0, 'Zhenyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3318, '621102', '安定区', 346, 0, 0, 'Anding Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3319, '621121', '通渭县', 346, 0, 0, 'Tongwei Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3320, '621122', '陇西县', 346, 0, 0, 'Longxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3322, '621124', '临洮县', 346, 0, 0, 'Lintao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3323, '621125', '漳县', 346, 0, 0, 'Zhang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3324, '621126', '岷县', 346, 0, 0, 'Min Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3325, '621201', '市辖区', 347, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3327, '621221', '成县', 347, 0, 0, 'Cheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3328, '621222', '文县', 347, 0, 0, 'Wen Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3329, '621223', '宕昌县', 347, 0, 0, 'Dangchang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3330, '621224', '康县', 347, 0, 0, 'Kang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3332, '621226', '礼县', 347, 0, 0, 'Li Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3333, '621227', '徽县', 347, 0, 0, 'Hui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3334, '621228', '两当县', 347, 0, 0, 'Liangdang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3335, '622901', '临夏市', 348, 0, 0, 'Linxia Shi', 'LXR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3336, '622921', '临夏县', 348, 0, 0, 'Linxia Xian', 'LXF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3337, '622922', '康乐县', 348, 0, 0, 'Kangle Xian', 'KLE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3338, '622923', '永靖县', 348, 0, 0, 'Yongjing Xian', 'YJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3339, '622924', '广河县', 348, 0, 0, 'Guanghe Xian', 'GHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3340, '622925', '和政县', 348, 0, 0, 'Hezheng Xian', 'HZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3341, '622926', '东乡族自治县', 348, 0, 0, 'Dongxiangzu Zizhixian', 'DXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3342, '622927', '积石山保安族东乡族撒拉族自治县', 348, 0, 0, 'Jishishan Bonanzu Dongxiangzu Salarzu Zizhixian', 'JSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3343, '623001', '合作市', 349, 0, 0, 'Hezuo Shi', 'HEZ');
commit;
prompt 2100 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3344, '623021', '临潭县', 349, 0, 0, 'Lintan Xian', 'LTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3345, '623022', '卓尼县', 349, 0, 0, 'Jone', 'JON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3346, '623023', '舟曲县', 349, 0, 0, 'Zhugqu Xian', 'ZQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3347, '623024', '迭部县', 349, 0, 0, 'Tewo Xian', 'TEW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3348, '623025', '玛曲县', 349, 0, 0, 'Maqu Xian', 'MQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3349, '623026', '碌曲县', 349, 0, 0, 'Luqu Xian', 'LQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (506, '130622', '清苑县', 42, 0, 0, 'Qingyuan Xian', 'QYJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (508, '130624', '阜平县', 42, 0, 0, 'Fuping Xian ', 'FUP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (509, '130625', '徐水县', 42, 0, 0, 'Xushui Xian ', 'XSJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (510, '130626', '定兴县', 42, 0, 0, 'Dingxing Xian ', 'DXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (512, '130628', '高阳县', 42, 0, 0, 'Gaoyang Xian ', 'GAY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (513, '130629', '容城县', 42, 0, 0, 'Rongcheng Xian ', 'RCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (515, '130631', '望都县', 42, 0, 0, 'Wangdu Xian ', 'WDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (516, '130632', '安新县', 42, 0, 0, 'Anxin Xian ', 'AXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (517, '130633', '易县', 42, 0, 0, 'Yi Xian', 'YII');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (519, '130635', '蠡县', 42, 0, 0, 'Li Xian', 'LXJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (520, '130636', '顺平县', 42, 0, 0, 'Shunping Xian ', 'SPI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (521, '130637', '博野县', 42, 0, 0, 'Boye Xian ', 'BYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (522, '130638', '雄县', 42, 0, 0, 'Xiong Xian', 'XOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (524, '130682', '定州市', 42, 0, 0, 'Dingzhou Shi ', 'DZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (525, '130683', '安国市', 42, 0, 0, 'Anguo Shi ', 'AGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (527, '130701', '市辖区', 43, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (528, '130702', '桥东区', 43, 0, 0, 'Qiaodong Qu', 'QDZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (529, '130703', '桥西区', 43, 0, 0, 'Qiaoxi Qu', 'QXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (530, '130705', '宣化区', 43, 0, 0, 'Xuanhua Qu', 'XHZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (532, '130721', '宣化县', 43, 0, 0, 'Xuanhua Xian ', 'XHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (533, '130722', '张北县', 43, 0, 0, 'Zhangbei Xian ', 'ZGB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (534, '130723', '康保县', 43, 0, 0, 'Kangbao Xian', 'KBO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (536, '130725', '尚义县', 43, 0, 0, 'Shangyi Xian', 'SYK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (537, '130726', '蔚县', 43, 0, 0, 'Yu Xian', 'YXJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (538, '130727', '阳原县', 43, 0, 0, 'Yangyuan Xian', 'YYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (540, '130729', '万全县', 43, 0, 0, 'Wanquan Xian ', 'WQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (541, '130730', '怀来县', 43, 0, 0, 'Huailai Xian', 'HLA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (542, '130731', '涿鹿县', 43, 0, 0, 'Zhuolu Xian ', 'ZLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (544, '130733', '崇礼县', 43, 0, 0, 'Chongli Xian', 'COL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (545, '130801', '市辖区', 44, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (546, '130802', '双桥区', 44, 0, 0, 'Shuangqiao Qu ', 'SQO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (548, '130804', '鹰手营子矿区', 44, 0, 0, 'Yingshouyingzi Kuangqu', 'YSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (550, '130822', '兴隆县', 44, 0, 0, 'Xinglong Xian', 'XLJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (551, '130823', '平泉县', 44, 0, 0, 'Pingquan Xian', 'PQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (552, '130824', '滦平县', 44, 0, 0, 'Luanping Xian ', 'LUP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (554, '130826', '丰宁满族自治县', 44, 0, 0, 'Fengning Manzu Zizhixian', 'FNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (556, '130828', '围场满族蒙古族自治县', 44, 0, 0, 'Weichang Manzu Menggolzu Zizhixian', 'WCJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (557, '130901', '市辖区', 45, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (559, '130903', '运河区', 45, 0, 0, 'Yunhe Qu', 'YHC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (560, '130921', '沧县', 45, 0, 0, 'Cang Xian', 'CAG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (561, '130922', '青县', 45, 0, 0, 'Qing Xian', 'QIG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (562, '130923', '东光县', 45, 0, 0, 'Dongguang Xian ', 'DGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (564, '130925', '盐山县', 45, 0, 0, 'Yanshan Xian', 'YNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (565, '130926', '肃宁县', 45, 0, 0, 'Suning Xian ', 'SNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (567, '130928', '吴桥县', 45, 0, 0, 'Wuqiao Xian ', 'WUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (568, '130929', '献县', 45, 0, 0, 'Xian Xian ', 'XXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (570, '130981', '泊头市', 45, 0, 0, 'Botou Shi ', 'BOT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (571, '130982', '任丘市', 45, 0, 0, 'Renqiu Shi', 'RQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (572, '130983', '黄骅市', 45, 0, 0, 'Huanghua Shi', 'HHJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (573, '130984', '河间市', 45, 0, 0, 'Hejian Shi', 'HJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (574, '131001', '市辖区', 46, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (575, '131002', '安次区', 46, 0, 0, 'Anci Qu', 'ACI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (576, '131003', '广阳区', 46, 0, 0, 'Guangyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (577, '131022', '固安县', 46, 0, 0, 'Gu,an Xian', 'GUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (578, '131023', '永清县', 46, 0, 0, 'Yongqing Xian ', 'YQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (579, '131024', '香河县', 46, 0, 0, 'Xianghe Xian', 'XGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (580, '131025', '大城县', 46, 0, 0, 'Dacheng Xian', 'DCJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (581, '131026', '文安县', 46, 0, 0, 'Wen,an Xian', 'WEA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (582, '131028', '大厂回族自治县', 46, 0, 0, 'Dachang Huizu Zizhixian', 'DCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (583, '131081', '霸州市', 46, 0, 0, 'Bazhou Shi', 'BZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (584, '131082', '三河市', 46, 0, 0, 'Sanhe Shi', 'SNH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (585, '131101', '市辖区', 47, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (586, '131102', '桃城区', 47, 0, 0, 'Taocheng Qu', 'TOC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (588, '131122', '武邑县', 47, 0, 0, 'Wuyi Xian', 'WYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (589, '131123', '武强县', 47, 0, 0, 'Wuqiang Xian ', 'WQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (590, '131124', '饶阳县', 47, 0, 0, 'Raoyang Xian', 'RYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (592, '131126', '故城县', 47, 0, 0, 'Gucheng Xian', 'GCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (593, '131127', '景县', 47, 0, 0, 'Jing Xian ', 'JIG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (595, '131181', '冀州市', 47, 0, 0, 'Jizhou Shi ', 'JIZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (596, '131182', '深州市', 47, 0, 0, 'Shenzhou Shi', 'SNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (597, '140101', '市辖区', 48, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (599, '140106', '迎泽区', 48, 0, 0, 'Yingze Qu', 'YZT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (600, '140107', '杏花岭区', 48, 0, 0, 'Xinghualing Qu', 'XHL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (603, '140110', '晋源区', 48, 0, 0, 'Jinyuan Qu', 'JYM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (604, '140121', '清徐县', 48, 0, 0, 'Qingxu Xian ', 'QXU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (606, '140123', '娄烦县', 48, 0, 0, 'Loufan Xian', 'LFA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (607, '140181', '古交市', 48, 0, 0, 'Gujiao Shi', 'GUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (608, '140201', '市辖区', 49, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (609, '140202', '城区', 49, 0, 0, 'Chengqu', 'CQD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (610, '140203', '矿区', 49, 0, 0, 'Kuangqu', 'KQD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (612, '140212', '新荣区', 49, 0, 0, 'Xinrong Qu', 'XRQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (613, '140221', '阳高县', 49, 0, 0, 'Yanggao Xian ', 'YGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (615, '140223', '广灵县', 49, 0, 0, 'Guangling Xian ', 'GLJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (616, '140224', '灵丘县', 49, 0, 0, 'Lingqiu Xian ', 'LQX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (618, '140226', '左云县', 49, 0, 0, 'Zuoyun Xian', 'ZUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (619, '140227', '大同县', 49, 0, 0, 'Datong Xian ', 'DTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (620, '140301', '市辖区', 50, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (621, '140302', '城区', 50, 0, 0, 'Chengqu', 'CQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (622, '140303', '矿区', 50, 0, 0, 'Kuangqu', 'KQY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (623, '140311', '郊区', 50, 0, 0, 'Jiaoqu', 'JQY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (625, '140322', '盂县', 50, 0, 0, 'Yu Xian', 'YUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (626, '140401', '市辖区', 51, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (627, '140402', '城区', 51, 0, 0, 'Chengqu ', 'CQC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (628, '140411', '郊区', 51, 0, 0, 'Jiaoqu', 'JQZ');
commit;
prompt 2200 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (629, '140421', '长治县', 51, 0, 0, 'Changzhi Xian', 'CZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (630, '140423', '襄垣县', 51, 0, 0, 'Xiangyuan Xian', 'XYJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (632, '140425', '平顺县', 51, 0, 0, 'Pingshun Xian', 'PSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (633, '140426', '黎城县', 51, 0, 0, 'Licheng Xian', 'LIC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (635, '140428', '长子县', 51, 0, 0, 'Zhangzi Xian ', 'ZHZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (636, '140429', '武乡县', 51, 0, 0, 'Wuxiang Xian', 'WXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (638, '140431', '沁源县', 51, 0, 0, 'Qinyuan Xian ', 'QYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (639, '140481', '潞城市', 51, 0, 0, 'Lucheng Shi', 'LCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (640, '140501', '市辖区', 52, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (641, '140502', '城区', 52, 0, 0, 'Chengqu ', 'CQJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (643, '140522', '阳城县', 52, 0, 0, 'Yangcheng Xian ', 'YGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (645, '140525', '泽州县', 52, 0, 0, 'Zezhou Xian', 'ZEZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (646, '140581', '高平市', 52, 0, 0, 'Gaoping Shi ', 'GPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (647, '140601', '市辖区', 53, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (648, '140602', '朔城区', 53, 0, 0, 'Shuocheng Qu', 'SCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (650, '140621', '山阴县', 53, 0, 0, 'Shanyin Xian', 'SYP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (651, '140622', '应县', 53, 0, 0, 'Ying Xian', 'YIG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (653, '140624', '怀仁县', 53, 0, 0, 'Huairen Xian', 'HRN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (654, '140701', '市辖区', 54, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (655, '140702', '榆次区', 54, 0, 0, 'Yuci Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (656, '140721', '榆社县', 54, 0, 0, 'Yushe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (658, '140723', '和顺县', 54, 0, 0, 'Heshun Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (659, '140724', '昔阳县', 54, 0, 0, 'Xiyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (661, '140726', '太谷县', 54, 0, 0, 'Taigu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (662, '140727', '祁县', 54, 0, 0, 'Qi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (663, '140728', '平遥县', 54, 0, 0, 'Pingyao Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (665, '140781', '介休市', 54, 0, 0, 'Jiexiu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (666, '140801', '市辖区', 55, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (667, '140802', '盐湖区', 55, 0, 0, 'Yanhu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (668, '140821', '临猗县', 55, 0, 0, 'Linyi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (669, '140822', '万荣县', 55, 0, 0, 'Wanrong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (671, '140824', '稷山县', 55, 0, 0, 'Jishan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (672, '140825', '新绛县', 55, 0, 0, 'Xinjiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (674, '140827', '垣曲县', 55, 0, 0, 'Yuanqu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (675, '140828', '夏县', 55, 0, 0, 'Xia Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (677, '140830', '芮城县', 55, 0, 0, 'Ruicheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (678, '140881', '永济市', 55, 0, 0, 'Yongji Shi ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (680, '140901', '市辖区', 56, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (681, '140902', '忻府区', 56, 0, 0, 'Xinfu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (682, '140921', '定襄县', 56, 0, 0, 'Dingxiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (683, '140922', '五台县', 56, 0, 0, 'Wutai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (684, '140923', '代县', 56, 0, 0, 'Dai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (686, '140925', '宁武县', 56, 0, 0, 'Ningwu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (687, '140926', '静乐县', 56, 0, 0, 'Jingle Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (689, '140928', '五寨县', 56, 0, 0, 'Wuzhai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (690, '140929', '岢岚县', 56, 0, 0, 'Kelan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (691, '140930', '河曲县', 56, 0, 0, 'Hequ Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (693, '140932', '偏关县', 56, 0, 0, 'Pianguan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (694, '140981', '原平市', 56, 0, 0, 'Yuanping Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (695, '141001', '市辖区', 57, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (696, '141002', '尧都区', 57, 0, 0, 'Yaodu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (698, '141022', '翼城县', 57, 0, 0, 'Yicheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (699, '141023', '襄汾县', 57, 0, 0, 'Xiangfen Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (701, '141025', '古县', 57, 0, 0, 'Gu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (702, '141026', '安泽县', 57, 0, 0, 'Anze Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (703, '141027', '浮山县', 57, 0, 0, 'Fushan Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (705, '141029', '乡宁县', 57, 0, 0, 'Xiangning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (706, '141030', '大宁县', 57, 0, 0, 'Daning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (708, '141032', '永和县', 57, 0, 0, 'Yonghe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (709, '141033', '蒲县', 57, 0, 0, 'Pu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (710, '141034', '汾西县', 57, 0, 0, 'Fenxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (712, '141082', '霍州市', 57, 0, 0, 'Huozhou Shi ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (713, '141101', '市辖区', 58, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (714, '141102', '离石区', 58, 0, 0, 'Lishi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (715, '141121', '文水县', 58, 0, 0, 'Wenshui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (716, '141122', '交城县', 58, 0, 0, 'Jiaocheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (717, '141123', '兴县', 58, 0, 0, 'Xing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (718, '141124', '临县', 58, 0, 0, 'Lin Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (719, '141125', '柳林县', 58, 0, 0, 'Liulin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (720, '141126', '石楼县', 58, 0, 0, 'Shilou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (721, '141127', '岚县', 58, 0, 0, 'Lan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (722, '141128', '方山县', 58, 0, 0, 'Fangshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (723, '141129', '中阳县', 58, 0, 0, 'Zhongyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (724, '141130', '交口县', 58, 0, 0, 'Jiaokou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (725, '141181', '孝义市', 58, 0, 0, 'Xiaoyi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (726, '141182', '汾阳市', 58, 0, 0, 'Fenyang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (727, '150101', '市辖区', 59, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (728, '150102', '新城区', 59, 0, 0, 'Xincheng Qu', 'XCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (729, '150103', '回民区', 59, 0, 0, 'Huimin Qu', 'HMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (730, '150104', '玉泉区', 59, 0, 0, 'Yuquan Qu', 'YQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (731, '150105', '赛罕区', 59, 0, 0, 'Saihan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (732, '150121', '土默特左旗', 59, 0, 0, 'Tumd Zuoqi', 'TUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (733, '150122', '托克托县', 59, 0, 0, 'Togtoh Xian', 'TOG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (734, '150123', '和林格尔县', 59, 0, 0, 'Horinger Xian', 'HOR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (735, '150124', '清水河县', 59, 0, 0, 'Qingshuihe Xian', 'QSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (736, '150125', '武川县', 59, 0, 0, 'Wuchuan Xian', 'WCX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (737, '150201', '市辖区', 60, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (738, '150202', '东河区', 60, 0, 0, 'Donghe Qu', 'DHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (739, '150203', '昆都仑区', 60, 0, 0, 'Kundulun Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (740, '150204', '青山区', 60, 0, 0, 'Qingshan Qu', 'QSB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (742, '150206', '白云鄂博矿区', 60, 0, 0, 'Baiyun Kuangqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (743, '150207', '九原区', 60, 0, 0, 'Jiuyuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (745, '150222', '固阳县', 60, 0, 0, 'Guyang Xian', 'GYM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (746, '150223', '达尔罕茂明安联合旗', 60, 0, 0, 'Darhan Muminggan Lianheqi', 'DML');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (748, '150302', '海勃湾区', 61, 0, 0, 'Haibowan Qu', 'HBW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (749, '150303', '海南区', 61, 0, 0, 'Hainan Qu', 'HNU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (751, '150401', '市辖区', 62, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (752, '150402', '红山区', 62, 0, 0, 'Hongshan Qu', 'HSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (754, '150404', '松山区', 62, 0, 0, 'Songshan Qu', 'SSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (757, '150423', '巴林右旗', 62, 0, 0, 'Bairin Youqi', 'BAY');
commit;
prompt 2300 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (758, '150424', '林西县', 62, 0, 0, 'Linxi Xian', 'LXM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (759, '150425', '克什克腾旗', 62, 0, 0, 'Hexigten Qi', 'HXT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (761, '150428', '喀喇沁旗', 62, 0, 0, 'Harqin Qi', 'HAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (762, '150429', '宁城县', 62, 0, 0, 'Ningcheng Xian', 'NCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (763, '150430', '敖汉旗', 62, 0, 0, 'Aohan Qi', 'AHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (765, '150502', '科尔沁区', 63, 0, 0, 'Keermi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (767, '150522', '科尔沁左翼后旗', 63, 0, 0, 'Horqin Zuoyi Houqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (768, '150523', '开鲁县', 63, 0, 0, 'Kailu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (769, '150524', '库伦旗', 63, 0, 0, 'Hure Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (770, '150525', '奈曼旗', 63, 0, 0, 'Naiman Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (772, '150581', '霍林郭勒市', 63, 0, 0, 'Holingol Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (773, '150602', '东胜区', 64, 0, 0, 'Dongsheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (775, '150622', '准格尔旗', 64, 0, 0, 'Jungar Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (776, '150623', '鄂托克前旗', 64, 0, 0, 'Otog Qianqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (778, '150625', '杭锦旗', 64, 0, 0, 'Hanggin Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (779, '150626', '乌审旗', 64, 0, 0, 'Uxin Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (780, '150627', '伊金霍洛旗', 64, 0, 0, 'Ejin Horo Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (782, '150702', '海拉尔区', 65, 0, 0, 'Hailaer Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (783, '150721', '阿荣旗', 65, 0, 0, 'Arun Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (785, '150723', '鄂伦春自治旗', 65, 0, 0, 'Oroqen Zizhiqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (788, '150726', '新巴尔虎左旗', 65, 0, 0, 'Xin Barag Zuoqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (789, '150727', '新巴尔虎右旗', 65, 0, 0, 'Xin Barag Youqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (791, '150782', '牙克石市', 65, 0, 0, 'Yakeshi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (792, '150783', '扎兰屯市', 65, 0, 0, 'Zalantun Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (794, '150785', '根河市', 65, 0, 0, 'Genhe Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (795, '150801', '市辖区', 66, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (796, '150802', '临河区', 66, 0, 0, 'Linhe Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (797, '150821', '五原县', 66, 0, 0, 'Wuyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (799, '150823', '乌拉特前旗', 66, 0, 0, 'Urad Qianqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (800, '150824', '乌拉特中旗', 66, 0, 0, 'Urad Zhongqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (802, '150826', '杭锦后旗', 66, 0, 0, 'Hanggin Houqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (803, '150901', '市辖区', 67, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (804, '150902', '集宁区', 67, 0, 0, 'Jining Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (806, '150922', '化德县', 67, 0, 0, 'Huade Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (807, '150923', '商都县', 67, 0, 0, 'Shangdu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (808, '150924', '兴和县', 67, 0, 0, 'Xinghe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (810, '150926', '察哈尔右翼前旗', 67, 0, 0, 'Qahar Youyi Qianqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (812, '150928', '察哈尔右翼后旗', 67, 0, 0, 'Qahar Youyi Houqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (813, '150929', '四子王旗', 67, 0, 0, 'Dorbod Qi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (815, '152201', '乌兰浩特市', 68, 0, 0, 'Ulan Hot Shi', 'ULO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (816, '152202', '阿尔山市', 68, 0, 0, 'Arxan Shi', 'ARS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (819, '152223', '扎赉特旗', 68, 0, 0, 'Jalaid Qi', 'JAL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (821, '152501', '二连浩特市', 69, 0, 0, 'Erenhot Shi', 'ERC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (823, '152522', '阿巴嘎旗', 69, 0, 0, 'Abag Qi', 'ABG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (824, '152523', '苏尼特左旗', 69, 0, 0, 'Sonid Zuoqi', 'SOZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (825, '152524', '苏尼特右旗', 69, 0, 0, 'Sonid Youqi', 'SOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (827, '152526', '西乌珠穆沁旗', 69, 0, 0, 'Xi Ujimqin Qi', 'XUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (828, '152527', '太仆寺旗', 69, 0, 0, 'Taibus Qi', 'TAB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (830, '152529', '正镶白旗', 69, 0, 0, 'Zhengxiangbai(Xulun Hobot Qagan)Qi', 'ZXB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (831, '152530', '正蓝旗', 69, 0, 0, 'Zhenglan(Xulun Hoh)Qi', 'ZLM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (832, '152531', '多伦县', 69, 0, 0, 'Duolun (Dolonnur)Xian', 'DLM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (834, '152922', '阿拉善右旗', 70, 0, 0, 'Alxa Youqi', 'ALY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (835, '152923', '额济纳旗', 70, 0, 0, 'Ejin Qi', 'EJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (837, '210102', '和平区', 71, 0, 0, 'Heping Qu', 'HEP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (838, '210103', '沈河区', 71, 0, 0, 'Shenhe Qu ', 'SHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (839, '210104', '大东区', 71, 0, 0, 'Dadong Qu ', 'DDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (841, '210106', '铁西区', 71, 0, 0, 'Tiexi Qu', 'TXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (842, '210111', '苏家屯区', 71, 0, 0, 'Sujiatun Qu', 'SJT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (844, '210113', '沈北新区', 71, 0, 0, 'Xinchengzi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (845, '210114', '于洪区', 71, 0, 0, 'Yuhong Qu ', 'YHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (846, '210122', '辽中县', 71, 0, 0, 'Liaozhong Xian', 'LZL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (848, '210124', '法库县', 71, 0, 0, 'Faku Xian', 'FKU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (849, '210181', '新民市', 71, 0, 0, 'Xinmin Shi', 'XMS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (851, '210202', '中山区', 72, 0, 0, 'Zhongshan Qu', 'ZSD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (852, '210203', '西岗区', 72, 0, 0, 'Xigang Qu', 'XGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (853, '210204', '沙河口区', 72, 0, 0, 'Shahekou Qu', 'SHK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (854, '210211', '甘井子区', 72, 0, 0, 'Ganjingzi Qu', 'GJZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (855, '210212', '旅顺口区', 72, 0, 0, 'Lvshunkou Qu ', 'LSK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (856, '210213', '金州区', 72, 0, 0, 'Jinzhou Qu', 'JZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (857, '210224', '长海县', 72, 0, 0, 'Changhai Xian', 'CHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (858, '210281', '瓦房店市', 72, 0, 0, 'Wafangdian Shi', 'WFD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (859, '210282', '普兰店市', 72, 0, 0, 'Pulandian Shi', 'PLD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (860, '210283', '庄河市', 72, 0, 0, 'Zhuanghe Shi', 'ZHH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (861, '210301', '市辖区', 73, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (862, '210302', '铁东区', 73, 0, 0, 'Tiedong Qu ', 'TED');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (863, '210303', '铁西区', 73, 0, 0, 'Tiexi Qu', 'TXL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (864, '210304', '立山区', 73, 0, 0, 'Lishan Qu', 'LAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (865, '210311', '千山区', 73, 0, 0, 'Qianshan Qu ', 'QSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (866, '210321', '台安县', 73, 0, 0, 'Tai,an Xian', 'TAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (869, '210401', '市辖区', 74, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (870, '210402', '新抚区', 74, 0, 0, 'Xinfu Qu', 'XFU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (871, '210403', '东洲区', 74, 0, 0, 'Dongzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (872, '210404', '望花区', 74, 0, 0, 'Wanghua Qu', 'WHF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (873, '210411', '顺城区', 74, 0, 0, 'Shuncheng Qu', 'SCF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (875, '210422', '新宾满族自治县', 74, 0, 0, 'Xinbinmanzuzizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (876, '210423', '清原满族自治县', 74, 0, 0, 'Qingyuanmanzuzizhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (877, '210501', '市辖区', 75, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (878, '210502', '平山区', 75, 0, 0, 'Pingshan Qu', 'PSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (879, '210503', '溪湖区', 75, 0, 0, 'Xihu Qu ', 'XHB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (881, '210505', '南芬区', 75, 0, 0, 'Nanfen Qu', 'NFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (882, '210521', '本溪满族自治县', 75, 0, 0, 'Benxi Manzu Zizhixian', 'BXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (884, '210601', '市辖区', 76, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (885, '210602', '元宝区', 76, 0, 0, 'Yuanbao Qu', 'YBD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (886, '210603', '振兴区', 76, 0, 0, 'Zhenxing Qu ', 'ZXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (887, '210604', '振安区', 76, 0, 0, 'Zhen,an Qu', 'ZAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (889, '210681', '东港市', 76, 0, 0, 'Donggang Shi', 'DGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (890, '210682', '凤城市', 76, 0, 0, 'Fengcheng Shi', 'FCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (891, '210701', '市辖区', 77, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (892, '210702', '古塔区', 77, 0, 0, 'Guta Qu', 'GTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (893, '210703', '凌河区', 77, 0, 0, 'Linghe Qu', 'LHF');
commit;
prompt 2400 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (894, '210711', '太和区', 77, 0, 0, 'Taihe Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (896, '210727', '义县', 77, 0, 0, 'Yi Xian', 'YXL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (897, '210781', '凌海市', 77, 0, 0, 'Linghai Shi ', 'LHL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (899, '210801', '市辖区', 78, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (900, '210802', '站前区', 78, 0, 0, 'Zhanqian Qu', 'ZQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (901, '210803', '西市区', 78, 0, 0, 'Xishi Qu', 'XII');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (902, '210804', '鲅鱼圈区', 78, 0, 0, 'Bayuquan Qu', 'BYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (903, '210811', '老边区', 78, 0, 0, 'Laobian Qu', 'LOB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (905, '210882', '大石桥市', 78, 0, 0, 'Dashiqiao Shi', 'DSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (906, '210901', '市辖区', 79, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (907, '210902', '海州区', 79, 0, 0, 'Haizhou Qu', 'HZF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (908, '210903', '新邱区', 79, 0, 0, 'Xinqiu Qu', 'XQF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (909, '210904', '太平区', 79, 0, 0, 'Taiping Qu', 'TPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (911, '210911', '细河区', 79, 0, 0, 'Xihe Qu', 'XHO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (913, '210922', '彰武县', 79, 0, 0, 'Zhangwu Xian', 'ZWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (914, '211001', '市辖区', 80, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (915, '211002', '白塔区', 80, 0, 0, 'Baita Qu', 'BTL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (916, '211003', '文圣区', 80, 0, 0, 'Wensheng Qu', 'WST');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (917, '211004', '宏伟区', 80, 0, 0, 'Hongwei Qu', 'HWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (918, '211005', '弓长岭区', 80, 0, 0, 'Gongchangling Qu', 'GCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (920, '211021', '辽阳县', 80, 0, 0, 'Liaoyang Xian', 'LYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (921, '211081', '灯塔市', 80, 0, 0, 'Dengta Shi', 'DTL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (922, '211101', '市辖区', 81, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (924, '211103', '兴隆台区', 81, 0, 0, 'Xinglongtai Qu', 'XLT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (925, '211121', '大洼县', 81, 0, 0, 'Dawa Xian', 'DWA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (926, '211122', '盘山县', 81, 0, 0, 'Panshan Xian', 'PNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (927, '211201', '市辖区', 82, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (929, '211204', '清河区', 82, 0, 0, 'Qinghe Qu', 'QHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (930, '211221', '铁岭县', 82, 0, 0, 'Tieling Xian', 'TLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (931, '211223', '西丰县', 82, 0, 0, 'Xifeng Xian', 'XIF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (933, '211281', '调兵山市', 82, 0, 0, 'Diaobingshan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (934, '211282', '开原市', 82, 0, 0, 'Kaiyuan Shi', 'KYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (935, '211301', '市辖区', 83, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (936, '211302', '双塔区', 83, 0, 0, 'Shuangta Qu', 'STQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (938, '211321', '朝阳县', 83, 0, 0, 'Chaoyang Xian', 'CYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (939, '211322', '建平县', 83, 0, 0, 'Jianping Xian', 'JPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (941, '211381', '北票市', 83, 0, 0, 'Beipiao Shi', 'BPO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (942, '211382', '凌源市', 83, 0, 0, 'Lingyuan Shi', 'LYK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (943, '211401', '市辖区', 84, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1396, '331126', '庆元县', 132, 0, 0, 'Qingyuan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1405, '340122', '肥东县', 133, 0, 0, 'Feidong Xian', 'FDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1410, '340203', '弋江区', 1412, 0, 0, 'Xinwu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1414, '340223', '南陵县', 1412, 0, 0, 'Nanling Xian', 'NLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1424, '340402', '大通区', 136, 0, 0, 'Datong Qu', 'DTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1041, '230204', '铁锋区', 95, 0, 0, 'Tiefeng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1043, '230206', '富拉尔基区', 95, 0, 0, 'Hulan Ergi Qu', 'HUE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1044, '230207', '碾子山区', 95, 0, 0, 'Nianzishan Qu', 'NZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1046, '230221', '龙江县', 95, 0, 0, 'Longjiang Xian', 'LGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1047, '230223', '依安县', 95, 0, 0, 'Yi,an Xian', 'YAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1048, '230224', '泰来县', 95, 0, 0, 'Tailai Xian', 'TLA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1049, '230225', '甘南县', 95, 0, 0, 'Gannan Xian', 'GNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1050, '230227', '富裕县', 95, 0, 0, 'Fuyu Xian', 'FYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1052, '230230', '克东县', 95, 0, 0, 'Kedong Xian', 'KDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1053, '230231', '拜泉县', 95, 0, 0, 'Baiquan Xian', 'BQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1054, '230281', '讷河市', 95, 0, 0, 'Nehe Shi', 'NEH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1056, '230302', '鸡冠区', 96, 0, 0, 'Jiguan Qu', 'JGU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1059, '230305', '梨树区', 96, 0, 0, 'Lishu Qu', 'LJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1060, '230306', '城子河区', 96, 0, 0, 'Chengzihe Qu', 'CZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1061, '230307', '麻山区', 96, 0, 0, 'Mashan Qu', 'MSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1064, '230382', '密山市', 96, 0, 0, 'Mishan Shi', 'MIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1065, '230401', '市辖区', 97, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1067, '230403', '工农区', 97, 0, 0, 'Gongnong Qu', 'GNH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1068, '230404', '南山区', 97, 0, 0, 'Nanshan Qu', 'NSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1070, '230406', '东山区', 97, 0, 0, 'Dongshan Qu', 'DSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1072, '230421', '萝北县', 97, 0, 0, 'Luobei Xian', 'LUB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1074, '230501', '市辖区', 98, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1075, '230502', '尖山区', 98, 0, 0, 'Jianshan Qu', 'JSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1076, '230503', '岭东区', 98, 0, 0, 'Lingdong Qu', 'LDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1078, '230506', '宝山区', 98, 0, 0, 'Baoshan Qu', 'BSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1080, '230522', '友谊县', 98, 0, 0, 'Youyi Xian', 'YYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1082, '230524', '饶河县', 98, 0, 0, 'Raohe Xian ', 'ROH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1083, '230601', '市辖区', 99, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1086, '230604', '让胡路区', 99, 0, 0, 'Ranghulu Qu', 'RHL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1087, '230605', '红岗区', 99, 0, 0, 'Honggang Qu', 'HGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1090, '230622', '肇源县', 99, 0, 0, 'Zhaoyuan Xian', 'ZYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1091, '230623', '林甸县', 99, 0, 0, 'Lindian Xian ', 'LDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1093, '230701', '市辖区', 100, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1094, '230702', '伊春区', 100, 0, 0, 'Yichun Qu', 'YYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1096, '230704', '友好区', 100, 0, 0, 'Youhao Qu', 'YOH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1097, '230705', '西林区', 100, 0, 0, 'Xilin Qu', 'XIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1099, '230707', '新青区', 100, 0, 0, 'Xinqing Qu', 'XQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1101, '230709', '金山屯区', 100, 0, 0, 'Jinshantun Qu', 'JST');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1103, '230711', '乌马河区', 100, 0, 0, 'Wumahe Qu', 'WMH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1106, '230714', '乌伊岭区', 100, 0, 0, 'Wuyiling Qu', 'WYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1107, '230715', '红星区', 100, 0, 0, 'Hongxing Qu', 'HGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1109, '230722', '嘉荫县', 100, 0, 0, 'Jiayin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1110, '230781', '铁力市', 100, 0, 0, 'Tieli Shi', 'TEL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1111, '230801', '市辖区', 101, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1113, '230803', '向阳区', 101, 0, 0, 'Xiangyang  Qu ', 'XYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1115, '230805', '东风区', 101, 0, 0, 'Dongfeng Qu', 'DFQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1116, '230811', '郊区', 101, 0, 0, 'Jiaoqu', 'JQJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1118, '230826', '桦川县', 101, 0, 0, 'Huachuan Xian', 'HCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1120, '230833', '抚远县', 101, 0, 0, 'Fuyuan Xian', 'FUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1122, '230882', '富锦市', 101, 0, 0, 'Fujin Shi', 'FUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1123, '230901', '市辖区', 102, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1126, '230904', '茄子河区', 102, 0, 0, 'Qiezihe Qu', 'QZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1127, '230921', '勃利县', 102, 0, 0, 'Boli Xian', 'BLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1129, '231002', '东安区', 103, 0, 0, 'Dong,an Qu', 'DGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1131, '231004', '爱民区', 103, 0, 0, 'Aimin Qu', 'AMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1133, '231024', '东宁县', 103, 0, 0, 'Dongning Xian', 'DON');
commit;
prompt 2500 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1134, '231025', '林口县', 103, 0, 0, 'Linkou Xian', 'LKO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1136, '231083', '海林市', 103, 0, 0, 'Hailin Shi', 'HLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1137, '231084', '宁安市', 103, 0, 0, 'Ning,an Shi', 'NAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1139, '231101', '市辖区', 104, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1140, '231102', '爱辉区', 104, 0, 0, 'Aihui Qu', 'AHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1141, '231121', '嫩江县', 104, 0, 0, 'Nenjiang Xian', 'NJH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1142, '231123', '逊克县', 104, 0, 0, 'Xunke Xian', 'XUK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1144, '231181', '北安市', 104, 0, 0, 'Bei,an Shi', 'BAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1145, '231182', '五大连池市', 104, 0, 0, 'Wudalianchi Shi', 'WDL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1146, '231201', '市辖区', 105, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1147, '231202', '北林区', 105, 0, 0, 'Beilin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1149, '231222', '兰西县', 105, 0, 0, 'Lanxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1150, '231223', '青冈县', 105, 0, 0, 'Qinggang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1152, '231225', '明水县', 105, 0, 0, 'Mingshui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1153, '231226', '绥棱县', 105, 0, 0, 'Suileng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1154, '231281', '安达市', 105, 0, 0, 'Anda Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1156, '231283', '海伦市', 105, 0, 0, 'Hailun Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1157, '232721', '呼玛县', 106, 0, 0, 'Huma Xian', 'HUM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1158, '232722', '塔河县', 106, 0, 0, 'Tahe Xian', 'TAH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1160, '310101', '黄浦区', 107, 0, 0, 'Huangpu Qu', 'HGP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1161, '310103', '卢湾区', 107, 0, 0, 'Luwan Qu', 'LWN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1162, '310104', '徐汇区', 107, 0, 0, 'Xuhui Qu', 'XHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1164, '310106', '静安区', 107, 0, 0, 'Jing,an Qu', 'JAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1165, '310107', '普陀区', 107, 0, 0, 'Putuo Qu', 'PTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1166, '310108', '闸北区', 107, 0, 0, 'Zhabei Qu', 'ZBE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1167, '310109', '虹口区', 107, 0, 0, 'Hongkou Qu', 'HKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1169, '310112', '闵行区', 107, 0, 0, 'Minhang Qu', 'MHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1170, '310113', '宝山区', 107, 0, 0, 'Baoshan Qu', 'BAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1171, '310114', '嘉定区', 107, 0, 0, 'Jiading Qu', 'JDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1173, '310116', '金山区', 107, 0, 0, 'Jinshan Qu', 'JSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1174, '310117', '松江区', 107, 0, 0, 'Songjiang Qu', 'SOJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1175, '310118', '青浦区', 107, 0, 0, 'Qingpu  Qu', 'QPU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1177, '310120', '奉贤区', 107, 0, 0, 'Fengxian Qu', 'FXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1178, '310230', '崇明县', 108, 0, 0, 'Chongming Xian', 'CMI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1179, '320101', '市辖区', 109, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1181, '320103', '白下区', 109, 0, 0, 'Baixia Qu', 'BXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1182, '320104', '秦淮区', 109, 0, 0, 'Qinhuai Qu', 'QHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1183, '320105', '建邺区', 109, 0, 0, 'Jianye Qu', 'JYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1184, '320106', '鼓楼区', 109, 0, 0, 'Gulou Qu', 'GLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1186, '320111', '浦口区', 109, 0, 0, 'Pukou Qu', 'PKO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1187, '320113', '栖霞区', 109, 0, 0, 'Qixia Qu', 'QAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1188, '320114', '雨花台区', 109, 0, 0, 'Yuhuatai Qu', 'YHT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1425, '340403', '田家庵区', 136, 0, 0, 'Tianjia,an Qu', 'TJA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1427, '340405', '八公山区', 136, 0, 0, 'Bagongshan Qu', 'BGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1428, '340406', '潘集区', 136, 0, 0, 'Panji Qu', 'PJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1429, '340421', '凤台县', 136, 0, 0, 'Fengtai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1430, '340501', '市辖区', 137, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1431, '340502', '金家庄区', 137, 0, 0, 'Jinjiazhuang Qu', 'JJZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1432, '340503', '花山区', 137, 0, 0, 'Huashan Qu', 'HSM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1433, '340504', '雨山区', 137, 0, 0, 'Yushan Qu', 'YSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1434, '340521', '当涂县', 137, 0, 0, 'Dangtu Xian', 'DTU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1435, '340601', '市辖区', 138, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1436, '340602', '杜集区', 138, 0, 0, 'Duji Qu', 'DJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1437, '340603', '相山区', 138, 0, 0, 'Xiangshan Qu', 'XSA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1438, '340604', '烈山区', 138, 0, 0, 'Lieshan Qu', 'LHB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1439, '340621', '濉溪县', 138, 0, 0, 'Suixi Xian', 'SXW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1440, '340701', '市辖区', 139, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1441, '340702', '铜官山区', 139, 0, 0, 'Tongguanshan Qu', 'TGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1442, '340703', '狮子山区', 139, 0, 0, 'Shizishan Qu', 'SZN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1443, '340711', '郊区', 139, 0, 0, 'Jiaoqu', 'JTL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1444, '340721', '铜陵县', 139, 0, 0, 'Tongling Xian', 'TLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1445, '340801', '市辖区', 140, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1446, '340802', '迎江区', 140, 0, 0, 'Yingjiang Qu', 'YJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1447, '340803', '大观区', 140, 0, 0, 'Daguan Qu', 'DGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1448, '340811', '宜秀区', 140, 0, 0, 'Yixiu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1449, '340822', '怀宁县', 140, 0, 0, 'Huaining Xian', 'HNW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1450, '340823', '枞阳县', 140, 0, 0, 'Zongyang Xian', 'ZYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1451, '340824', '潜山县', 140, 0, 0, 'Qianshan Xian', 'QSW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1452, '340825', '太湖县', 140, 0, 0, 'Taihu Xian', 'THU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1453, '340826', '宿松县', 140, 0, 0, 'Susong Xian', 'SUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1454, '340827', '望江县', 140, 0, 0, 'Wangjiang Xian', 'WJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1455, '340828', '岳西县', 140, 0, 0, 'Yuexi Xian', 'YXW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1456, '340881', '桐城市', 140, 0, 0, 'Tongcheng Shi', 'TCW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1457, '341001', '市辖区', 141, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1458, '341002', '屯溪区', 141, 0, 0, 'Tunxi Qu', 'TXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1459, '341003', '黄山区', 141, 0, 0, 'Huangshan Qu', 'HSK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1460, '341004', '徽州区', 141, 0, 0, 'Huizhou Qu', 'HZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1461, '341021', '歙县', 141, 0, 0, 'She Xian', 'SEX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1462, '341022', '休宁县', 141, 0, 0, 'Xiuning Xian', 'XUN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1463, '341023', '黟县', 141, 0, 0, 'Yi Xian', 'YIW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1464, '341024', '祁门县', 141, 0, 0, 'Qimen Xian', 'QMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1465, '341101', '市辖区', 142, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1466, '341102', '琅琊区', 142, 0, 0, 'Langya Qu', 'LYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1467, '341103', '南谯区', 142, 0, 0, 'Nanqiao Qu', 'NQQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1468, '341122', '来安县', 142, 0, 0, 'Lai,an Xian', 'LAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1469, '341124', '全椒县', 142, 0, 0, 'Quanjiao Xian', 'QJO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1470, '341125', '定远县', 142, 0, 0, 'Dingyuan Xian', 'DYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1471, '341126', '凤阳县', 142, 0, 0, 'Fengyang Xian', 'FYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1472, '341181', '天长市', 142, 0, 0, 'Tianchang Shi', 'TNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1473, '341182', '明光市', 142, 0, 0, 'Mingguang Shi', 'MGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1474, '341201', '市辖区', 143, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1475, '341202', '颍州区', 143, 0, 0, 'Yingzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1476, '341203', '颍东区', 143, 0, 0, 'Yingdong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1477, '341204', '颍泉区', 143, 0, 0, 'Yingquan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1478, '341221', '临泉县', 143, 0, 0, 'Linquan Xian', 'LQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1479, '341222', '太和县', 143, 0, 0, 'Taihe Xian', 'TIH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1480, '341225', '阜南县', 143, 0, 0, 'Funan Xian', 'FNX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1481, '341226', '颍上县', 143, 0, 0, 'Yingshang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1482, '341282', '界首市', 143, 0, 0, 'Jieshou Shi', 'JSW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1483, '341301', '市辖区', 144, 0, 0, 'Shixiaqu', '2');
commit;
prompt 2600 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1484, '341302', '埇桥区', 144, 0, 0, 'Yongqiao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1485, '341321', '砀山县', 144, 0, 0, 'Dangshan Xian', 'DSW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1486, '341322', '萧县', 144, 0, 0, 'Xiao Xian', 'XIO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1487, '341323', '灵璧县', 144, 0, 0, 'Lingbi Xian', 'LBI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1488, '341324', '泗县', 144, 0, 0, 'Si Xian ', 'SIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1489, '341401', '市辖区', 145, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1490, '341402', '居巢区', 145, 0, 0, 'Juchao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1491, '341421', '庐江县', 145, 0, 0, 'Lujiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1492, '341422', '无为县', 145, 0, 0, 'Wuwei Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1493, '341423', '含山县', 145, 0, 0, 'Hanshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1494, '341424', '和县', 145, 0, 0, 'He Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1495, '341501', '市辖区', 146, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1496, '341502', '金安区', 146, 0, 0, 'Jinan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1497, '341503', '裕安区', 146, 0, 0, 'Yuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1498, '341521', '寿县', 146, 0, 0, 'Shou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1499, '341522', '霍邱县', 146, 0, 0, 'Huoqiu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1500, '341523', '舒城县', 146, 0, 0, 'Shucheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1501, '341524', '金寨县', 146, 0, 0, 'Jingzhai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1502, '341525', '霍山县', 146, 0, 0, 'Huoshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1503, '341601', '市辖区', 147, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1504, '341602', '谯城区', 147, 0, 0, 'Qiaocheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1505, '341621', '涡阳县', 147, 0, 0, 'Guoyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1506, '341622', '蒙城县', 147, 0, 0, 'Mengcheng Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1507, '341623', '利辛县', 147, 0, 0, 'Lixin Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1508, '341701', '市辖区', 148, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1509, '341702', '贵池区', 148, 0, 0, 'Guichi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1510, '341721', '东至县', 148, 0, 0, 'Dongzhi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1511, '341722', '石台县', 148, 0, 0, 'Shitai Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1512, '341723', '青阳县', 148, 0, 0, 'Qingyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1513, '341801', '市辖区', 149, 0, 0, '1', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1514, '341802', '宣州区', 149, 0, 0, 'Xuanzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1515, '341821', '郎溪县', 149, 0, 0, 'Langxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1516, '341822', '广德县', 149, 0, 0, 'Guangde Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1517, '341823', '泾县', 149, 0, 0, 'Jing Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1518, '341824', '绩溪县', 149, 0, 0, 'Jixi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1519, '341825', '旌德县', 149, 0, 0, 'Jingde Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1520, '341881', '宁国市', 149, 0, 0, 'Ningguo Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1521, '350101', '市辖区', 150, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1522, '350102', '鼓楼区', 150, 0, 0, 'Gulou Qu', 'GLR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1523, '350103', '台江区', 150, 0, 0, 'Taijiang Qu', 'TJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1524, '350104', '仓山区', 150, 0, 0, 'Cangshan Qu', 'CSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1525, '350105', '马尾区', 150, 0, 0, 'Mawei Qu', 'MWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1526, '350111', '晋安区', 150, 0, 0, 'Jin,an Qu', 'JAF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1527, '350121', '闽侯县', 150, 0, 0, 'Minhou Qu', 'MHO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1528, '350122', '连江县', 150, 0, 0, 'Lianjiang Xian', 'LJF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1529, '350123', '罗源县', 150, 0, 0, 'Luoyuan Xian', 'LOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1530, '350124', '闽清县', 150, 0, 0, 'Minqing Xian', 'MQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1531, '350125', '永泰县', 150, 0, 0, 'Yongtai Xian', 'YTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1532, '350128', '平潭县', 150, 0, 0, 'Pingtan Xian', 'PTN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1533, '350181', '福清市', 150, 0, 0, 'Fuqing Shi', 'FQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1535, '350201', '市辖区', 151, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1536, '350203', '思明区', 151, 0, 0, 'Siming Qu', 'SMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1537, '350205', '海沧区', 151, 0, 0, 'Haicang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1538, '350206', '湖里区', 151, 0, 0, 'Huli Qu', 'HLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1539, '350211', '集美区', 151, 0, 0, 'Jimei Qu', 'JMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1541, '350213', '翔安区', 151, 0, 0, 'Xiangan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1542, '350301', '市辖区', 152, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1543, '350302', '城厢区', 152, 0, 0, 'Chengxiang Qu', 'CXP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1544, '350303', '涵江区', 152, 0, 0, 'Hanjiang Qu', 'HJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1545, '350304', '荔城区', 152, 0, 0, 'Licheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1546, '350305', '秀屿区', 152, 0, 0, 'Xiuyu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1549, '350402', '梅列区', 153, 0, 0, 'Meilie Qu', 'MLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1550, '350403', '三元区', 153, 0, 0, 'Sanyuan Qu', 'SYB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1548, '350401', '市辖区', 153, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1551, '350421', '明溪县', 153, 0, 0, 'Mingxi Xian', 'MXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1553, '350424', '宁化县', 153, 0, 0, 'Ninghua Xian', 'NGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1554, '350425', '大田县', 153, 0, 0, 'Datian Xian', 'DTM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1555, '350426', '尤溪县', 153, 0, 0, 'Youxi Xian', 'YXF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1557, '350428', '将乐县', 153, 0, 0, 'Jiangle Xian', 'JLE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1558, '350429', '泰宁县', 153, 0, 0, 'Taining Xian', 'TNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1560, '350481', '永安市', 153, 0, 0, 'Yong,an Shi', 'YAF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1561, '350501', '市辖区', 154, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1562, '350502', '鲤城区', 154, 0, 0, 'Licheng Qu', 'LCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1564, '350504', '洛江区', 154, 0, 0, 'Luojiang Qu', 'LJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1565, '350505', '泉港区', 154, 0, 0, 'Quangang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1566, '350521', '惠安县', 154, 0, 0, 'Hui,an Xian', 'HAF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1567, '350524', '安溪县', 154, 0, 0, 'Anxi Xian', 'ANX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1569, '350526', '德化县', 154, 0, 0, 'Dehua Xian', 'DHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1570, '350527', '金门县', 154, 0, 0, 'Jinmen Xian', 'JME');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1572, '350582', '晋江市', 154, 0, 0, 'Jinjiang Shi', 'JJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1573, '350583', '南安市', 154, 0, 0, 'Nan,an Shi', 'NAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1574, '350601', '市辖区', 155, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1576, '350603', '龙文区', 155, 0, 0, 'Longwen Qu', 'LWZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1577, '350622', '云霄县', 155, 0, 0, 'Yunxiao Xian', 'YXO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1578, '350623', '漳浦县', 155, 0, 0, 'Zhangpu Xian', 'ZPU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1580, '350625', '长泰县', 155, 0, 0, 'Changtai Xian', 'CTA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1582, '350627', '南靖县', 155, 0, 0, 'Nanjing Xian', 'NJX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1584, '350629', '华安县', 155, 0, 0, 'Hua,an Xian', 'HAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1586, '350701', '市辖区', 156, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1587, '350702', '延平区', 156, 0, 0, 'Yanping Qu', 'YPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1590, '350723', '光泽县', 156, 0, 0, 'Guangze Xian', 'GZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1591, '350724', '松溪县', 156, 0, 0, 'Songxi Xian', 'SOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1592, '350725', '政和县', 156, 0, 0, 'Zhenghe Xian', 'ZGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1595, '350783', '建瓯市', 156, 0, 0, 'Jian,ou Shi', 'JOU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1596, '350784', '建阳市', 156, 0, 0, 'Jianyang Shi', 'JNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1599, '350821', '长汀县', 157, 0, 0, 'Changting Xian', 'CTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1600, '350822', '永定县', 157, 0, 0, 'Yongding Xian', 'YDI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1603, '350825', '连城县', 157, 0, 0, 'Liancheng Xian', 'LCF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1604, '350881', '漳平市', 157, 0, 0, 'Zhangping Xian', 'ZGP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1606, '350902', '蕉城区', 158, 0, 0, 'Jiaocheng Qu', '2');
commit;
prompt 2700 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1608, '350922', '古田县', 158, 0, 0, 'Gutian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1610, '350924', '寿宁县', 158, 0, 0, 'Shouning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1612, '350926', '柘荣县', 158, 0, 0, 'Zherong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1614, '350982', '福鼎市', 158, 0, 0, 'Fuding Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1615, '360101', '市辖区', 159, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1616, '360102', '东湖区', 159, 0, 0, 'Donghu Qu', 'DHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1619, '360105', '湾里区', 159, 0, 0, 'Wanli Qu', 'WLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1621, '360121', '南昌县', 159, 0, 0, 'Nanchang Xian', 'NCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1623, '360123', '安义县', 159, 0, 0, 'Anyi Xian', 'AYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1624, '360124', '进贤县', 159, 0, 0, 'Jinxian Xian', 'JXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1626, '360202', '昌江区', 160, 0, 0, 'Changjiang Qu', 'CJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1628, '360222', '浮梁县', 160, 0, 0, 'Fuliang Xian', 'FLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1630, '360301', '市辖区', 161, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1631, '360302', '安源区', 161, 0, 0, 'Anyuan Qu', 'AYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1634, '360322', '上栗县', 161, 0, 0, 'Shangli Xian', 'SLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1635, '360323', '芦溪县', 161, 0, 0, 'Lixi Xian', 'LXP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1636, '360401', '市辖区', 162, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1638, '360403', '浔阳区', 162, 0, 0, 'Xunyang Qu', 'XYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1640, '360423', '武宁县', 162, 0, 0, 'Wuning Xian', 'WUN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1642, '360425', '永修县', 162, 0, 0, 'Yongxiu Xian', 'YOX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1644, '360427', '星子县', 162, 0, 0, 'Xingzi Xian', 'XZI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1646, '360429', '湖口县', 162, 0, 0, 'Hukou Xian', 'HUK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1647, '360430', '彭泽县', 162, 0, 0, 'Pengze Xian', 'PZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1189, '320115', '江宁区', 109, 0, 0, 'Jiangning Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1190, '320116', '六合区', 109, 0, 0, 'Liuhe Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1191, '320124', '溧水县', 109, 0, 0, 'Lishui Xian', 'LIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1192, '320125', '高淳县', 109, 0, 0, 'Gaochun Xian', 'GCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1193, '320201', '市辖区', 110, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1194, '320202', '崇安区', 110, 0, 0, 'Chong,an Qu', 'CGA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1195, '320203', '南长区', 110, 0, 0, 'Nanchang Qu', 'NCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1196, '320204', '北塘区', 110, 0, 0, 'Beitang Qu', 'BTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1197, '320205', '锡山区', 110, 0, 0, 'Xishan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1198, '320206', '惠山区', 110, 0, 0, 'Huishan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1199, '320211', '滨湖区', 110, 0, 0, 'Binhu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1200, '320281', '江阴市', 110, 0, 0, 'Jiangyin Shi', 'JIA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1201, '320282', '宜兴市', 110, 0, 0, 'Yixing Shi', 'YIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1202, '320301', '市辖区', 111, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1203, '320302', '鼓楼区', 111, 0, 0, 'Gulou Qu', 'GLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1204, '320303', '云龙区', 111, 0, 0, 'Yunlong Qu', 'YLF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1206, '320305', '贾汪区', 111, 0, 0, 'Jiawang Qu', 'JWQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1207, '320311', '泉山区', 111, 0, 0, 'Quanshan Qu', 'QSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1208, '320321', '丰县', 111, 0, 0, 'Feng Xian', 'FXN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1209, '320322', '沛县', 111, 0, 0, 'Pei Xian', 'PEI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1210, '320312', '铜山区', 111, 0, 0, 'Tongshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1211, '320324', '睢宁县', 111, 0, 0, 'Suining Xian', 'SNI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1212, '320381', '新沂市', 111, 0, 0, 'Xinyi Shi', 'XYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1213, '320382', '邳州市', 111, 0, 0, 'Pizhou Shi', 'PZO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1214, '320401', '市辖区', 112, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1215, '320402', '天宁区', 112, 0, 0, 'Tianning Qu', 'TNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1216, '320404', '钟楼区', 112, 0, 0, 'Zhonglou Qu', 'ZLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1217, '320405', '戚墅堰区', 112, 0, 0, 'Qishuyan Qu', 'QSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1218, '320411', '新北区', 112, 0, 0, 'Xinbei Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1219, '320412', '武进区', 112, 0, 0, 'Wujin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1220, '320481', '溧阳市', 112, 0, 0, 'Liyang Shi', 'LYR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1221, '320482', '金坛市', 112, 0, 0, 'Jintan Shi', 'JTS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1222, '320501', '市辖区', 113, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1223, '320502', '沧浪区', 113, 0, 0, 'Canglang Qu', 'CLQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1224, '320503', '平江区', 113, 0, 0, 'Pingjiang Qu', 'PJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1225, '320504', '金阊区', 113, 0, 0, 'Jinchang Qu', 'JCA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1226, '320505', '虎丘区', 113, 0, 0, 'Huqiu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1227, '320506', '吴中区', 113, 0, 0, 'Wuzhong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1228, '320507', '相城区', 113, 0, 0, 'Xiangcheng Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1229, '320581', '常熟市', 113, 0, 0, 'Changshu Shi', 'CGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1230, '320582', '张家港市', 113, 0, 0, 'Zhangjiagang Shi ', 'ZJG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1231, '320583', '昆山市', 113, 0, 0, 'Kunshan Shi', 'KUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1232, '320584', '吴江市', 113, 0, 0, 'Wujiang Shi', 'WUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1233, '320585', '太仓市', 113, 0, 0, 'Taicang Shi', 'TAC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1234, '320601', '市辖区', 114, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1235, '320602', '崇川区', 114, 0, 0, 'Chongchuan Qu', 'CCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1236, '320611', '港闸区', 114, 0, 0, 'Gangzha Qu', 'GZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1237, '320621', '海安县', 114, 0, 0, 'Hai,an Xian', 'HIA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1238, '320623', '如东县', 114, 0, 0, 'Rudong Xian', 'RDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1239, '320681', '启东市', 114, 0, 0, 'Qidong Shi', 'QID');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1240, '320682', '如皋市', 114, 0, 0, 'Rugao Shi', 'RGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1241, '320612', '通州区', 114, 0, 0, 'Tongzhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1242, '320684', '海门市', 114, 0, 0, 'Haimen Shi', 'HME');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1243, '320701', '市辖区', 115, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1244, '320703', '连云区', 115, 0, 0, 'Lianyun Qu', 'LYB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1245, '320705', '新浦区', 115, 0, 0, 'Xinpu Qu', 'XPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1246, '320706', '海州区', 115, 0, 0, 'Haizhou Qu', 'HIZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1247, '320721', '赣榆县', 115, 0, 0, 'Ganyu Xian', 'GYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1248, '320722', '东海县', 115, 0, 0, 'Donghai Xian', 'DHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1249, '320723', '灌云县', 115, 0, 0, 'Guanyun Xian', 'GYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1250, '320724', '灌南县', 115, 0, 0, 'Guannan Xian', 'GUN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1251, '320801', '市辖区', 116, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1252, '320802', '清河区', 116, 0, 0, 'Qinghe Qu', 'QHH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1253, '320803', '楚州区', 116, 0, 0, 'Chuzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1254, '320804', '淮阴区', 116, 0, 0, 'Huaiyin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1255, '320811', '清浦区', 116, 0, 0, 'Qingpu Qu', 'QPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1256, '320826', '涟水县', 116, 0, 0, 'Lianshui Xian', 'LSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1257, '320829', '洪泽县', 116, 0, 0, 'Hongze Xian', 'HGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1258, '320830', '盱眙县', 116, 0, 0, 'Xuyi Xian', 'XUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1259, '320831', '金湖县', 116, 0, 0, 'Jinhu Xian', 'JHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1260, '320901', '市辖区', 117, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1261, '320902', '亭湖区', 117, 0, 0, 'Tinghu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1262, '320903', '盐都区', 117, 0, 0, 'Yandu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1263, '320921', '响水县', 117, 0, 0, 'Xiangshui Xian', 'XSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1264, '320922', '滨海县', 117, 0, 0, 'Binhai Xian', 'BHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1265, '320923', '阜宁县', 117, 0, 0, 'Funing Xian', 'FNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1266, '320924', '射阳县', 117, 0, 0, 'Sheyang Xian', 'SEY');
commit;
prompt 2800 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1267, '320925', '建湖县', 117, 0, 0, 'Jianhu Xian', 'JIH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1268, '320981', '东台市', 117, 0, 0, 'Dongtai Shi', 'DTS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1269, '320982', '大丰市', 117, 0, 0, 'Dafeng Shi', 'DFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1270, '321001', '市辖区', 118, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1271, '321002', '广陵区', 118, 0, 0, 'Guangling Qu', 'GGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1272, '321003', '邗江区', 118, 0, 0, 'Hanjiang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1273, '321011', '维扬区', 118, 0, 0, 'Weiyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1274, '321023', '宝应县', 118, 0, 0, 'Baoying Xian ', 'BYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1275, '321081', '仪征市', 118, 0, 0, 'Yizheng Shi', 'YZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1276, '321084', '高邮市', 118, 0, 0, 'Gaoyou Shi', 'GYO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1277, '321088', '江都市', 118, 0, 0, 'Jiangdu Shi', 'JDU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1278, '321101', '市辖区', 119, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1279, '321102', '京口区', 119, 0, 0, 'Jingkou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1280, '321111', '润州区', 119, 0, 0, 'Runzhou Qu', 'RZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1281, '321112', '丹徒区', 119, 0, 0, 'Dantu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1282, '321181', '丹阳市', 119, 0, 0, 'Danyang Xian', 'DNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1283, '321182', '扬中市', 119, 0, 0, 'Yangzhong Shi', 'YZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1284, '321183', '句容市', 119, 0, 0, 'Jurong Shi', 'JRG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1285, '321201', '市辖区', 120, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1286, '321202', '海陵区', 120, 0, 0, 'Hailing Qu', 'HIL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1287, '321203', '高港区', 120, 0, 0, 'Gaogang Qu', 'GGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1288, '321281', '兴化市', 120, 0, 0, 'Xinghua Shi', 'XHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1289, '321282', '靖江市', 120, 0, 0, 'Jingjiang Shi', 'JGJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1290, '321283', '泰兴市', 120, 0, 0, 'Taixing Shi', 'TXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1291, '321284', '姜堰市', 120, 0, 0, 'Jiangyan Shi', 'JYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1292, '321301', '市辖区', 121, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1293, '321302', '宿城区', 121, 0, 0, 'Sucheng Qu', 'SCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1294, '321311', '宿豫区', 121, 0, 0, 'Suyu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1295, '321322', '沭阳县', 121, 0, 0, 'Shuyang Xian', 'SYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1296, '321323', '泗阳县', 121, 0, 0, 'Siyang Xian ', 'SIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1298, '330101', '市辖区', 122, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1299, '330102', '上城区', 122, 0, 0, 'Shangcheng Qu', 'SCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1300, '330103', '下城区', 122, 0, 0, 'Xiacheng Qu', 'XCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1302, '330105', '拱墅区', 122, 0, 0, 'Gongshu Qu', 'GSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1303, '330106', '西湖区', 122, 0, 0, 'Xihu Qu ', 'XHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1304, '330108', '滨江区', 122, 0, 0, 'Binjiang Qu', 'BJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1306, '330110', '余杭区', 122, 0, 0, 'Yuhang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1307, '330122', '桐庐县', 122, 0, 0, 'Tonglu Xian', 'TLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1308, '330127', '淳安县', 122, 0, 0, 'Chun,an Xian', 'CAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1310, '330183', '富阳市', 122, 0, 0, 'Fuyang Shi', 'FYZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1311, '330185', '临安市', 122, 0, 0, 'Lin,an Shi', 'LNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1312, '330201', '市辖区', 123, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1314, '330204', '江东区', 123, 0, 0, 'Jiangdong Qu', 'JDO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1315, '330205', '江北区', 123, 0, 0, 'Jiangbei Qu', 'JBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1318, '330212', '鄞州区', 123, 0, 0, 'Yinzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1319, '330225', '象山县', 123, 0, 0, 'Xiangshan Xian', 'YSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1320, '330226', '宁海县', 123, 0, 0, 'Ninghai Xian', 'NHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1323, '330283', '奉化市', 123, 0, 0, 'Fenghua Shi', 'FHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1324, '330301', '市辖区', 124, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1326, '330303', '龙湾区', 124, 0, 0, 'Longwan Qu', 'LWW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1327, '330304', '瓯海区', 124, 0, 0, 'Ouhai Qu', 'OHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1330, '330326', '平阳县', 124, 0, 0, 'Pingyang Xian', 'PYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1331, '330327', '苍南县', 124, 0, 0, 'Cangnan Xian', 'CAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1334, '330381', '瑞安市', 124, 0, 0, 'Rui,an Xian', 'RAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1335, '330382', '乐清市', 124, 0, 0, 'Yueqing Shi', 'YQZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1336, '330401', '市辖区', 125, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1338, '330411', '秀洲区', 125, 0, 0, 'Xiuzhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1340, '330424', '海盐县', 125, 0, 0, 'Haiyan Xian', 'HYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1342, '330482', '平湖市', 125, 0, 0, 'Pinghu Shi', 'PHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1343, '330483', '桐乡市', 125, 0, 0, 'Tongxiang Shi', 'TXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1344, '330501', '市辖区', 126, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1346, '330503', '南浔区', 126, 0, 0, 'Nanxun Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1348, '330522', '长兴县', 126, 0, 0, 'Changxing Xian', 'CXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1350, '330601', '市辖区', 127, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1351, '330602', '越城区', 127, 0, 0, 'Yuecheng Qu', 'YSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1354, '330681', '诸暨市', 127, 0, 0, 'Zhuji Shi', 'ZHJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1355, '330682', '上虞市', 127, 0, 0, 'Shangyu Shi', 'SYZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1358, '330702', '婺城区', 128, 0, 0, 'Wucheng Qu', 'WCF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1359, '330703', '金东区', 128, 0, 0, 'Jindong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1360, '330723', '武义县', 128, 0, 0, 'Wuyi Xian', 'WYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1362, '330727', '磐安县', 128, 0, 0, 'Pan,an Xian', 'PAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1364, '330782', '义乌市', 128, 0, 0, 'Yiwu Shi', 'YWS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1366, '330784', '永康市', 128, 0, 0, 'Yongkang Shi', 'YKG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1367, '330801', '市辖区', 129, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1368, '330802', '柯城区', 129, 0, 0, 'Kecheng Qu', 'KEC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1371, '330824', '开化县', 129, 0, 0, 'Kaihua Xian', 'KHU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1372, '330825', '龙游县', 129, 0, 0, 'Longyou Xian ', 'LGY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1374, '330901', '市辖区', 130, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1376, '330903', '普陀区', 130, 0, 0, 'Putuo Qu', 'PTO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1378, '330922', '嵊泗县', 130, 0, 0, 'Shengsi Xian', 'SSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1379, '331001', '市辖区', 131, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1380, '331002', '椒江区', 131, 0, 0, 'Jiaojiang Qu', 'JJT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1383, '331021', '玉环县', 131, 0, 0, 'Yuhuan Xian', 'YHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1384, '331022', '三门县', 131, 0, 0, 'Sanmen Xian', 'SMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1386, '331024', '仙居县', 131, 0, 0, 'Xianju Xian', 'XJU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1388, '331082', '临海市', 131, 0, 0, 'Linhai Shi', 'LHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1390, '331102', '莲都区', 132, 0, 0, 'Liandu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1391, '331121', '青田县', 132, 0, 0, 'Qingtian Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1394, '331124', '松阳县', 132, 0, 0, 'Songyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1395, '331125', '云和县', 132, 0, 0, 'Yunhe Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1398, '331181', '龙泉市', 132, 0, 0, 'Longquan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1399, '340101', '市辖区', 133, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1400, '340102', '瑶海区', 133, 0, 0, 'Yaohai Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1401, '340103', '庐阳区', 133, 0, 0, 'Luyang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1402, '340104', '蜀山区', 133, 0, 0, 'Shushan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1404, '340121', '长丰县', 133, 0, 0, 'Changfeng Xian', 'CFG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1406, '340123', '肥西县', 133, 0, 0, 'Feixi Xian', 'FIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1408, '340202', '镜湖区', 1412, 0, 0, 'Jinghu Qu', 'JHW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1409, '340208', '三山区', 1412, 0, 0, 'Matang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1412, '340200', '芜湖市', 134, 0, 0, 'Wuhu Shi', 'WHI');
commit;
prompt 2900 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1413, '340222', '繁昌县', 1412, 0, 0, 'Fanchang Xian', 'FCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1415, '340301', '市辖区', 135, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1416, '340302', '龙子湖区', 135, 0, 0, 'Longzihu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1417, '340303', '蚌山区', 135, 0, 0, 'Bangshan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1418, '340304', '禹会区', 135, 0, 0, 'Yuhui Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1419, '340311', '淮上区', 135, 0, 0, 'Huaishang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1420, '340321', '怀远县', 135, 0, 0, 'Huaiyuan Qu', 'HYW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1421, '340322', '五河县', 135, 0, 0, 'Wuhe Xian', 'WHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1422, '340323', '固镇县', 135, 0, 0, 'Guzhen Xian', 'GZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1423, '340401', '市辖区', 136, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (71, '210100', '沈阳市', 7, 0, 0, 'Shenyang Shi', 'SHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (72, '210200', '大连市', 7, 0, 0, 'Dalian Shi', 'DLC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (73, '210300', '鞍山市', 7, 0, 0, 'AnShan Shi', 'ASN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (74, '210400', '抚顺市', 7, 0, 0, 'Fushun Shi', 'FSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (75, '210500', '本溪市', 7, 0, 0, 'Benxi Shi', 'BXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (76, '210600', '丹东市', 7, 0, 0, 'Dandong Shi', 'DDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (77, '210700', '锦州市', 7, 0, 0, 'Jinzhou Shi', 'JNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (78, '210800', '营口市', 7, 0, 0, 'Yingkou Shi', 'YIK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (79, '210900', '阜新市', 7, 0, 0, 'Fuxin Shi', 'FXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (80, '211000', '辽阳市', 7, 0, 0, 'Liaoyang Shi', 'LYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (81, '211100', '盘锦市', 7, 0, 0, 'Panjin Shi', 'PJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (82, '211200', '铁岭市', 7, 0, 0, 'Tieling Shi', 'TLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (83, '211300', '朝阳市', 7, 0, 0, 'Chaoyang Shi', 'CYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (84, '211400', '葫芦岛市', 7, 0, 0, 'Huludao Shi', 'HLD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (85, '220100', '长春市', 8, 0, 0, 'Changchun Shi ', 'CGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (86, '220200', '吉林市', 8, 0, 0, 'Jilin Shi ', 'JLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (87, '220300', '四平市', 8, 0, 0, 'Siping Shi', 'SPS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (88, '220400', '辽源市', 8, 0, 0, 'Liaoyuan Shi', 'LYH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (89, '220500', '通化市', 8, 0, 0, 'Tonghua Shi', 'THS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (90, '220600', '白山市', 8, 0, 0, 'Baishan Shi', 'BSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (91, '220700', '松原市', 8, 0, 0, 'Songyuan Shi', 'SYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (92, '220800', '白城市', 8, 0, 0, 'Baicheng Shi', 'BCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (93, '222400', '延边朝鲜族自治州', 8, 0, 0, 'Yanbian Chosenzu Zizhizhou', 'YBZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (94, '230100', '哈尔滨市', 9, 0, 0, 'Harbin Shi', 'HRB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (95, '230200', '齐齐哈尔市', 9, 0, 0, 'Qiqihar Shi', 'NDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (96, '230300', '鸡西市', 9, 0, 0, 'Jixi Shi', 'JXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (97, '230400', '鹤岗市', 9, 0, 0, 'Hegang Shi', 'HEG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (98, '230500', '双鸭山市', 9, 0, 0, 'Shuangyashan Shi', 'SYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (99, '230600', '大庆市', 9, 0, 0, 'Daqing Shi', 'DQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (100, '230700', '伊春市', 9, 0, 0, 'Yichun Shi', 'YCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (101, '230800', '佳木斯市', 9, 0, 0, 'Jiamusi Shi', 'JMU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (102, '230900', '七台河市', 9, 0, 0, 'Qitaihe Shi', 'QTH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (103, '231000', '牡丹江市', 9, 0, 0, 'Mudanjiang Shi', 'MDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (104, '231100', '黑河市', 9, 0, 0, 'Heihe Shi', 'HEK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (105, '231200', '绥化市', 9, 0, 0, 'Suihua Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (106, '232700', '大兴安岭地区', 9, 0, 0, 'Da Hinggan Ling Diqu', 'DHL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (107, '310100', '市辖区', 10, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (108, '310200', '县', 10, 0, 0, 'Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (110, '320200', '无锡市', 11, 0, 0, 'Wuxi Shi', 'WUX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (111, '320300', '徐州市', 11, 0, 0, 'Xuzhou Shi', 'XUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (113, '320500', '苏州市', 11, 0, 0, 'Suzhou Shi', 'SZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (114, '320600', '南通市', 11, 0, 0, 'Nantong Shi', 'NTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (115, '320700', '连云港市', 11, 0, 0, 'Lianyungang Shi', 'LYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (117, '320900', '盐城市', 11, 0, 0, 'Yancheng Shi', 'YCK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (118, '321000', '扬州市', 11, 0, 0, 'Yangzhou Shi', 'YZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (119, '321100', '镇江市', 11, 0, 0, 'Zhenjiang Shi', 'ZHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (121, '321300', '宿迁市', 11, 0, 0, 'Suqian Shi', 'SUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (122, '330100', '杭州市', 12, 0, 0, 'Hangzhou Shi', 'HGH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1, '中国', '中国', 0, 0, 0, 'Zhong Guo', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2, '110000', '北京市', 1, 0, 0, 'Beijing Shi', 'BJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3, '120000', '天津市', 1, 0, 0, 'Tianjin Shi', 'TJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4, '130000', '河北省', 1, 0, 0, 'Hebei Sheng', 'HE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (5, '140000', '山西省', 1, 0, 0, 'Shanxi Sheng ', 'SX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (6, '150000', '内蒙古自治区', 1, 0, 0, 'Nei Mongol Zizhiqu', 'NM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (8, '220000', '吉林省', 1, 0, 0, 'Jilin Sheng', 'JL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (9, '230000', '黑龙江省', 1, 0, 0, 'Heilongjiang Sheng', 'HL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (10, '310000', '上海市', 1, 0, 0, 'Shanghai Shi', 'SH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (12, '330000', '浙江省', 1, 0, 0, 'Zhejiang Sheng', 'ZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (13, '340000', '安徽省', 1, 0, 0, 'Anhui Sheng', 'AH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (14, '350000', '福建省', 1, 0, 0, 'Fujian Sheng ', 'FJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (16, '370000', '山东省', 1, 0, 0, 'Shandong Sheng ', 'SD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (17, '410000', '河南省', 1, 0, 0, 'Henan Sheng', 'HA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (18, '420000', '湖北省', 1, 0, 0, 'Hubei Sheng', 'HB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (20, '440000', '广东省', 1, 0, 0, 'Guangdong Sheng', 'GD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (251, '445200', '揭阳市', 20, 0, 0, 'Jieyang Shi', 'JIY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (252, '445300', '云浮市', 20, 0, 0, 'Yunfu Shi', 'YFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (253, '450100', '南宁市', 21, 0, 0, 'Nanning Shi', 'NNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (254, '450200', '柳州市', 21, 0, 0, 'Liuzhou Shi', 'LZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (255, '450300', '桂林市', 21, 0, 0, 'Guilin Shi', 'KWL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (256, '450400', '梧州市', 21, 0, 0, 'Wuzhou Shi', 'WUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (257, '450500', '北海市', 21, 0, 0, 'Beihai Shi', 'BHY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (258, '450600', '防城港市', 21, 0, 0, 'Fangchenggang Shi', 'FAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (259, '450700', '钦州市', 21, 0, 0, 'Qinzhou Shi', 'QZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (260, '450800', '贵港市', 21, 0, 0, 'Guigang Shi', 'GUG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (261, '450900', '玉林市', 21, 0, 0, 'Yulin Shi', 'YUL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (262, '451000', '百色市', 21, 0, 0, 'Baise Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (263, '451100', '贺州市', 21, 0, 0, 'Hezhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (264, '451200', '河池市', 21, 0, 0, 'Hechi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (265, '451300', '来宾市', 21, 0, 0, 'Laibin Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (266, '451400', '崇左市', 21, 0, 0, 'Chongzuo Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (267, '460100', '海口市', 22, 0, 0, 'Haikou Shi', 'HAK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (268, '460200', '三亚市', 22, 0, 0, 'Sanya Shi', 'SYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (269, '469000', '省直辖县级行政区划', 22, 0, 0, 'shengzhixiaxianjixingzhengquhua', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (270, '500100', '市辖区', 23, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (271, '500200', '县', 23, 0, 0, 'Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (273, '510100', '成都市', 24, 0, 0, 'Chengdu Shi', 'CTU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (274, '510300', '自贡市', 24, 0, 0, 'Zigong Shi', 'ZGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (276, '510500', '泸州市', 24, 0, 0, 'Luzhou Shi', 'LUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (278, '510700', '绵阳市', 24, 0, 0, 'Mianyang Shi', 'MYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (279, '510800', '广元市', 24, 0, 0, 'Guangyuan Shi', 'GYC');
commit;
prompt 3000 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (281, '511000', '内江市', 24, 0, 0, 'Neijiang Shi', 'NJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (282, '511100', '乐山市', 24, 0, 0, 'Leshan Shi', 'LES');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (285, '511500', '宜宾市', 24, 0, 0, 'Yibin Shi', 'YBS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (286, '511600', '广安市', 24, 0, 0, 'Guang,an Shi', 'GAC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (287, '511700', '达州市', 24, 0, 0, 'Dazhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (288, '511800', '雅安市', 24, 0, 0, 'Ya,an Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (21, '450000', '广西壮族自治区', 1, 0, 0, 'Guangxi Zhuangzu Zizhiqu', 'GX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (24, '510000', '四川省', 1, 0, 0, 'Sichuan Sheng', 'SC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (26, '530000', '云南省', 1, 0, 0, 'Yunnan Sheng', 'YN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (27, '540000', '西藏自治区', 1, 0, 0, 'Xizang Zizhiqu', 'XZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (29, '620000', '甘肃省', 1, 0, 0, 'Gansu Sheng', 'GS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (31, '640000', '宁夏回族自治区', 1, 0, 0, 'Ningxia Huizu Zizhiqu', 'NX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (32, '650000', '新疆维吾尔自治区', 1, 0, 0, 'Xinjiang Uygur Zizhiqu', 'XJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (33, '110100', '市辖区', 2, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (34, '110200', '县', 2, 0, 0, 'Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (35, '120100', '市辖区', 3, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (36, '120200', '县', 3, 0, 0, 'Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (38, '130200', '唐山市', 4, 0, 0, 'Tangshan Shi', 'TGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (39, '130300', '秦皇岛市', 4, 0, 0, 'Qinhuangdao Shi', 'SHP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (40, '130400', '邯郸市', 4, 0, 0, 'Handan Shi', 'HDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (42, '130600', '保定市', 4, 0, 0, 'Baoding Shi', 'BDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (43, '130700', '张家口市', 4, 0, 0, 'Zhangjiakou Shi ', 'ZJK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (45, '130900', '沧州市', 4, 0, 0, 'Cangzhou Shi', 'CGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (46, '131000', '廊坊市', 4, 0, 0, 'Langfang Shi', 'LFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (48, '140100', '太原市', 5, 0, 0, 'Taiyuan Shi', 'TYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (49, '140200', '大同市', 5, 0, 0, 'Datong Shi ', 'DTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (51, '140400', '长治市', 5, 0, 0, 'Changzhi Shi', 'CZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (52, '140500', '晋城市', 5, 0, 0, 'Jincheng Shi ', 'JCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (54, '140700', '晋中市', 5, 0, 0, 'Jinzhong Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (55, '140800', '运城市', 5, 0, 0, 'Yuncheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (56, '140900', '忻州市', 5, 0, 0, 'Xinzhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (58, '141100', '吕梁市', 5, 0, 0, 'Lvliang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (59, '150100', '呼和浩特市', 6, 0, 0, 'Hohhot Shi', 'Hhht');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (60, '150200', '包头市', 6, 0, 0, 'Baotou Shi ', 'BTS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (62, '150400', '赤峰市', 6, 0, 0, 'Chifeng (Ulanhad)Shi', 'CFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (64, '150600', '鄂尔多斯市', 6, 0, 0, 'Eerduosi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (65, '150700', '呼伦贝尔市', 6, 0, 0, 'Hulunbeier Shi ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (66, '150800', '巴彦淖尔市', 6, 0, 0, 'Bayannaoer Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (67, '150900', '乌兰察布市', 6, 0, 0, 'Wulanchabu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (68, '152200', '兴安盟', 6, 0, 0, 'Hinggan Meng', 'HIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (69, '152500', '锡林郭勒盟', 6, 0, 0, 'Xilin Gol Meng', 'XGO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (124, '330300', '温州市', 12, 0, 0, 'Wenzhou Shi', 'WNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (125, '330400', '嘉兴市', 12, 0, 0, 'Jiaxing Shi', 'JIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (126, '330500', '湖州市', 12, 0, 0, 'Huzhou Shi ', 'HZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (129, '330800', '衢州市', 12, 0, 0, 'Quzhou Shi', 'QUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (130, '330900', '舟山市', 12, 0, 0, 'Zhoushan Shi', 'ZOS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (133, '340100', '合肥市', 13, 0, 0, 'Hefei Shi', 'HFE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (134, '340200', '芜湖市', 13, 0, 0, 'Wuhu Shi', 'WHI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (136, '340400', '淮南市', 13, 0, 0, 'Huainan Shi', 'HNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (139, '340700', '铜陵市', 13, 0, 0, 'Tongling Shi', 'TOL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (140, '340800', '安庆市', 13, 0, 0, 'Anqing Shi', 'AQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (143, '341200', '阜阳市', 13, 0, 0, 'Fuyang Shi', 'FYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (144, '341300', '宿州市', 13, 0, 0, 'Suzhou Shi', 'SUZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (145, '341400', '巢湖市', 13, 0, 0, 'Chaohu Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (149, '341800', '宣城市', 13, 0, 0, 'Xuancheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (151, '350200', '厦门市', 14, 0, 0, 'Xiamen Shi', 'XMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (152, '350300', '莆田市', 14, 0, 0, 'Putian Shi', 'PUT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (155, '350600', '漳州市', 14, 0, 0, 'Zhangzhou Shi', 'ZZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (156, '350700', '南平市', 14, 0, 0, 'Nanping Shi', 'NPS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (159, '360100', '南昌市', 15, 0, 0, 'Nanchang Shi', 'KHN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (160, '360200', '景德镇市', 15, 0, 0, 'Jingdezhen Shi', 'JDZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (163, '360500', '新余市', 15, 0, 0, 'Xinyu Shi', 'XYU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (165, '360700', '赣州市', 15, 0, 0, 'Ganzhou Shi', 'GZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (166, '360800', '吉安市', 15, 0, 0, 'Ji,an Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (169, '361100', '上饶市', 15, 0, 0, 'Shangrao Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (170, '370100', '济南市', 16, 0, 0, 'Jinan Shi', 'TNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (173, '370400', '枣庄市', 16, 0, 0, 'Zaozhuang Shi', 'ZZG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (174, '370500', '东营市', 16, 0, 0, 'Dongying Shi', 'DYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (177, '370800', '济宁市', 16, 0, 0, 'Jining Shi', 'JNG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (178, '370900', '泰安市', 16, 0, 0, 'Tai,an Shi', 'TAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (179, '371000', '威海市', 16, 0, 0, 'Weihai Shi', 'WEH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (182, '371300', '临沂市', 16, 0, 0, 'Linyi Shi', 'LYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (184, '371500', '聊城市', 16, 0, 0, 'Liaocheng Shi', 'LCH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (188, '410200', '开封市', 17, 0, 0, 'Kaifeng Shi', 'KFS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (189, '410300', '洛阳市', 17, 0, 0, 'Luoyang Shi', 'LYA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (192, '410600', '鹤壁市', 17, 0, 0, 'Hebi Shi', 'HBS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (193, '410700', '新乡市', 17, 0, 0, 'Xinxiang Shi', 'XXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (195, '410900', '濮阳市', 17, 0, 0, 'Puyang Shi', 'PYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (197, '411100', '漯河市', 17, 0, 0, 'Luohe Shi', 'LHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (199, '411300', '南阳市', 17, 0, 0, 'Nanyang Shi', 'NYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (200, '411400', '商丘市', 17, 0, 0, 'Shangqiu Shi', 'SQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (203, '411700', '驻马店市', 17, 0, 0, 'Zhumadian Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (204, '420100', '武汉市', 18, 0, 0, 'Wuhan Shi', 'WUH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3213, '610723', '洋县', 332, 0, 0, 'Yang Xian', 'YGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (207, '420500', '宜昌市', 18, 0, 0, 'Yichang Shi', 'YCO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (208, '420600', '襄樊市', 18, 0, 0, 'Xiangfan Shi', 'XFN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (209, '420700', '鄂州市', 18, 0, 0, 'Ezhou Shi', 'EZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (211, '420900', '孝感市', 18, 0, 0, 'Xiaogan Shi', 'XGE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (212, '421000', '荆州市', 18, 0, 0, 'Jingzhou Shi', 'JGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (214, '421200', '咸宁市', 18, 0, 0, 'Xianning Xian', 'XNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (215, '421300', '随州市', 18, 0, 0, 'Suizhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (217, '429000', '省直辖县级行政区划', 18, 0, 0, 'shengzhixiaxianjixingzhengquhua', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (218, '430100', '长沙市', 19, 0, 0, 'Changsha Shi', 'CSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (219, '430200', '株洲市', 19, 0, 0, 'Zhuzhou Shi', 'ZZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (220, '430300', '湘潭市', 19, 0, 0, 'Xiangtan Shi', 'XGT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (222, '430500', '邵阳市', 19, 0, 0, 'Shaoyang Shi', 'SYR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (223, '430600', '岳阳市', 19, 0, 0, 'Yueyang Shi', 'YYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (225, '430800', '张家界市', 19, 0, 0, 'Zhangjiajie Shi', 'ZJJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (226, '430900', '益阳市', 19, 0, 0, 'Yiyang Shi', 'YYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (227, '431000', '郴州市', 19, 0, 0, 'Chenzhou Shi', 'CNZ');
commit;
prompt 3100 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (229, '431200', '怀化市', 19, 0, 0, 'Huaihua Shi', 'HHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (230, '431300', '娄底市', 19, 0, 0, 'Loudi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (232, '440100', '广州市', 20, 0, 0, 'Guangzhou Shi', 'CAN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (233, '440200', '韶关市', 20, 0, 0, 'Shaoguan Shi', 'HSC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (234, '440300', '深圳市', 20, 0, 0, 'Shenzhen Shi', 'SZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (235, '440400', '珠海市', 20, 0, 0, 'Zhuhai Shi', 'ZUH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (237, '440600', '佛山市', 20, 0, 0, 'Foshan Shi', 'FOS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (238, '440700', '江门市', 20, 0, 0, 'Jiangmen Shi', 'JMN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (239, '440800', '湛江市', 20, 0, 0, 'Zhanjiang Shi', 'ZHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (241, '441200', '肇庆市', 20, 0, 0, 'Zhaoqing Shi', 'ZQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (242, '441300', '惠州市', 20, 0, 0, 'Huizhou Shi', 'HUI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (243, '441400', '梅州市', 20, 0, 0, 'Meizhou Shi', 'MXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (245, '441600', '河源市', 20, 0, 0, 'Heyuan Shi', 'HEY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (246, '441700', '阳江市', 20, 0, 0, 'Yangjiang Shi', 'YJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (247, '441800', '清远市', 20, 0, 0, 'Qingyuan Shi', 'QYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (249, '442000', '中山市', 20, 0, 0, 'Zhongshan Shi', 'ZSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (250, '445100', '潮州市', 20, 0, 0, 'Chaozhou Shi', 'CZY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (290, '512000', '资阳市', 24, 0, 0, 'Ziyang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (291, '513200', '阿坝藏族羌族自治州', 24, 0, 0, 'Aba(Ngawa) Zangzu Qiangzu Zizhizhou', 'ABA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (292, '513300', '甘孜藏族自治州', 24, 0, 0, 'Garze Zangzu Zizhizhou', 'GAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (293, '513400', '凉山彝族自治州', 24, 0, 0, 'Liangshan Yizu Zizhizhou', 'LSY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (294, '520100', '贵阳市', 25, 0, 0, 'Guiyang Shi', 'KWE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (295, '520200', '六盘水市', 25, 0, 0, 'Liupanshui Shi', 'LPS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (296, '520300', '遵义市', 25, 0, 0, 'Zunyi Shi', 'ZNY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (297, '520400', '安顺市', 25, 0, 0, 'Anshun Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (298, '522200', '铜仁地区', 25, 0, 0, 'Tongren Diqu', 'TRD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (299, '522300', '黔西南布依族苗族自治州', 25, 0, 0, 'Qianxinan Buyeizu Zizhizhou', 'QXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (300, '522400', '毕节地区', 25, 0, 0, 'Bijie Diqu', 'BJD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (302, '522700', '黔南布依族苗族自治州', 25, 0, 0, 'Qiannan Buyeizu Miaozu Zizhizhou', 'QNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (303, '530100', '昆明市', 26, 0, 0, 'Kunming Shi', 'KMG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (304, '530300', '曲靖市', 26, 0, 0, 'Qujing Shi', 'QJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (305, '530400', '玉溪市', 26, 0, 0, 'Yuxi Shi', 'YXS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (306, '530500', '保山市', 26, 0, 0, 'Baoshan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (307, '530600', '昭通市', 26, 0, 0, 'Zhaotong Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (308, '530700', '丽江市', 26, 0, 0, 'Lijiang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (309, '530800', '普洱市', 26, 0, 0, 'Simao Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (310, '530900', '临沧市', 26, 0, 0, 'Lincang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (311, '532300', '楚雄彝族自治州', 26, 0, 0, 'Chuxiong Yizu Zizhizhou', 'CXD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (312, '532500', '红河哈尼族彝族自治州', 26, 0, 0, 'Honghe Hanizu Yizu Zizhizhou', 'HHZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (313, '532600', '文山壮族苗族自治州', 26, 0, 0, 'Wenshan Zhuangzu Miaozu Zizhizhou', 'WSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (314, '532800', '西双版纳傣族自治州', 26, 0, 0, 'Xishuangbanna Daizu Zizhizhou', 'XSB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (315, '532900', '大理白族自治州', 26, 0, 0, 'Dali Baizu Zizhizhou', 'DLZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (316, '533100', '德宏傣族景颇族自治州', 26, 0, 0, 'Dehong Daizu Jingpozu Zizhizhou', 'DHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (317, '533300', '怒江傈僳族自治州', 26, 0, 0, 'Nujiang Lisuzu Zizhizhou', 'NUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (318, '533400', '迪庆藏族自治州', 26, 0, 0, 'Deqen Zangzu Zizhizhou', 'DEZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (319, '540100', '拉萨市', 27, 0, 0, 'Lhasa Shi', 'LXA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (320, '542100', '昌都地区', 27, 0, 0, 'Qamdo Diqu', 'QAD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (321, '542200', '山南地区', 27, 0, 0, 'Shannan Diqu', 'SND');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (322, '542300', '日喀则地区', 27, 0, 0, 'Xigaze Diqu', 'XID');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (324, '542500', '阿里地区', 27, 0, 0, 'Ngari Diqu', 'NGD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (325, '542600', '林芝地区', 27, 0, 0, 'Nyingchi Diqu', 'NYD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (326, '610100', '西安市', 28, 0, 0, 'Xi,an Shi', 'SIA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (327, '610200', '铜川市', 28, 0, 0, 'Tongchuan Shi', 'TCN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (328, '610300', '宝鸡市', 28, 0, 0, 'Baoji Shi', 'BJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (329, '610400', '咸阳市', 28, 0, 0, 'Xianyang Shi', 'XYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (330, '610500', '渭南市', 28, 0, 0, 'Weinan Shi', 'WNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (331, '610600', '延安市', 28, 0, 0, 'Yan,an Shi', 'YNA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (332, '610700', '汉中市', 28, 0, 0, 'Hanzhong Shi', 'HZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (333, '610800', '榆林市', 28, 0, 0, 'Yulin Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (334, '610900', '安康市', 28, 0, 0, 'Ankang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (335, '611000', '商洛市', 28, 0, 0, 'Shangluo Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (336, '620100', '兰州市', 29, 0, 0, 'Lanzhou Shi', 'LHW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (337, '620200', '嘉峪关市', 29, 0, 0, 'Jiayuguan Shi', 'JYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (338, '620300', '金昌市', 29, 0, 0, 'Jinchang Shi', 'JCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (339, '620400', '白银市', 29, 0, 0, 'Baiyin Shi', 'BYS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (340, '620500', '天水市', 29, 0, 0, 'Tianshui Shi', 'TSU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (341, '620600', '武威市', 29, 0, 0, 'Wuwei Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (342, '620700', '张掖市', 29, 0, 0, 'Zhangye Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (343, '620800', '平凉市', 29, 0, 0, 'Pingliang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (344, '620900', '酒泉市', 29, 0, 0, 'Jiuquan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (345, '621000', '庆阳市', 29, 0, 0, 'Qingyang Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (346, '621100', '定西市', 29, 0, 0, 'Dingxi Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (347, '621200', '陇南市', 29, 0, 0, 'Longnan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (348, '622900', '临夏回族自治州', 29, 0, 0, 'Linxia Huizu Zizhizhou ', 'LXH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (349, '623000', '甘南藏族自治州', 29, 0, 0, 'Gannan Zangzu Zizhizhou', 'GNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (350, '630100', '西宁市', 30, 0, 0, 'Xining Shi', 'XNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (351, '632100', '海东地区', 30, 0, 0, 'Haidong Diqu', 'HDD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (352, '632200', '海北藏族自治州', 30, 0, 0, 'Haibei Zangzu Zizhizhou', 'HBZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (353, '632300', '黄南藏族自治州', 30, 0, 0, 'Huangnan Zangzu Zizhizhou', 'HNZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (354, '632500', '海南藏族自治州', 30, 0, 0, 'Hainan Zangzu Zizhizhou', 'HNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (355, '632600', '果洛藏族自治州', 30, 0, 0, 'Golog Zangzu Zizhizhou', 'GOL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (356, '632700', '玉树藏族自治州', 30, 0, 0, 'Yushu Zangzu Zizhizhou', 'YSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (357, '632800', '海西蒙古族藏族自治州', 30, 0, 0, 'Haixi Mongolzu Zangzu Zizhizhou', 'HXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (358, '640100', '银川市', 31, 0, 0, 'Yinchuan Shi', 'INC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (359, '640200', '石嘴山市', 31, 0, 0, 'Shizuishan Shi', 'SZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (360, '640300', '吴忠市', 31, 0, 0, 'Wuzhong Shi', 'WZS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (361, '640400', '固原市', 31, 0, 0, 'Guyuan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (363, '650100', '乌鲁木齐市', 32, 0, 0, 'Urumqi Shi', 'URC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (364, '650200', '克拉玛依市', 32, 0, 0, 'Karamay Shi', 'KAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (365, '652100', '吐鲁番地区', 32, 0, 0, 'Turpan Diqu', 'TUD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (366, '652200', '哈密地区', 32, 0, 0, 'Hami(kumul) Diqu', 'HMD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (367, '652300', '昌吉回族自治州', 32, 0, 0, 'Changji Huizu Zizhizhou', 'CJZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (368, '652700', '博尔塔拉蒙古自治州', 32, 0, 0, 'Bortala Monglo Zizhizhou', 'BOR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (369, '652800', '巴音郭楞蒙古自治州', 32, 0, 0, 'bayinguolengmengguzizhizhou', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (370, '652900', '阿克苏地区', 32, 0, 0, 'Aksu Diqu', 'AKD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (371, '653000', '克孜勒苏柯尔克孜自治州', 32, 0, 0, 'Kizilsu Kirgiz Zizhizhou', 'KIZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (372, '653100', '喀什地区', 32, 0, 0, 'Kashi(Kaxgar) Diqu', 'KSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (373, '653200', '和田地区', 32, 0, 0, 'Hotan Diqu', 'HOD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (374, '654000', '伊犁哈萨克自治州', 32, 0, 0, 'Ili Kazak Zizhizhou', 'ILD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (375, '654200', '塔城地区', 32, 0, 0, 'Tacheng(Qoqek) Diqu', 'TCD');
commit;
prompt 3200 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (378, '110101', '东城区', 33, 0, 0, 'Dongcheng Qu', 'DCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (382, '110105', '朝阳区', 33, 0, 0, 'Chaoyang Qu', 'CYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (383, '110106', '丰台区', 33, 0, 0, 'Fengtai Qu', 'FTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (385, '110108', '海淀区', 33, 0, 0, 'Haidian Qu', 'HDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (386, '110109', '门头沟区', 33, 0, 0, 'Mentougou Qu', 'MTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (388, '110112', '通州区', 33, 0, 0, 'Tongzhou Qu', 'TZQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (389, '110113', '顺义区', 33, 0, 0, 'Shunyi Qu', 'SYI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (390, '110114', '昌平区', 33, 0, 0, 'Changping Qu', 'CP Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (392, '110116', '怀柔区', 33, 0, 0, 'Huairou Qu', 'HR Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (393, '110117', '平谷区', 33, 0, 0, 'Pinggu Qu', 'PG Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (395, '110229', '延庆县', 34, 0, 0, 'Yanqing Xian', 'YQX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (396, '120101', '和平区', 35, 0, 0, 'Heping Qu', 'HPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (397, '120102', '河东区', 35, 0, 0, 'Hedong Qu', 'HDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (398, '120103', '河西区', 35, 0, 0, 'Hexi Qu', 'HXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (399, '120104', '南开区', 35, 0, 0, 'Nankai Qu', 'NKQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (401, '120106', '红桥区', 35, 0, 0, 'Hongqiao Qu', 'HQO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (405, '120110', '东丽区', 35, 0, 0, 'Dongli Qu', 'DLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (406, '120111', '西青区', 35, 0, 0, 'Xiqing Qu', 'XQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (407, '120112', '津南区', 35, 0, 0, 'Jinnan Qu', 'JNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (409, '120114', '武清区', 35, 0, 0, 'Wuqing Qu', 'WQ Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (410, '120115', '宝坻区', 35, 0, 0, 'Baodi Qu', 'BDI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (412, '120223', '静海县', 36, 0, 0, 'Jinghai Xian', 'JHT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (413, '120225', '蓟县', 36, 0, 0, 'Ji Xian', 'JIT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (414, '130101', '市辖区', 37, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (415, '130102', '长安区', 37, 0, 0, 'Chang,an Qu', 'CAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (416, '130103', '桥东区', 37, 0, 0, 'Qiaodong Qu', 'QDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (417, '130104', '桥西区', 37, 0, 0, 'Qiaoxi Qu', 'QXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (418, '130105', '新华区', 37, 0, 0, 'Xinhua Qu', 'XHK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (419, '130107', '井陉矿区', 37, 0, 0, 'Jingxing Kuangqu', 'JXK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (422, '130123', '正定县', 37, 0, 0, 'Zhengding Xian', 'ZDJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (425, '130126', '灵寿县', 37, 0, 0, 'Lingshou Xian ', 'LSO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (426, '130127', '高邑县', 37, 0, 0, 'Gaoyi Xian', 'GYJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (429, '130130', '无极县', 37, 0, 0, 'Wuji Xian', 'WJI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (430, '130131', '平山县', 37, 0, 0, 'Pingshan Xian', 'PSH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (432, '130133', '赵县', 37, 0, 0, 'Zhao Xian', 'ZAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (434, '130182', '藁城市', 37, 0, 0, 'Gaocheng Shi', 'GCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (436, '130184', '新乐市', 37, 0, 0, 'Xinle Shi', 'XLE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (437, '130185', '鹿泉市', 37, 0, 0, 'Luquan Shi', 'LUQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (438, '130201', '市辖区', 38, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (441, '130204', '古冶区', 38, 0, 0, 'Guye Qu', 'GYE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (442, '130205', '开平区', 38, 0, 0, 'Kaiping Qu', 'KPQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (444, '130208', '丰润区', 38, 0, 0, 'Fengrun Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (445, '130223', '滦县', 38, 0, 0, 'Luan Xian', 'LUA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (448, '130227', '迁西县', 38, 0, 0, 'Qianxi Xian', 'QXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (449, '130229', '玉田县', 38, 0, 0, 'Yutian Xian', 'YTJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (452, '130283', '迁安市', 38, 0, 0, 'Qian,an Shi', 'QAS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (453, '130301', '市辖区', 39, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (454, '130302', '海港区', 39, 0, 0, 'Haigang Qu', 'HGG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (458, '130322', '昌黎县', 39, 0, 0, 'Changli Xian', 'CGL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (459, '130323', '抚宁县', 39, 0, 0, 'Funing Xian ', 'FUN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (460, '130324', '卢龙县', 39, 0, 0, 'Lulong Xian', 'LLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (461, '130401', '市辖区', 40, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (463, '130403', '丛台区', 40, 0, 0, 'Congtai Qu', 'CTQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (465, '130406', '峰峰矿区', 40, 0, 0, 'Fengfeng Kuangqu', 'FFK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (468, '130424', '成安县', 40, 0, 0, 'Cheng,an Xian', 'CAJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (469, '130425', '大名县', 40, 0, 0, 'Daming Xian', 'DMX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (471, '130427', '磁县', 40, 0, 0, 'Ci Xian', 'CIX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (473, '130429', '永年县', 40, 0, 0, 'Yongnian Xian', 'YON');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (474, '130430', '邱县', 40, 0, 0, 'Qiu Xian', 'QIU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (475, '130431', '鸡泽县', 40, 0, 0, 'Jize Xian', 'JZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (477, '130433', '馆陶县', 40, 0, 0, 'Guantao Xian', 'GTO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (478, '130434', '魏县', 40, 0, 0, 'Wei Xian ', 'WEI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (479, '130435', '曲周县', 40, 0, 0, 'Quzhou Xian ', 'QZX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (481, '130501', '市辖区', 41, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (482, '130502', '桥东区', 41, 0, 0, 'Qiaodong Qu', 'QDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (483, '130503', '桥西区', 41, 0, 0, 'Qiaoxi Qu', 'QXT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (485, '130522', '临城县', 41, 0, 0, 'Lincheng Xian ', 'LNC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (486, '130523', '内丘县', 41, 0, 0, 'Neiqiu Xian ', 'NQU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (487, '130524', '柏乡县', 41, 0, 0, 'Baixiang Xian', 'BXG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (489, '130526', '任县', 41, 0, 0, 'Ren Xian', 'REN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (490, '130527', '南和县', 41, 0, 0, 'Nanhe Xian', 'NHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (491, '130528', '宁晋县', 41, 0, 0, 'Ningjin Xian', 'NJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (493, '130530', '新河县', 41, 0, 0, 'Xinhe Xian ', 'XHJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (494, '130531', '广宗县', 41, 0, 0, 'Guangzong Xian ', 'GZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (495, '130532', '平乡县', 41, 0, 0, 'Pingxiang Xian', 'PXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (497, '130534', '清河县', 41, 0, 0, 'Qinghe Xian', 'QHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (498, '130535', '临西县', 41, 0, 0, 'Linxi Xian', 'LXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (500, '130582', '沙河市', 41, 0, 0, 'Shahe Shi', 'SHS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (501, '130601', '市辖区', 42, 0, 0, 'Shixiaqu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (502, '130600', '新市区', 42, 0, 0, 'Xinshi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (504, '130604', '南市区', 42, 0, 0, 'Nanshi Qu', 'NSB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (505, '130621', '满城县', 42, 0, 0, 'Mancheng Xian ', 'MCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (277, '510600', '德阳市', 24, 0, 0, 'Deyang Shi', 'DEY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (280, '510900', '遂宁市', 24, 0, 0, 'Suining Shi', 'SNS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (283, '511300', '南充市', 24, 0, 0, 'Nanchong Shi', 'NCO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (22, '460000', '海南省', 1, 0, 0, 'Hainan Sheng', 'HI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (28, '610000', '陕西省', 1, 0, 0, 'Shanxi Sheng ', 'SN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (37, '130100', '石家庄市', 4, 0, 0, 'Shijiazhuang Shi', 'SJW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (41, '130500', '邢台市', 4, 0, 0, 'Xingtai Shi', 'XTS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (44, '130800', '承德市', 4, 0, 0, 'Chengde Shi', 'CDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (47, '131100', '衡水市', 4, 0, 0, 'Hengshui Shi ', 'HGS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (50, '140300', '阳泉市', 5, 0, 0, 'Yangquan Shi', 'YQS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (53, '140600', '朔州市', 5, 0, 0, 'Shuozhou Shi ', 'SZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (57, '141000', '临汾市', 5, 0, 0, 'Linfen Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (61, '150300', '乌海市', 6, 0, 0, 'Wuhai Shi', 'WHM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (63, '150500', '通辽市', 6, 0, 0, 'Tongliao Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (70, '152900', '阿拉善盟', 6, 0, 0, 'Alxa Meng', 'ALM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (128, '330700', '金华市', 12, 0, 0, 'Jinhua Shi', 'JHA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (132, '331100', '丽水市', 12, 0, 0, 'Lishui Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (137, '340500', '马鞍山市', 13, 0, 0, 'Ma,anshan Shi', 'MAA');
commit;
prompt 3300 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (141, '341000', '黄山市', 13, 0, 0, 'Huangshan Shi', 'HSN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (147, '341600', '亳州市', 13, 0, 0, 'Bozhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (154, '350500', '泉州市', 14, 0, 0, 'Quanzhou Shi', 'QZJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (158, '350900', '宁德市', 14, 0, 0, 'Ningde Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (162, '360400', '九江市', 15, 0, 0, 'Jiujiang Shi', 'JIU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (167, '360900', '宜春市', 15, 0, 0, 'Yichun Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (171, '370200', '青岛市', 16, 0, 0, 'Qingdao Shi', 'TAO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (175, '370600', '烟台市', 16, 0, 0, 'Yantai Shi', 'YNT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (181, '371200', '莱芜市', 16, 0, 0, 'Laiwu Shi', 'LWS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (185, '371600', '滨州市', 16, 0, 0, 'Binzhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (190, '410400', '平顶山市', 17, 0, 0, 'Pingdingshan Shi', 'PDS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (196, '411000', '许昌市', 17, 0, 0, 'Xuchang Shi', 'XCS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (201, '411500', '信阳市', 17, 0, 0, 'Xinyang Shi', 'XYG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (205, '420200', '黄石市', 18, 0, 0, 'Huangshi Shi', 'HIS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (379, '110102', '西城区', 33, 0, 0, 'Xicheng Qu', 'XCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (384, '110107', '石景山区', 33, 0, 0, 'Shijingshan Qu', 'SJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (387, '110111', '房山区', 33, 0, 0, 'Fangshan Qu', 'FSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (391, '110115', '大兴区', 33, 0, 0, 'Daxing Qu', 'DX Q');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (394, '110228', '密云县', 34, 0, 0, 'Miyun Xian ', 'MYN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (400, '120105', '河北区', 35, 0, 0, 'Hebei Qu', 'HBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (404, '120116', '滨海新区', 35, 0, 0, 'Dagang Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (408, '120113', '北辰区', 35, 0, 0, 'Beichen Qu', 'BCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (411, '120221', '宁河县', 36, 0, 0, 'Ninghe Xian', 'NHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (421, '130121', '井陉县', 37, 0, 0, 'Jingxing Xian', 'JXJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (424, '130125', '行唐县', 37, 0, 0, 'Xingtang Xian', 'XTG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (428, '130129', '赞皇县', 37, 0, 0, 'Zanhuang Xian', 'ZHG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (433, '130181', '辛集市', 37, 0, 0, 'Xinji Shi', 'XJS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (440, '130203', '路北区', 38, 0, 0, 'Lubei Qu', 'LBQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (446, '130224', '滦南县', 38, 0, 0, 'Luannan Xian', 'LNJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (450, '130230', '唐海县', 38, 0, 0, 'Tanghai Xian ', 'THA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (456, '130304', '北戴河区', 39, 0, 0, 'Beidaihe Qu', 'BDH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (462, '130402', '邯山区', 40, 0, 0, 'Hanshan Qu', 'HHD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (466, '130421', '邯郸县', 40, 0, 0, 'Handan Xian ', 'HDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (470, '130426', '涉县', 40, 0, 0, 'She Xian', 'SEJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (587, '131121', '枣强县', 47, 0, 0, 'Zaoqiang Xian ', 'ZQJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (591, '131125', '安平县', 47, 0, 0, 'Anping Xian', 'APG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (594, '131128', '阜城县', 47, 0, 0, 'Fucheng Xian ', 'FCE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (598, '140105', '小店区', 48, 0, 0, 'Xiaodian Qu', 'XDQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (601, '140108', '尖草坪区', 48, 0, 0, 'Jiancaoping Qu', 'JCP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (605, '140122', '阳曲县', 48, 0, 0, 'Yangqu Xian ', 'YGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (611, '140211', '南郊区', 49, 0, 0, 'Nanjiao Qu', 'NJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (614, '140222', '天镇县', 49, 0, 0, 'Tianzhen Xian ', 'TZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (617, '140225', '浑源县', 49, 0, 0, 'Hunyuan Xian', 'HYM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (624, '140321', '平定县', 50, 0, 0, 'Pingding Xian', 'PDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (631, '140424', '屯留县', 51, 0, 0, 'Tunliu Xian', 'TNL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (634, '140427', '壶关县', 51, 0, 0, 'Huguan Xian', 'HGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (637, '140430', '沁县', 51, 0, 0, 'Qin Xian', 'QIN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (642, '140521', '沁水县', 52, 0, 0, 'Qinshui Xian', 'QSI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (644, '140524', '陵川县', 52, 0, 0, 'Lingchuan Xian', 'LGC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (649, '140603', '平鲁区', 53, 0, 0, 'Pinglu Qu', 'PLU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (652, '140623', '右玉县', 53, 0, 0, 'Youyu Xian ', 'YOY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (657, '140722', '左权县', 54, 0, 0, 'Zuoquan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (660, '140725', '寿阳县', 54, 0, 0, 'Shouyang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (664, '140729', '灵石县', 54, 0, 0, 'Lingshi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (670, '140823', '闻喜县', 55, 0, 0, 'Wenxi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (673, '140826', '绛县', 55, 0, 0, 'Jiang Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (676, '140829', '平陆县', 55, 0, 0, 'Pinglu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (679, '140882', '河津市', 55, 0, 0, 'Hejin Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (685, '140924', '繁峙县', 56, 0, 0, 'Fanshi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (688, '140927', '神池县', 56, 0, 0, 'Shenchi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (692, '140931', '保德县', 56, 0, 0, 'Baode Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (697, '141021', '曲沃县', 57, 0, 0, 'Quwo Xian ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (700, '141024', '洪洞县', 57, 0, 0, 'Hongtong Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (704, '141028', '吉县', 57, 0, 0, 'Ji Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (707, '141031', '隰县', 57, 0, 0, 'Xi Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (711, '141081', '侯马市', 57, 0, 0, 'Houma Shi ', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (868, '210381', '海城市', 73, 0, 0, 'Haicheng Shi', 'HCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (874, '210421', '抚顺县', 74, 0, 0, 'Fushun Xian', 'FSX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (880, '210504', '明山区', 75, 0, 0, 'Mingshan Qu', 'MSB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (883, '210522', '桓仁满族自治县', 75, 0, 0, 'Huanren Manzu Zizhixian', 'HRL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (888, '210624', '宽甸满族自治县', 76, 0, 0, 'Kuandian Manzu Zizhixian', 'KDN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (895, '210726', '黑山县', 77, 0, 0, 'Heishan Xian', 'HSL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (898, '210782', '北镇市', 77, 0, 0, 'Beining Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (904, '210881', '盖州市', 78, 0, 0, 'Gaizhou Shi', 'GZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (910, '210905', '清河门区', 79, 0, 0, 'Qinghemen Qu', 'QHM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1930, '410425', '郏县', 190, 0, 0, 'Jia Xian', 'JXY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (912, '210921', '阜新蒙古族自治县', 79, 0, 0, 'Fuxin Mongolzu Zizhixian', 'FXX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (919, '211011', '太子河区', 80, 0, 0, 'Taizihe Qu', 'TZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (923, '211102', '双台子区', 81, 0, 0, 'Shuangtaizi Qu', 'STZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (928, '211202', '银州区', 82, 0, 0, 'Yinzhou Qu', 'YZU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (932, '211224', '昌图县', 82, 0, 0, 'Changtu Xian', 'CTX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (937, '211303', '龙城区', 83, 0, 0, 'Longcheng Qu', 'LCL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (940, '211324', '喀喇沁左翼蒙古族自治县', 83, 0, 0, 'Harqin Zuoyi Mongolzu Zizhixian', 'HAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3461, '652901', '阿克苏市', 370, 0, 0, 'Aksu Shi', 'AKS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (756, '150422', '巴林左旗', 62, 0, 0, 'Bairin Zuoqi', 'BAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (817, '152221', '科尔沁右翼前旗', 68, 0, 0, 'Horqin Youyi Qianqi', 'HYQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2288, '431227', '新晃侗族自治县', 229, 0, 0, 'Xinhuang Dongzu Zizhixian', 'XHD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2426, '441825', '连山壮族瑶族自治县', 247, 0, 0, 'Lianshan Zhuangzu Yaozu Zizhixian', 'LSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2587, '469026', '昌江黎族自治县', 269, 0, 0, 'Changjiang Lizu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2598, '500104', '大渡口区', 270, 0, 0, 'Dadukou Qu', 'DDK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2629, '500242', '酉阳土家族苗族自治县', 271, 0, 0, 'Youyang Tujiazu Miaozu Zizhixian', 'YUY');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2868, '520423', '镇宁布依族苗族自治县', 297, 0, 0, 'Zhenning Buyeizu Miaozu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (2990, '530825', '镇沅彝族哈尼族拉祜族自治县', 309, 0, 0, 'Zhenyuan Yizu Hanizu Lahuzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3026, '532532', '河口瑶族自治县', 312, 0, 0, 'Hekou Yaozu Zizhixian', 'HKM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3304, '620923', '肃北蒙古族自治县', 344, 0, 0, 'Subei Monguzu Zizhixian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3439, '652222', '巴里坤哈萨克自治县', 366, 0, 0, 'Barkol Kazak Zizhixian', 'BAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (989, '220581', '梅河口市', 89, 0, 0, 'Meihekou Shi', 'MHK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1426, '340404', '谢家集区', 136, 0, 0, 'Xiejiaji Qu', 'XJJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (275, '510400', '攀枝花市', 24, 0, 0, 'Panzhihua Shi', 'PZH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (323, '542400', '那曲地区', 27, 0, 0, 'Nagqu Diqu', 'NAD');
commit;
prompt 3400 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (376, '654300', '阿勒泰地区', 32, 0, 0, 'Altay Diqu', 'ALD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (602, '140109', '万柏林区', 48, 0, 0, 'Wanbailin Qu', 'WBL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (755, '150421', '阿鲁科尔沁旗', 62, 0, 0, 'Ar Horqin Qi', 'AHO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (786, '150724', '鄂温克族自治旗', 65, 0, 0, 'Ewenkizu Zizhiqi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (818, '152222', '科尔沁右翼中旗', 68, 0, 0, 'Horqin Youyi Zhongqi', 'HYZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (867, '210323', '岫岩满族自治县', 73, 0, 0, 'Xiuyan Manzu Zizhixian', 'XYL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1898, '410204', '鼓楼区', 188, 0, 0, 'Gulou Qu', 'GLK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (301, '522600', '黔东南苗族侗族自治州', 25, 0, 0, 'Qiandongnan Miaozu Dongzu Zizhizhou', 'QND');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (284, '511400', '眉山市', 24, 0, 0, 'Meishan Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (148, '341700', '池州市', 13, 0, 0, 'Chizhou Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (362, '640500', '中卫市', 31, 0, 0, 'Zhongwei Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3216, '610726', '宁强县', 332, 0, 0, 'Ningqiang Xian', 'NQG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3220, '610730', '佛坪县', 332, 0, 0, 'Foping Xian', 'FPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3225, '610823', '横山县', 333, 0, 0, 'Hengshan Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3231, '610829', '吴堡县', 333, 0, 0, 'Wubu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3356, '630121', '大通回族土族自治县', 350, 0, 0, 'Datong Huizu Tuzu Zizhixian', 'DAT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3360, '632122', '民和回族土族自治县', 351, 0, 0, 'Minhe Huizu Tuzu Zizhixian', 'MHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3363, '632127', '化隆回族自治县', 351, 0, 0, 'Hualong Huizu Zizhixian', 'HLO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3366, '632222', '祁连县', 352, 0, 0, 'Qilian Xian', 'QLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3369, '632321', '同仁县', 353, 0, 0, 'Tongren Xian', 'TRN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3372, '632324', '河南蒙古族自治县', 353, 0, 0, 'Henan Mongolzu Zizhixian', 'HNM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3377, '632525', '贵南县', 354, 0, 0, 'Guinan Xian', 'GNN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3381, '632624', '达日县', 355, 0, 0, 'Tarlag Xian', 'TAR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3384, '632721', '玉树县', 356, 0, 0, 'Yushu Xian', 'YSK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3388, '632725', '囊谦县', 356, 0, 0, 'Nangqen Xian', 'NQN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3391, '632802', '德令哈市', 357, 0, 0, 'Delhi Shi', 'DEL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3399, '640121', '永宁县', 358, 0, 0, 'Yongning Xian', 'YGN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3403, '640202', '大武口区', 359, 0, 0, 'Dawukou Qu', 'DWK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3409, '640324', '同心县', 360, 0, 0, 'Tongxin Xian', 'TGX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3414, '640423', '隆德县', 361, 0, 0, 'Longde Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3419, '640521', '中宁县', 362, 0, 0, 'Zhongning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3425, '650105', '水磨沟区', 363, 0, 0, 'Shuimogou Qu', 'SMG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3431, '650202', '独山子区', 364, 0, 0, 'Dushanzi Qu', 'DSZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3435, '652101', '吐鲁番市', 365, 0, 0, 'Turpan Shi', 'TUR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3438, '652201', '哈密市', 366, 0, 0, 'Hami(kumul) Shi', 'HAM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3440, '652223', '伊吾县', 366, 0, 0, 'Yiwu(Araturuk) Xian', 'YWX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3444, '652323', '呼图壁县', 367, 0, 0, 'Hutubi Xian', 'HTB');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3448, '652328', '木垒哈萨克自治县', 367, 0, 0, 'Mori Kazak Zizhixian', 'MOR');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3451, '652723', '温泉县', 368, 0, 0, 'Wenquan(Arixang) Xian', 'WNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3454, '652823', '尉犁县', 369, 0, 0, 'Yuli(Lopnur) Xian', 'YLI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (3456, '652825', '且末县', 369, 0, 0, 'Qiemo(Qarqan) Xian', 'QMO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1057, '230303', '恒山区', 96, 0, 0, 'Hengshan Qu', 'HSD');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1063, '230381', '虎林市', 96, 0, 0, 'Hulin Shi', 'HUL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1071, '230407', '兴山区', 97, 0, 0, 'Xingshan Qu', 'XSQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1079, '230521', '集贤县', 98, 0, 0, 'Jixian Xian', 'JXH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1084, '230602', '萨尔图区', 99, 0, 0, 'Sairt Qu', 'SAI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1089, '230621', '肇州县', 99, 0, 0, 'Zhaozhou Xian', 'ZAZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1095, '230703', '南岔区', 100, 0, 0, 'Nancha Qu', 'NCQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1100, '230708', '美溪区', 100, 0, 0, 'Meixi Qu', 'MXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1104, '230712', '汤旺河区', 100, 0, 0, 'Tangwanghe Qu', 'TWH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1114, '230804', '前进区', 101, 0, 0, 'Qianjin Qu', 'QJQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1119, '230828', '汤原县', 101, 0, 0, 'Tangyuan Xian', 'TYX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1124, '230902', '新兴区', 102, 0, 0, 'Xinxing Qu', 'XXQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1130, '231003', '阳明区', 103, 0, 0, 'Yangming Qu', 'YMQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1135, '231081', '绥芬河市', 103, 0, 0, 'Suifenhe Shi', 'SFE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1138, '231085', '穆棱市', 103, 0, 0, 'Muling Shi', 'MLG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1143, '231124', '孙吴县', 104, 0, 0, 'Sunwu Xian', 'SUW');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1148, '231221', '望奎县', 105, 0, 0, 'Wangkui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1151, '231224', '庆安县', 105, 0, 0, 'Qing,an Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1155, '231282', '肇东市', 105, 0, 0, 'Zhaodong Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1159, '232723', '漠河县', 106, 0, 0, 'Mohe Xian', 'MOH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1163, '310105', '长宁区', 107, 0, 0, 'Changning Qu', 'CNQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1168, '310110', '杨浦区', 107, 0, 0, 'Yangpu Qu', 'YPU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1172, '310115', '浦东新区', 107, 0, 0, 'Pudong Xinqu', 'PDX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1180, '320102', '玄武区', 109, 0, 0, 'Xuanwu Qu', 'XWU');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1185, '320107', '下关区', 109, 0, 0, 'Xiaguan Qu', 'XGQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1534, '350182', '长乐市', 150, 0, 0, 'Changle Shi', 'CLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1540, '350212', '同安区', 151, 0, 0, 'Tong,an Qu', 'TAQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1547, '350322', '仙游县', 152, 0, 0, 'Xianyou Xian', 'XYF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1552, '350423', '清流县', 153, 0, 0, 'Qingliu Xian', 'QLX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1556, '350427', '沙县', 153, 0, 0, 'Sha Xian', 'SAX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1559, '350430', '建宁县', 153, 0, 0, 'Jianning Xian', 'JNF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1563, '350503', '丰泽区', 154, 0, 0, 'Fengze Qu', 'FZE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1568, '350525', '永春县', 154, 0, 0, 'Yongchun Xian', 'YCM');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1571, '350581', '石狮市', 154, 0, 0, 'Shishi Shi', 'SHH');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1575, '350602', '芗城区', 155, 0, 0, 'Xiangcheng Qu', 'XZZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1579, '350624', '诏安县', 155, 0, 0, 'Zhao,an Xian', 'ZAF');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1583, '350628', '平和县', 155, 0, 0, 'Pinghe Xian', 'PHE');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1588, '350721', '顺昌县', 156, 0, 0, 'Shunchang Xian', 'SCG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1594, '350782', '武夷山市', 156, 0, 0, 'Wuyishan Shi', 'WUS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1598, '350802', '新罗区', 157, 0, 0, 'Xinluo Qu', 'XNL');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1602, '350824', '武平县', 157, 0, 0, 'Wuping Xian', 'WPG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1607, '350921', '霞浦县', 158, 0, 0, 'Xiapu Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1611, '350925', '周宁县', 158, 0, 0, 'Zhouning Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1618, '360104', '青云谱区', 159, 0, 0, 'Qingyunpu Qu', 'QYP');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1622, '360122', '新建县', 159, 0, 0, 'Xinjian Xian', 'XJN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1627, '360203', '珠山区', 160, 0, 0, 'Zhushan Qu', 'ZSJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1632, '360313', '湘东区', 161, 0, 0, 'Xiangdong Qu', 'XDG');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1639, '360421', '九江县', 162, 0, 0, 'Jiujiang Xian', 'JUJ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1643, '360426', '德安县', 162, 0, 0, 'De,an Xian', 'DEA');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1316, '330206', '北仑区', 123, 0, 0, 'Beilun Qu', 'BLN');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1322, '330282', '慈溪市', 123, 0, 0, 'Cixi Shi', 'CXI');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1328, '330322', '洞头县', 124, 0, 0, 'Dongtou Xian', 'DTO');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1332, '330328', '文成县', 124, 0, 0, 'Wencheng Xian', 'WCZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1339, '330421', '嘉善县', 125, 0, 0, 'Jiashan Xian', 'JSK');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1347, '330521', '德清县', 126, 0, 0, 'Deqing Xian', 'DQX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1352, '330621', '绍兴县', 127, 0, 0, 'Shaoxing Xian', 'SXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1356, '330683', '嵊州市', 127, 0, 0, 'Shengzhou Shi', 'SGZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1363, '330781', '兰溪市', 128, 0, 0, 'Lanxi Shi', 'LXZ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1370, '330822', '常山县', 129, 0, 0, 'Changshan Xian', 'CSN');
commit;
prompt 3500 records committed...
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1375, '330902', '定海区', 130, 0, 0, 'Dinghai Qu', 'DHQ');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1382, '331004', '路桥区', 131, 0, 0, 'Luqiao Qu', 'LQT');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1387, '331081', '温岭市', 131, 0, 0, 'Wenling Shi', 'WLS');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (1392, '331122', '缙云县', 132, 0, 0, 'Jinyun Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4000, '620503', '麦积区', 340, 0, 0, 'Maiji Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4001, '500116', '江津区', 270, 0, 0, 'Jiangjin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4002, '500117', '合川区', 270, 0, 0, 'Hechuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4003, '500118', '永川区', 270, 0, 0, 'Yongchuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4004, '500119', '南川区', 270, 0, 0, 'Nanchuan Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4006, '340221', '芜湖县', 1412, 0, 0, 'Wuhu Xian', 'WHX');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4100, '232701', '加格达奇区', 106, 0, 0, 'Jiagedaqi Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4101, '232702', '松岭区', 106, 0, 0, 'Songling Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4102, '232703', '新林区', 106, 0, 0, 'Xinlin Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4103, '232704', '呼中区', 106, 0, 0, 'Huzhong Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4200, '330402', '南湖区', 125, 0, 0, 'Nanhu Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4300, '360482', '共青城市', 162, 0, 0, 'Gongqingcheng Shi', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4400, '640303', '红寺堡区', 360, 0, 0, 'Hongsibao Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4500, '620922', '瓜州县', 344, 0, 0, 'Guazhou Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4600, '421321', '随县', 215, 0, 0, 'Sui Xian', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4700, '431102', '零陵区', 228, 0, 0, 'Lingling Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4800, '451119', '平桂管理区', 263, 0, 0, 'Pingguiguanli Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (4900, '510802', '利州区', 279, 0, 0, 'Lizhou Qu', '2');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (5000, '511681', '华蓥市', 286, 0, 0, 'Huaying Shi', 'HYC');
insert into REGION (ID, CODE, NAME, PID, LEVE, ORDE, ENNAME, ENSHORTNAME)
values (377, '659000', '自治区直辖县级行政区划', 32, 0, 0, 'zizhiquzhixiaxianjixingzhengquhua', '2');
commit;
prompt 3524 records loaded
prompt Loading USERS...
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('beans.factory.support.De', 'godanerm', '1138829222@qq.com', '4297f44b13955235245b2497399d7a93', '123', 'beans.factory.support.De.jpg', -1, null, '下面是我程序中的功能代码，实现的主要功能是，当点击easyui-tree中的一个节点，则与该节点关联的文件,自动勾选上在easyui-datagrid在加载数据时，第一列为复选框，若没有，则用', 111, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('4297f44b13955235245b2497399d7a93', 'qweqawe', '123123@qq.com', '4297f44b13955235245b2497399d7a93', '123', '4297f44b13955235245b2497399d7a93.jpg', 1, null, '下面是我程下面是我程', 0, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('f4e5ba11-3372-447a-8608-b3a2aa9d7820', 'zhang', '123456@qq.com', '154f72d6224fe533433543559a3a8993', null, 'f4e5ba11-3372-447a-8608-b3a2aa9d7820.jpg', -1, to_date('05-09-2017', 'dd-mm-yyyy'), '123', 132, to_timestamp('22-09-2017 09:11:58.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 999999999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('1', 'zhangke', '22223@qq.com', '4297f44b13955235245b2497399d7a93', '123', '1.jpg', 0, to_date('26-09-2017', 'dd-mm-yyyy'), '下面是下面是我程我程', 999, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('5', 'asdwqeq', '78922@qq.com', '4297f44b13955235245b2497399d7a93', '123', '5.jpg', 1, null, '下面下面是我程下面是我程是我程下面是我程', 0, to_timestamp('15-09-2017 01:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('7', 'gudaner', '994476922@qq.com', '4297f44b13955235245b2497399d7a93', '123', '7.jpg', 0, to_date('30-09-2017', 'dd-mm-yyyy'), '下面是我程下面是我程', 0, to_timestamp('15-09-2012 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('9', 'qweqwe', '999922@qq.com', '4297f44b13955235245b2497399d7a93', '123', '9.gif', -1, null, '下面是我程下面是我程', 99, to_timestamp('15-09-2017 11:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('10', 'qeqweq', 'godaner@qq.com', '4297f44b13955235245b2497399d7a93', '123', '10.jpg', 0, to_date('17-12-1995', 'dd-mm-yyyy'), '我叫張可', 999, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('11', 'asdasda', '1111@qq.com', '4297f44b13955235245b2497399d7a93', null, '11.JPG', -1, to_date('20-09-2017', 'dd-mm-yyyy'), '下面是下面是我程我程', 0, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('0c5b83df-ffb7-422f-9043-903e4888bf11', 'zhangdake', '123@qq.com', '8bc323285020b169786d4a6a76175aae', null, '0c5b83df-ffb7-422f-9043-903e4888bf11.jpg', -1, to_date('05-09-2017', 'dd-mm-yyyy'), null, 123, to_timestamp('22-09-2017 08:17:31.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 9999);
insert into USERS (ID, USERNAME, EMAIL, PASSWORD, SALT, HEADIMG, SEX, BIRTHDAY, DESCRIPTION, SCORE, REGISTTIME, STATUS, MONEY)
values ('a37fa434-b5a1-43ca-b7dc-4a0402d978c4', 'admin', '11338829222@qq.com', '6867bca80e04848c7695540ef1a32bc0', null, 'a37fa434-b5a1-43ca-b7dc-4a0402d978c4.jpg', 1, to_date('17-12-1995', 'dd-mm-yyyy'), '我是张可', 9999, to_timestamp('21-09-2017 23:30:30.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 0, 0);
commit;
prompt 11 records loaded
prompt Loading ADDRS...
prompt Table is empty
prompt Loading ADMINS...
insert into ADMINS (ID, USERNAME, PASSWORD, SALT, STATUS, CREATETIME, CREATOR, THEME, EMAIL)
values ('1', '123', '4297f44b13955235245b2497399d7a93', '123', 1, to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, 'bootstrap', '1138829222@qq.com');
insert into ADMINS (ID, USERNAME, PASSWORD, SALT, STATUS, CREATETIME, CREATOR, THEME, EMAIL)
values ('3f7d8bf0-0945-48d5-b9fe-877ac48926b3', 'aaaaaa', 'aaaaaaaa', '1138829222@qq.com', 0, to_timestamp('22-09-2017 21:47:40.698000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'e6c309cb-9133-43ce-8f9a-136646b7a0f6', 'default', '29999222@qq.com');
insert into ADMINS (ID, USERNAME, PASSWORD, SALT, STATUS, CREATETIME, CREATOR, THEME, EMAIL)
values ('e6c309cb-9133-43ce-8f9a-136646b7a0f6', 'aaaaa', 'aaaaaaaa', '1138829222@qq.co', 0, to_timestamp('22-09-2017 21:50:20.026000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'default', '1138829222@qq.co');
insert into ADMINS (ID, USERNAME, PASSWORD, SALT, STATUS, CREATETIME, CREATOR, THEME, EMAIL)
values ('493169c8-cf9c-4d14-9d0e-d08af260a53a', 'zhangke', '5792cbd89b5fabf110ee301008ee7680', 'asdadd', 1, to_timestamp('23-09-2017 08:12:38.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'bootstrap', '1138829222@qq.com');
commit;
prompt 4 records loaded
prompt Loading ADMINS_LOGIN_LOG...
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('66ecf845-81cd-43a3-aef5-9abf907890e6', '1', '223.113.10.234', 'Windows', '1366*768', 'chrome 61.0.3163.79', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:06:45.216000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('f1f09c73-5af1-4a13-ac96-7e18291da4a6', '1', '223.113.10.234', 'Windows', '1366*768', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:09:15.039000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('f2d542cd-b8df-41be-94ca-09f9046e41bc', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:09:47.886000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('f3c4c98d-620c-4db8-8ce1-19cd7265e03b', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:09:53.306000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e79e7c9d-0134-48c7-84de-bb820582968f', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:09:59.993000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('44b75e78-01ca-40e8-8605-64415a97c849', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:41:18.235000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('6e0d9f6c-086d-4a72-b79d-b1924e307ec1', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:53:18.447000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9f7c6459-f4d7-443a-9114-a0382692e232', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 15:31:28.212000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('770dbf81-a792-46ff-8896-7da315be45af', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 15:37:05.409000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('1f3664cd-b8de-4ea5-a916-ca49e12ba3ad', '1', '223.113.10.234', 'Windows', '1280*720', 'chrome 49.0.2623.221', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:05:31.553000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('3f575f85-4772-4054-b644-666a29c4d2c8', '1', '223.113.10.234', 'Windows', '1280*720', 'chrome 49.0.2623.221', '中国', '江苏', '南通', to_timestamp('21-09-2017 11:05:49.487000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('3b8215b4-bd9c-47d4-a427-7cafc2682240', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 15:52:02.897000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a38db04e-d344-4bde-ad15-c737c92a61fe', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 16:11:42.080000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a76e8df7-d8b8-4bb8-8c78-bbc49ba6f760', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 16:13:27.292000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9f43dd07-7b19-4cd2-b8ec-277285862c81', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 17:22:48.865000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e4acdc69-ed26-4f8c-90e4-6f5913d1da4e', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 17:23:03.923000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('fda71611-01ed-4aeb-9a7b-8bb50d873990', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:07:26.936000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('169d3d0e-b744-4bbb-acaf-10f9732ebb83', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:11:17.389000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('4dc05b28-fec3-4504-8d35-5a2c396d11fa', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:23:31.607000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b2c59598-c2ae-4c51-b064-7792d458d493', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:24:50.905000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('21ea32e3-31ac-4fa7-b51d-608c701f9ff8', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:25:41.578000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('39f85cb8-227e-4b9e-b4c9-c8c6954d48d6', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 18:28:55.779000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9fe012fd-3c58-4bec-a422-075faa0cd568', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:00:30.538000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b99c39d2-95c9-49e3-b83e-d181091ac4ad', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:01:14.329000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9702c4bc-c586-4ab3-a093-1254171558d1', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:03:05.573000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e6e9f9f3-0791-40c2-86c1-6112b05f1013', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:37:38.614000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('5e54eb6d-cf65-44c6-b33c-fc10eb708bc5', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:37:55.800000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('57fafb72-6ece-461d-bbea-decdc6de39e8', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:47:09.326000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('f3a471b0-5c71-467b-bfeb-2e211993ee0f', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:53:22.460000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('7587b761-7624-4204-a666-1263782f6743', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:56:32.666000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('7773b04c-02ed-4ffc-90eb-1e4de35060fa', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:57:26.961000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b750398c-8a89-4850-8706-47b71c401d98', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:57:47.289000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('10be55e2-6ecf-43c5-a5a1-56fae8b0b5ae', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('21-09-2017 19:58:59.611000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('47751bae-4690-4618-b5c1-eaeb7142b9e5', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 20:37:30.350000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('efc26394-49b5-4761-a2c9-cc48c06668b2', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('21-09-2017 23:19:00.591000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('0c635e18-fa86-4367-8ad3-c3def3a73ddc', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('21-09-2017 23:26:18.161000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9bfd2d6a-d0c6-4490-8d6f-af4f4633342f', '1', '114.232.224.177', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 23:28:37.459000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('80ae8243-e57b-4362-9efb-1fc0082e82c4', '1', '114.232.224.177', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('21-09-2017 23:56:11.599000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('23d0cec5-9c85-4a17-a1b7-caaa3d20ce9c', '1', '114.232.224.177', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 00:06:52.107000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('bbf5c22f-2e8e-4bec-9ed2-96ca423ec3b0', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('22-09-2017 00:08:06.609000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('22ad6c62-d19c-4f12-bc81-f7ad1520dc51', '1', '114.232.224.177', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 00:21:44.937000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b4fb58a0-1238-4834-8c11-bfcd86310556', '1', '114.232.224.177', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 00:22:34.660000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('225553a9-e7a2-48c4-9a47-84786480a019', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 08:03:11.883000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('65805a36-93a5-47c7-84d5-edf65e654ebd', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 08:26:49.493000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('97a537e1-36df-4415-8555-09eae1ffe931', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 08:27:15.113000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('4d15820f-a5f0-49a6-af3b-2db06effaab5', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 09:11:04.127000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('bc08a431-9228-41f6-b241-75ba54148e2d', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 09:15:37.080000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('5263799a-8f0a-4d1a-8d5a-f2f5bee04ede', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 11:55:04.704000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('6bb732f5-a00b-4f05-b50e-0d02c3e279da', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 13:34:01.168000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('2ef6c025-7a3f-4087-a0aa-3d718675d9c1', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 14:26:35.755000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('7586c663-e065-4abb-89d3-2140eeab40da', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('22-09-2017 14:27:14.695000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('81965916-28e8-49d3-b4e8-39074b77ce59', '1', '223.113.10.234', 'Windows', '1920*1080', 'chrome 59.0.3071.115', '中国', '江苏', '南通', to_timestamp('22-09-2017 14:27:25.364000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('41f01ca3-ada1-4e0f-94f5-4f62ecccd7ad', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 14:55:29.017000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('937cac8a-2403-4823-9bc1-a1280de9837f', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 15:08:44.935000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('52b1a518-c458-46c0-9a99-4420e3baf785', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 15:15:49.875000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('213259c0-82f8-49ad-a2f9-7b9df78025c9', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 19:29:49.409000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('483699b5-658a-4b58-8188-cd0ded3132ec', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 19:59:58.351000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('66b06c2e-751b-418b-8a34-08a4efc28901', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:03:03.987000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('4ef53e73-70e6-4e59-ac37-652e270ba98b', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:05:56.644000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a772ba45-6dfe-40f8-bc2b-a8d75131c132', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:07:27.904000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9c77bc00-9251-4f09-a044-287f3fa66442', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:10:44.816000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('1ec577ff-edb1-48fe-a06a-3440f6fb70e4', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:11:37.068000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('0e611c7c-12fd-460b-9ad2-f17063705ff1', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:17:09.812000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('d2793ef3-a3b0-4c4f-a811-7a6f533d6041', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:27:00.543000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('63b77924-8a77-4197-958b-d8d9c4be8357', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('22-09-2017 20:58:43.504000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('bf3afdbc-afe0-4773-9706-bef86fcd6afc', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('22-09-2017 21:37:22.859000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('729c7c48-d0c5-4ef8-b545-e8da36e4cb41', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('22-09-2017 21:44:44.860000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('94312dcb-2d98-40d0-afb5-d78910746619', '1', '114.232.224.177', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('22-09-2017 21:50:19.070000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b588eecd-6d9b-434d-8165-0effe6b7c032', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 08:11:22.624000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('d7d291cd-22c5-4d2f-bfa4-5874474dff90', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 08:19:19.968000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('2895f6d8-812e-4080-8c8f-318c6189c577', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 08:36:54.750000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('fa57b938-7fdf-480a-be51-154a67ed1be4', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 08:56:24.031000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('ed599e9b-53ba-4200-a097-4c9000a5538d', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 10:41:39.765000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c0a91719-0797-4541-9c5f-83dcff09e25a', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 10:55:03.275000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('999cf8db-a42f-4c13-ad12-37ff90b12219', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 11:05:45.314000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e1022093-b40a-4fcc-a5bb-ab5571c1e841', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 11:59:20.412000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('4d621192-d481-4da0-9145-26bc95e98144', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 13:38:36.481000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('43e1212a-9caa-4baf-9269-45bceb25647b', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 13:52:25.775000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('da714b28-386a-4e77-a04c-eba495bb3913', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 13:54:19.296000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('bfac1c36-93e5-4989-9416-7a530efb37db', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 13:56:02.976000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e5de511f-1a51-44d4-9ab7-27e0537b8a3a', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 14:03:39.132000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('74706d53-0627-41a6-a1e0-776745688f52', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 14:07:03.050000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('630def19-8757-4d8a-83e6-943948c890fc', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 14:10:09.047000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('206c9d5e-00e0-4aef-bac8-15936d68f55d', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 15:53:59.538000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('cb719fc4-f638-40b4-a3c8-55090a609149', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('23-09-2017 17:09:10.145000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('3c638045-14f0-4b3d-bbf9-24f79ade2f48', '1', '180.121.217.137', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('23-09-2017 18:08:01.566000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('00af66c0-9e9a-4012-a2a1-b1590d59c86b', '1', '180.121.217.137', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('23-09-2017 18:12:56.553000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c9f42689-7b5f-49f4-8736-ba00319179d5', '1', '180.121.217.137', 'Windows', '1920*1080', 'chrome 53.0.2785.104', '中国', '江苏', '南通', to_timestamp('23-09-2017 18:23:09.281000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('05ca842a-31c7-4f9c-9b46-4fd0e323ba6f', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 08:00:52.578000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('fa313b4c-bd01-4edb-83a0-d1c0070d5821', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 08:03:17.361000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('3c32a7cd-18e9-4c43-afd2-1e1214f90c4c', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 08:18:45.503000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('040444a5-c024-49b0-ac5b-ada1351eea66', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 08:34:23.384000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a2fd2bee-dfea-48c0-a92f-7aa88492cc10', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 08:58:21.282000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c9698ba6-fd23-4d11-ac1c-cfec757c11a1', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 10:28:29.695000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('43146cdd-6628-40fc-95ba-45ae2726f359', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 10:33:50.965000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9ec75594-3286-414a-b915-0800d518b558', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 11:40:01.555000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b3fb0796-c4e2-40a7-9a52-4f2139f07d34', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 11:51:03.084000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('0e8c1337-2d88-4847-8a4a-0e0d3a0b358b', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 14:32:32.637000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c8e76ba9-123c-41b9-8bd4-fc4725c3d2dc', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 14:36:25.644000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('1e2c3b66-b2b1-4d35-916e-4d5a9c5293dd', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 14:43:45.975000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
commit;
prompt 100 records committed...
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('ce282393-6bd4-42e4-abea-225efcf9c151', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 14:50:07.663000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('dbf62e2b-7b4d-47ec-98c1-0aaa140bb0e7', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 15:43:07.732000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('48a6dc92-7201-4195-a70b-7f711234db4c', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 16:36:54.594000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('0f7c0429-3f05-485a-b183-b8db1721b535', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 16:39:55.072000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('006e02ab-4de0-4bd5-8715-31cbe394b9a0', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 16:47:25.906000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e9489120-e92c-4407-9d74-4cf801d736fe', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 18:58:25.968000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('4a5388ba-556c-48e9-a42c-04098d1f3f52', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:06:10.501000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('61f7b992-b7ce-4422-81fd-a891c272ce4b', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:08:09.920000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('8c1636a1-4012-4b2e-9c71-396d4a1c7995', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:10:17.138000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('26d0030f-788d-46bb-91ee-7ffb9296738d', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:14:23.936000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('7bd79b69-820a-4a67-937e-6fad3402ca62', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:17:46.938000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c7cc199a-7904-4464-99bb-861461674643', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:28:01.562000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('76e4cd65-f24f-4b0f-9082-f81ba653edbe', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:36:50.533000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c1379506-6fff-4851-b7c8-b68787530cf8', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:38:23.882000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('48d9646b-5d6b-40d3-84f5-36f4e6e55860', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 19:40:42.739000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('51b858d1-f821-4bd4-8e44-261d8805dcc0', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 20:12:18.276000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('95b8cc3a-64c1-4e4f-b560-b2021768c9d0', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 20:15:16.221000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c972ce42-70f5-4bf2-b95e-28ac7816b53c', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 21:27:17.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e4bce526-972e-4dcd-8d30-ad4845a62d4f', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 21:41:22.710000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('8f2bd876-cc12-4f2b-993c-15f67d8ed10b', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 22:13:47.567000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c7af7a67-01a3-463a-bfa4-7735d235f1df', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 22:32:02.362000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('1679f252-9bf0-47c0-b98c-03c62fe4cf66', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 22:47:33.448000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('092acc14-7a56-43c9-ba03-337459a50974', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 22:50:23.297000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('de917913-ad8d-4448-9c6e-585fc7b31df6', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 23:06:25.253000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('d196f6b9-84ad-43e4-9864-0dc87a8eb8e4', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 23:20:25.784000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('53ce16ef-df9e-4590-bf8e-679380cd3481', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('25-09-2017 23:23:32.675000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a11360ae-ff70-47cd-bc2f-54cc76e1eece', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 07:51:51.309000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('5090f430-f505-4961-b279-5543d6bc346d', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 07:56:22.117000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a1f4845e-7a32-40b1-b68d-4e53c33f9dda', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 10:02:34.954000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a7fa9933-302b-4f97-aa4c-93c6327d20cb', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 10:47:32.444000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('3315ad4f-1eff-400b-98ca-622240d86733', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 10:49:45.677000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c22ac800-36ae-442a-8e11-21f06676c571', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 10:50:10.276000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('8b2d8dce-8053-4eca-a3cf-e857fde577eb', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 11:25:52.641000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('63268b86-3395-486a-a99a-63651bbbc71a', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 13:49:32.340000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('60b4b3f3-9992-4f96-8993-7d392f229ff7', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 15:04:12.674000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('6ca42f9c-d8f6-4654-8499-7b318c4e1e32', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 15:13:34.891000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('66bfe998-a0ff-4134-a049-d5b59b43d23c', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 15:18:33.271000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b45e6f58-2ebb-4051-b438-1b9ac1c764db', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 15:35:05.233000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('062c7759-36ad-4704-b482-468c5fc84125', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:10:42.221000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('c74db9e4-17cd-44f0-bee5-ef33fc80ec70', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:19:22.075000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('6b637f18-ae88-4da6-9ced-1f9b59588604', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:22:33.733000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a41fa3f2-8e7b-408e-9213-2d83d9231e58', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:24:22.264000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('7d1e6f42-3021-49f0-8bcf-cd646ca282f4', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:28:07.311000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('b4f9a2d9-9aa3-4a3e-97dc-10cee9598f9b', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 16:55:01.429000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('aea9378d-0318-4bd6-b674-023cd7d62b84', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 17:26:31.596000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('6d99e744-3b46-4b49-a68a-3a65d2f2ceb5', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 18:29:06.349000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('827f68b1-c132-42a4-b5ea-dce4989bdb51', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 18:36:36.871000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('ef33d9a5-3f13-4d58-bd61-65bee0ca30c6', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 19:28:26.416000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('a878b219-3a56-4494-99bc-96a48acc663e', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 19:36:29.017000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('062d308a-6196-4f03-b2c2-6adbdfc9b869', '1', '223.113.10.234', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 19:48:01.620000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('9c553ad7-7f17-4729-9bc4-9a047946d80b', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 22:20:47.397000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
insert into ADMINS_LOGIN_LOG (ID, LOGIN_ADMIN, IP, SYSTEM, DPI, BROWSER, COUNTRY, PROVINCE, CITY, TIME, RESULT)
values ('e2d45c94-7f59-4827-a3d1-3b5c1ffe26e2', '1', '114.232.225.201', 'Windows', '1920*1080', 'firefox 55.0', '中国', '江苏', '南通', to_timestamp('26-09-2017 23:48:50.376000', 'dd-mm-yyyy hh24:mi:ss.ff'), 1);
commit;
prompt 152 records loaded
prompt Loading ROLES...
insert into ROLES (ID, NAME, STATUS)
values ('1', 'admins', 1);
commit;
prompt 1 records loaded
prompt Loading ADMINS_ROLES...
prompt Table is empty
prompt Loading CLAZZS...
insert into CLAZZS (ID, TEXT, NUM)
values ('1', '家居用品', 0);
insert into CLAZZS (ID, TEXT, NUM)
values ('2', '食物', 0);
insert into CLAZZS (ID, TEXT, NUM)
values ('3', '游戏设备', 0);
insert into CLAZZS (ID, TEXT, NUM)
values ('4', '旅游设备', 0);
commit;
prompt 4 records loaded
prompt Loading FILES...
prompt Table is empty
prompt Loading GOODS...
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('24be7628-8db1-4652-99ef-8c3f4485961c', '1', '1', 1, 1, 1, 2738, 1, to_timestamp('23-09-2017 10:19:21.785000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', '5', 10, to_timestamp('23-09-2017 16:45:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('7c783090-c4b2-4ca9-ab4d-7cf009dc54db', '1', '1', 1, 1, 1, 2738, 1, to_timestamp('23-09-2017 10:36:03.338000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', null, 0, to_timestamp('26-09-2017 20:04:24.912000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('4d04aeff-d5ab-44e5-bb7e-4c65f42a94e9', '转让刘二狗', '速速快来，刘二狗转让', 9998, .1, 9, 1633, -6, to_timestamp('23-09-2017 10:40:30.362000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', null, 0, to_timestamp('26-09-2017 15:20:40.216000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('8c5b3952-2045-41ac-891c-b4759afe753e', '1', '1', 1, 1, 1, 1659, -5, to_timestamp('23-09-2017 13:52:45.385000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', null, 0, to_timestamp('23-09-2017 16:45:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('73605e59-a348-4c79-ba15-83a3dbe255c5', '哈哈哈', '������������', 45, 90, 8, 1521, -6, to_timestamp('23-09-2017 15:46:36.103000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 19:39:33.279000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('e49ee43c-ac55-4f53-8b07-92974a15d69d', '张可', '厉害了', 999, .1, 9, 2777, -5, to_timestamp('23-09-2017 15:40:45.682000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('25-09-2017 21:59:38.378000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('340e19f8-22a7-4c55-ae58-1a7d58ed8c7f', '女士短裤', '清凉夏装', 45, 90, 8, 1343, 0, to_timestamp('23-09-2017 15:43:45.877000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 15:56:59.859000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('06318885-f82d-4b2a-8754-c29e79907e74', '82年的金华火腿', '很好吃哦', .1, 9999, 1, 1329, -1, to_timestamp('23-09-2017 15:46:36.689000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 16:58:39.893000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('b78e3a77-877d-4ca6-a7f6-d29b06dd004a', '1', '1', 1, 1, 9, 1313, 1, to_timestamp('23-09-2017 15:36:37.791000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('25-09-2017 23:06:50.276000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('ee1922e2-b94c-4919-a368-37424023c222', '女士短裤', '清凉夏装', 45, 90, 8, 1313, 1, to_timestamp('23-09-2017 15:46:26.484000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 15:32:22.842000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('8d3bd6e5-6519-4281-b4be-9ddc4bae96c2', '女士短裤', '清凉夏装', 45, 90, 8, 1179, -5, to_timestamp('23-09-2017 15:46:46.789000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 07:53:11.482000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('492581bb-ce03-444f-8b8a-888ba06c2ad6', '1', '1', 1, 1, 1, 1631, -6, to_timestamp('23-09-2017 15:26:24.509000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 15:21:35.949000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('765be64e-382b-4dfe-8322-2cff5a21cfcc', '女士短裤', '清凉夏装', 45, 90, 8, 836, 2, to_timestamp('23-09-2017 15:46:37.041000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('26-09-2017 15:22:41.111000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('1a45316a-a777-4c14-83e8-482278032e94', '女士短裤', '清凉夏装', 45, 90, 8, 1659, 2, to_timestamp('23-09-2017 15:46:37.532000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('23-09-2017 16:45:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into GOODS (ID, TITLE, DESCRIPTION, SPRICE, PRICE, CONDITION, REGION, STATUS, CREATETIME, OWNER, BUYER, BROWSENUMBER, LASTUPDATETIME, BUYTIME, FINISHTIME)
values ('a4135505-aaf4-4b30-8e42-194e54ace856', '女士短裤', '清凉夏装', 45, 90, 8, 1659, -1, to_timestamp('23-09-2017 15:46:34.963000', 'dd-mm-yyyy hh24:mi:ss.ff'), '5', null, 0, to_timestamp('23-09-2017 16:45:02.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
commit;
prompt 15 records loaded
prompt Loading GOODS_CLAZZS...
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('e4e07e63-0d5b-41f5-8e70-9a950af95426', '73605e59-a348-4c79-ba15-83a3dbe255c5', '1');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('ac6c99cc-23c8-411b-b596-77287af1273b', '4d04aeff-d5ab-44e5-bb7e-4c65f42a94e9', '1');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('c1419715-d687-4496-bce0-67091f45c2a9', '4d04aeff-d5ab-44e5-bb7e-4c65f42a94e9', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('954956db-6f6c-428c-8f7f-4c6f4ca6a3dc', '765be64e-382b-4dfe-8322-2cff5a21cfcc', '1');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('2a718bb4-2978-4dfb-bafd-b21b439f7ef6', 'ee1922e2-b94c-4919-a368-37424023c222', '1');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('851afb08-81ce-4af7-af43-f44fa82991fb', '492581bb-ce03-444f-8b8a-888ba06c2ad6', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('06ca3807-9dd3-4a9e-9fcd-b9b658549f68', '765be64e-382b-4dfe-8322-2cff5a21cfcc', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('c901915d-f457-4ecd-8083-790aa22765d7', '73605e59-a348-4c79-ba15-83a3dbe255c5', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('2d4df097-9959-46cb-b521-57f987da681e', 'ee1922e2-b94c-4919-a368-37424023c222', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('efd5c517-0734-4b47-a7b5-779a6dd180e5', '73605e59-a348-4c79-ba15-83a3dbe255c5', '3');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('28ae2948-47b1-4b5a-8439-7040e68bd3aa', '06318885-f82d-4b2a-8754-c29e79907e74', '1');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('c76e7220-15a6-4cad-b5a0-75a40ef2c621', '06318885-f82d-4b2a-8754-c29e79907e74', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('dc8eed45-8567-40f6-af61-91ed206e0d20', '06318885-f82d-4b2a-8754-c29e79907e74', '3');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('c8111c15-6fcc-4f24-9c86-8f7086e0086b', '7c783090-c4b2-4ca9-ab4d-7cf009dc54db', '2');
insert into GOODS_CLAZZS (ID, GOODS, CLAZZ)
values ('1a849ea1-b333-4966-8c22-4420302926df', '7c783090-c4b2-4ca9-ab4d-7cf009dc54db', '3');
commit;
prompt 15 records loaded
prompt Loading GOODS_IMGS...
prompt Table is empty
prompt Loading MESSAGES...
prompt Table is empty
prompt Loading PERMISSIONS...
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('8', '网站统计', null, null, null, null, null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('9', '商品管理', null, null, null, null, null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('5', '用户管理', null, null, null, null, null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('6', '管理员管理', null, null, null, null, null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('1', '用户管理', null, '/view/users_manage.jsp', null, '5', null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('4', '管理员管理', null, '/view/admins_manage.jsp', null, '6', null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('7', '用户统计', null, '/view/users_chart.jsp', null, '8', null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('10', '商品管理', null, '/view/goods_manage.jsp', null, '9', null, null, 1);
insert into PERMISSIONS (ID, TEXT, TYPE, URL, CODE, PID, PIDS, SORT, STATUS)
values ('11', '商品类型管理', null, '/view/clazzs_manage.jsp', null, '9', null, null, 1);
commit;
prompt 9 records loaded
prompt Loading ROLES_PERMISSIONS...
insert into ROLES_PERMISSIONS (ID, ROLE, PERMISSION, GRANTTIME)
values ('1', '1', '1', to_timestamp('15-09-2017 10:18:09.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 1 records loaded
prompt Loading USERS_LOGIN_LOG...
prompt Table is empty
prompt Loading WANDER_LOG...
prompt Table is empty
set feedback on
set define on
prompt Done.
