-------------------------------------------------
-- Export file for user SHT                    --
-- Created by Kor_Zhang on 2017/10/11, 9:45:20 --
-------------------------------------------------

spool db-2017-10-11-0.log

prompt
prompt Creating table REGION
prompt =====================
prompt
create table SHT.REGION
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
comment on column SHT.REGION.ID
  is '行政区划id';
comment on column SHT.REGION.CODE
  is '行政区划代码';
comment on column SHT.REGION.NAME
  is '行政区划名称';
comment on column SHT.REGION.PID
  is '父行政区划';
comment on column SHT.REGION.LEVE
  is '层级';
comment on column SHT.REGION.ORDE
  is '排序，用来调整顺序';
comment on column SHT.REGION.ENNAME
  is '行政区划英文名称';
comment on column SHT.REGION.ENSHORTNAME
  is '行政区划简称';
alter table SHT.REGION
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

prompt
prompt Creating table USERS
prompt ====================
prompt
create table SHT.USERS
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
comment on column SHT.USERS.ID
  is '用户主键';
comment on column SHT.USERS.USERNAME
  is '唯一用户名称;如果用户被删除,那么在其username前加上uuid_;避免干擾管理員對其他賬戶名的修改;';
comment on column SHT.USERS.EMAIL
  is '唯一用户邮箱;如果用户被删除,那么在其EMAIL前加上uuid_;避免干擾管理員對其他賬戶郵箱的修改;';
comment on column SHT.USERS.PASSWORD
  is '用户密码';
comment on column SHT.USERS.SALT
  is '盐';
comment on column SHT.USERS.HEADIMG
  is '用户头像的图片名';
comment on column SHT.USERS.SEX
  is '-1为未设置性别,1为男,0为女';
comment on column SHT.USERS.BIRTHDAY
  is '用户生日,可计算出年龄';
comment on column SHT.USERS.DESCRIPTION
  is '用户描述';
comment on column SHT.USERS.SCORE
  is '用户积分';
comment on column SHT.USERS.REGISTTIME
  is '用户注册时间';
comment on column SHT.USERS.STATUS
  is '状态:1为激活，,0为冻结,-1为删除 ,-2为注册未激活';
comment on column SHT.USERS.MONEY
  is '用户余额';
alter table SHT.USERS
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
alter table SHT.USERS
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
alter table SHT.USERS
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
alter table SHT.USERS
  add constraint USERS_CK_SEX
  check (SEX IN (-1,1,0) );

prompt
prompt Creating table ADDRS
prompt ====================
prompt
create table SHT.ADDRS
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
comment on column SHT.ADDRS.ID
  is '主键';
comment on column SHT.ADDRS.MASTER
  is '指向用户的id';
comment on column SHT.ADDRS.REGION
  is '指向地址最低级的id;省-市-县;如:湖南省-张家界-慈利县';
comment on column SHT.ADDRS.DETAIL
  is '地址详情;如:吉首大学张家界校区1食堂';
comment on column SHT.ADDRS.PHONE
  is '联系电话';
comment on column SHT.ADDRS.REALNAME
  is '收货人姓名';
comment on column SHT.ADDRS.ISDEFAULT
  is '是否为默认地址';
comment on column SHT.ADDRS.POSTCODE
  is '邮编';
alter table SHT.ADDRS
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
alter table SHT.ADDRS
  add constraint ADDRS_FK_MASTER foreign key (MASTER)
  references SHT.USERS (ID) on delete cascade;
alter table SHT.ADDRS
  add constraint ADDRS_FK_REGION foreign key (REGION)
  references SHT.REGION (ID) on delete cascade;

prompt
prompt Creating table ADMINS
prompt =====================
prompt
create table SHT.ADMINS
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
comment on column SHT.ADMINS.ID
  is '主键';
comment on column SHT.ADMINS.USERNAME
  is '用户名';
comment on column SHT.ADMINS.PASSWORD
  is '密码';
comment on column SHT.ADMINS.SALT
  is '盐';
comment on column SHT.ADMINS.STATUS
  is '状态;1为激活,0为冻结,-1为删除,';
comment on column SHT.ADMINS.CREATETIME
  is '创建时间';
comment on column SHT.ADMINS.CREATOR
  is '创建者';
comment on column SHT.ADMINS.THEME
  is '管理员的界面主题';
comment on column SHT.ADMINS.EMAIL
  is '管理员的邮箱';
comment on column SHT.ADMINS.STATICC
  is '是否为内置对象;1代表内置管理员,不可删除,修改权限,0代表不是';
comment on column SHT.ADMINS.DESCRIPTION
  is '描述';
alter table SHT.ADMINS
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
alter table SHT.ADMINS
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
alter table SHT.ADMINS
  add constraint ADS_FK_CREATOR foreign key (CREATOR)
  references SHT.ADMINS (ID) on delete set null;

prompt
prompt Creating table ADMINS_LOGIN_LOG
prompt ===============================
prompt
create table SHT.ADMINS_LOGIN_LOG
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
comment on column SHT.ADMINS_LOGIN_LOG.ID
  is '主键';
comment on column SHT.ADMINS_LOGIN_LOG.LOGIN_ADMIN
  is '登录的管理员';
comment on column SHT.ADMINS_LOGIN_LOG.IP
  is 'ip地址';
comment on column SHT.ADMINS_LOGIN_LOG.SYSTEM
  is '系统,例如windows';
comment on column SHT.ADMINS_LOGIN_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column SHT.ADMINS_LOGIN_LOG.BROWSER
  is '浏览器';
comment on column SHT.ADMINS_LOGIN_LOG.COUNTRY
  is '登录国家';
comment on column SHT.ADMINS_LOGIN_LOG.PROVINCE
  is '登录省份';
comment on column SHT.ADMINS_LOGIN_LOG.CITY
  is '登录城市';
comment on column SHT.ADMINS_LOGIN_LOG.TIME
  is '登陆时间';
comment on column SHT.ADMINS_LOGIN_LOG.RESULT
  is '1为登录成功,0为因为登录失败';
alter table SHT.ADMINS_LOGIN_LOG
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
alter table SHT.ADMINS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_ADMIN foreign key (LOGIN_ADMIN)
  references SHT.ADMINS (ID);

prompt
prompt Creating table ROLES
prompt ====================
prompt
create table SHT.ROLES
(
  ID          NVARCHAR2(40) not null,
  NAME        NVARCHAR2(255) not null,
  STATUS      NUMBER(1) not null,
  DESCRIPTION NVARCHAR2(255) not null,
  STATICC     NUMBER(1) not null,
  CREATETIME  TIMESTAMP(6) not null,
  CREATOR     NVARCHAR2(40)
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
comment on column SHT.ROLES.ID
  is '主键';
comment on column SHT.ROLES.NAME
  is '角色名';
comment on column SHT.ROLES.STATUS
  is '状态;1为激活,0为冻结,-1为删除';
comment on column SHT.ROLES.DESCRIPTION
  is '角色描述';
comment on column SHT.ROLES.STATICC
  is '是否为内置对象;1代表内置管理员,不可删除,修改权限,0代表不是';
comment on column SHT.ROLES.CREATETIME
  is '创建时间';
comment on column SHT.ROLES.CREATOR
  is '创建者,指向adminid';
alter table SHT.ROLES
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
alter table SHT.ROLES
  add constraint UK_ROLES_NAME unique (NAME)
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
alter table SHT.ROLES
  add constraint FK_ROLES_CREATOR foreign key (CREATOR)
  references SHT.ADMINS (ID) on delete set null;

prompt
prompt Creating table ADMINS_ROLES
prompt ===========================
prompt
create table SHT.ADMINS_ROLES
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
comment on column SHT.ADMINS_ROLES.ID
  is '主键';
comment on column SHT.ADMINS_ROLES.ADMIN
  is '管理员';
comment on column SHT.ADMINS_ROLES.ROLE
  is '角色';
comment on column SHT.ADMINS_ROLES.GRANTTIME
  is '赋权时间';
alter table SHT.ADMINS_ROLES
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
alter table SHT.ADMINS_ROLES
  add constraint A_R_FK_ADMIN foreign key (ADMIN)
  references SHT.ADMINS (ID) on delete cascade;
alter table SHT.ADMINS_ROLES
  add constraint A_R_FK_ROLE foreign key (ROLE)
  references SHT.ROLES (ID) on delete cascade;

prompt
prompt Creating table CLAZZS
prompt =====================
prompt
create table SHT.CLAZZS
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
comment on column SHT.CLAZZS.ID
  is '类型id';
comment on column SHT.CLAZZS.TEXT
  is '唯一的类型名';
comment on column SHT.CLAZZS.NUM
  is '各个类别商品总数';
alter table SHT.CLAZZS
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
alter table SHT.CLAZZS
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

prompt
prompt Creating table FILES
prompt ====================
prompt
create table SHT.FILES
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
comment on column SHT.FILES.ID
  is '文件主键';
comment on column SHT.FILES.PATH
  is '文件在服务器的储存路径例如:a.jpg;不要带上路径;例如：d:\floder\a.png错误,';
comment on column SHT.FILES.NAME
  is '文件原名';
alter table SHT.FILES
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

prompt
prompt Creating table GOODS
prompt ====================
prompt
create table SHT.GOODS
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
comment on column SHT.GOODS.ID
  is '商品主键';
comment on column SHT.GOODS.TITLE
  is '商品标题';
comment on column SHT.GOODS.DESCRIPTION
  is '商品介绍';
comment on column SHT.GOODS.SPRICE
  is 'second price；商品的二手价,即转卖价';
comment on column SHT.GOODS.PRICE
  is '商品原价';
comment on column SHT.GOODS.CONDITION
  is '商品成色,1-9';
comment on column SHT.GOODS.REGION
  is '商品地区';
comment on column SHT.GOODS.STATUS
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
comment on column SHT.GOODS.CREATETIME
  is '创建时间';
comment on column SHT.GOODS.OWNER
  is '发布本商品的用户';
comment on column SHT.GOODS.BUYER
  is '购买本商品的用户,没有用户购买是null';
comment on column SHT.GOODS.BROWSENUMBER
  is '浏览次数';
comment on column SHT.GOODS.LASTUPDATETIME
  is '最后一次更新时间';
comment on column SHT.GOODS.BUYTIME
  is '商品被购买时写入购买时间';
comment on column SHT.GOODS.FINISHTIME
  is '商品交易正常完成时的时间';
comment on column SHT.GOODS.TOPROVINCE
  is '收件省份';
comment on column SHT.GOODS.TOCITY
  is '收件城市';
comment on column SHT.GOODS.TOCOUNTY
  is '收件县区';
comment on column SHT.GOODS.TODETAIL
  is '收件详细地址';
comment on column SHT.GOODS.PHONE
  is '收件人电话';
comment on column SHT.GOODS.TOREALNAME
  is '收件人名字';
comment on column SHT.GOODS.POSTCODE
  is '收件地址邮编';
comment on column SHT.GOODS.REFUSERETURNMONEYBILL
  is '商家拒绝退款的凭证';
alter table SHT.GOODS
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
alter table SHT.GOODS
  add constraint GOODS_FK_BUYER foreign key (BUYER)
  references SHT.USERS (ID) on delete cascade;
alter table SHT.GOODS
  add constraint GOODS_FK_OWNER foreign key (OWNER)
  references SHT.USERS (ID) on delete cascade;
alter table SHT.GOODS
  add constraint GOODS_FK_REGION foreign key (REGION)
  references SHT.REGION (ID) on delete cascade;
alter table SHT.GOODS
  add constraint GOODS_CK_CONDITION
  check (CONDITION BETWEEN 1 AND 10);

prompt
prompt Creating table GOODS_CLAZZS
prompt ===========================
prompt
create table SHT.GOODS_CLAZZS
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
comment on column SHT.GOODS_CLAZZS.ID
  is '主键';
comment on column SHT.GOODS_CLAZZS.GOODS
  is '指向商品的id';
comment on column SHT.GOODS_CLAZZS.CLAZZ
  is '指向类型的id';
alter table SHT.GOODS_CLAZZS
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
alter table SHT.GOODS_CLAZZS
  add constraint GC_FK_CLAZZ foreign key (CLAZZ)
  references SHT.CLAZZS (ID) on delete cascade;
alter table SHT.GOODS_CLAZZS
  add constraint GC_FK_GOODS foreign key (GOODS)
  references SHT.GOODS (ID) on delete cascade;

prompt
prompt Creating table GOODS_IMGS
prompt =========================
prompt
create table SHT.GOODS_IMGS
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
comment on column SHT.GOODS_IMGS.ID
  is '商品和图片对应表的id';
comment on column SHT.GOODS_IMGS.OWNER
  is '指向商品id';
comment on column SHT.GOODS_IMGS.IMG
  is '指向文件id';
comment on column SHT.GOODS_IMGS.MAIN
  is '是否为主图:1是0否,主图只有一张';
alter table SHT.GOODS_IMGS
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
alter table SHT.GOODS_IMGS
  add constraint GI_FK_IMG foreign key (IMG)
  references SHT.FILES (ID) on delete cascade;
alter table SHT.GOODS_IMGS
  add constraint GI_FK_OWNER foreign key (OWNER)
  references SHT.GOODS (ID) on delete cascade;

prompt
prompt Creating table MESSAGES
prompt =======================
prompt
create table SHT.MESSAGES
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
comment on column SHT.MESSAGES.ID
  is '留言主键';
comment on column SHT.MESSAGES.LAUNCHER
  is '留言发起者';
comment on column SHT.MESSAGES.RECEIVER
  is '接收留言的商品';
comment on column SHT.MESSAGES.TEXT
  is '留言内容';
comment on column SHT.MESSAGES.CREATETIME
  is '留言时间';
alter table SHT.MESSAGES
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
alter table SHT.MESSAGES
  add constraint MSGS_FK_LAUNCHER foreign key (LAUNCHER)
  references SHT.USERS (ID) on delete cascade;
alter table SHT.MESSAGES
  add constraint MSGS_FK_RECEIVER foreign key (RECEIVER)
  references SHT.GOODS (ID) on delete cascade;

prompt
prompt Creating table PERMISSIONS
prompt ==========================
prompt
create table SHT.PERMISSIONS
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
comment on column SHT.PERMISSIONS.ID
  is '主键';
comment on column SHT.PERMISSIONS.TEXT
  is '资源名';
comment on column SHT.PERMISSIONS.TYPE
  is '资源类型：menu,button等';
comment on column SHT.PERMISSIONS.URL
  is '访问资源url地址';
comment on column SHT.PERMISSIONS.CODE
  is '权限代码';
comment on column SHT.PERMISSIONS.PID
  is '父节点id';
comment on column SHT.PERMISSIONS.PIDS
  is '祖先节点的id,用-分割';
comment on column SHT.PERMISSIONS.SORT
  is '排序号';
comment on column SHT.PERMISSIONS.STATUS
  is '是否可用,1:可用,0:删除';
alter table SHT.PERMISSIONS
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
alter table SHT.PERMISSIONS
  add constraint PERMISSIONS_FK_PARENTID foreign key (PID)
  references SHT.PERMISSIONS (ID) on delete cascade;

prompt
prompt Creating table ROLES_PERMISSIONS
prompt ================================
prompt
create table SHT.ROLES_PERMISSIONS
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
comment on column SHT.ROLES_PERMISSIONS.ID
  is '主键';
comment on column SHT.ROLES_PERMISSIONS.ROLE
  is '角色id';
comment on column SHT.ROLES_PERMISSIONS.PERMISSION
  is '权限id';
comment on column SHT.ROLES_PERMISSIONS.GRANTTIME
  is '权限赋予时间';
alter table SHT.ROLES_PERMISSIONS
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
alter table SHT.ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_P foreign key (PERMISSION)
  references SHT.PERMISSIONS (ID) on delete cascade;
alter table SHT.ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_ROLES_ID foreign key (ROLE)
  references SHT.ROLES (ID) on delete cascade;

prompt
prompt Creating table USERS_LOGIN_LOG
prompt ==============================
prompt
create table SHT.USERS_LOGIN_LOG
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
comment on column SHT.USERS_LOGIN_LOG.ID
  is '主键';
comment on column SHT.USERS_LOGIN_LOG.LOGIN_USER
  is '登录的用户';
comment on column SHT.USERS_LOGIN_LOG.IP
  is 'ip地址';
comment on column SHT.USERS_LOGIN_LOG.SYSTEM
  is '系统,例如windows';
comment on column SHT.USERS_LOGIN_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column SHT.USERS_LOGIN_LOG.BROWSER
  is '浏览器';
comment on column SHT.USERS_LOGIN_LOG.COUNTRY
  is '登录国家';
comment on column SHT.USERS_LOGIN_LOG.PROVINCE
  is '登录省份';
comment on column SHT.USERS_LOGIN_LOG.CITY
  is '登录城市';
comment on column SHT.USERS_LOGIN_LOG.TIME
  is '登陆时间';
comment on column SHT.USERS_LOGIN_LOG.RESULT
  is '1为登录成功,0为因为登录失败';
alter table SHT.USERS_LOGIN_LOG
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
alter table SHT.USERS_LOGIN_LOG
  add constraint U_L_L_FK_LOGIN_USER foreign key (LOGIN_USER)
  references SHT.USERS (ID);

prompt
prompt Creating table WANDER_LOG
prompt =========================
prompt
create table SHT.WANDER_LOG
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
comment on column SHT.WANDER_LOG.ID
  is '主键';
comment on column SHT.WANDER_LOG.IP
  is 'ip地址';
comment on column SHT.WANDER_LOG.PAGE
  is '访问的页面';
comment on column SHT.WANDER_LOG.OLD_LINK
  is '上一个连接';
comment on column SHT.WANDER_LOG.TITLE
  is '页面标题';
comment on column SHT.WANDER_LOG.SYSTEM
  is '系统,例如windows';
comment on column SHT.WANDER_LOG.DPI
  is '分辨率,例如1920x1080';
comment on column SHT.WANDER_LOG.BROWSER
  is '浏览器';
comment on column SHT.WANDER_LOG.COUNTRY
  is '登录国家';
comment on column SHT.WANDER_LOG.PROVINCE
  is '登录省份';
comment on column SHT.WANDER_LOG.CITY
  is '登录城市';
comment on column SHT.WANDER_LOG.KEYWORD
  is '关键字';
comment on column SHT.WANDER_LOG.TIME
  is '登陆时间';
alter table SHT.WANDER_LOG
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

prompt
prompt Creating function GETCLAZZSBYGOODSID
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION SHT.getClazzsBYgoodsid(goodsid IN NVARCHAR2)
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
CREATE OR REPLACE FUNCTION SHT.getGoodsMainImgPath(goodsid IN NVARCHAR2)
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
CREATE OR REPLACE FUNCTION SHT.getGoodsMessageNum(goodsid IN NVARCHAR2)
RETURN NUMBER
AS

       r NUMBER;
BEGIN

       select count(messages.id) into r
       from  messages
       where  messages.receiver = goodsid;

       RETURN r;
END;
/

prompt
prompt Creating function GETIMGSPATHBYGOODSID
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION SHT.getImgsPathByGoodsId(goodsid IN NVARCHAR2)
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
prompt Creating function GETMSGRECIVERNAME
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION SHT.getMsgReciverName(usid IN NVARCHAR2)
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
CREATE OR REPLACE FUNCTION SHT.getRegionByBaseId(baseid IN NUMBER)
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
CREATE OR REPLACE FUNCTION SHT.getRolesByAdminId(adminId IN VARCHAR2)
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
prompt Creating trigger UPDATECLAZZNUMBYGOODSSTATUS
prompt ============================================
prompt
CREATE OR REPLACE TRIGGER SHT.updateClazzNumByGoodsStatus
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
