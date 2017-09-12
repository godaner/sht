prompt PL/SQL Developer import file
prompt Created on 2017年9月12日 by Kor_Zhang
set feedback off
set define off
prompt Creating PERMISSIONS...
create table PERMISSIONS
(
  ID         NVARCHAR2(40) not null,
  NAME       NVARCHAR2(128) not null,
  TYPE       NVARCHAR2(128),
  URL        NVARCHAR2(128),
  PERCODE    NVARCHAR2(128),
  PARENTID   NVARCHAR2(40),
  PARENTIDS  NVARCHAR2(128),
  SORTSTRING NVARCHAR2(128),
  AVAILABLE  CHAR(1) default '1'
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
comment on column PERMISSIONS.ID
  is '逐渐';
comment on column PERMISSIONS.NAME
  is '资源名';
comment on column PERMISSIONS.TYPE
  is '资源类型：menu,button等';
comment on column PERMISSIONS.URL
  is '访问资源url地址';
comment on column PERMISSIONS.PERCODE
  is '权限代码';
comment on column PERMISSIONS.PARENTID
  is '父节点id';
comment on column PERMISSIONS.PARENTIDS
  is '祖先节点的id,用/分割';
comment on column PERMISSIONS.SORTSTRING
  is '排序号';
comment on column PERMISSIONS.AVAILABLE
  is '是否可用,1:可用,0:不可用';
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
  add constraint PERMISSIONS_FK_PARENTID foreign key (PARENTID)
  references PERMISSIONS (ID) on delete cascade;
alter table PERMISSIONS
  add constraint PERMISSIONS_CK_AVAILABLE
  check (AVAILABLE IN('1','0'));

prompt Creating ROLES...
create table ROLES
(
  ID        NVARCHAR2(40) not null,
  NAME      NVARCHAR2(128) not null,
  AVAILABLE CHAR(1) default '1'
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
comment on column ROLES.ID
  is '主键';
comment on column ROLES.NAME
  is '角色名';
comment on column ROLES.AVAILABLE
  is '是否可用,1:可用,0:不可用';
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
alter table ROLES
  add constraint ROLES_CK_AVAILABLE
  check (AVAILABLE IN ('1','0'));

prompt Creating ROLES_PERMISSIONS...
create table ROLES_PERMISSIONS
(
  ID             NVARCHAR2(40) not null,
  ROLES_ID       NVARCHAR2(40) not null,
  PERMISSIONS_ID NVARCHAR2(40) not null
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
comment on column ROLES_PERMISSIONS.ID
  is '主键';
comment on column ROLES_PERMISSIONS.ROLES_ID
  is '角色id';
comment on column ROLES_PERMISSIONS.PERMISSIONS_ID
  is '权限id';
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
  add constraint ROLES_PERMISSIONS_FK_P_ID foreign key (PERMISSIONS_ID)
  references PERMISSIONS (ID) on delete cascade;
alter table ROLES_PERMISSIONS
  add constraint ROLES_PERMISSIONS_FK_ROLES_ID foreign key (ROLES_ID)
  references ROLES (ID) on delete cascade;

prompt Creating USERS...
create table USERS
(
  ID       NVARCHAR2(40) not null,
  USERNAME NVARCHAR2(32) not null,
  PASSWORD NVARCHAR2(32) not null,
  SALT     NVARCHAR2(64),
  LOCKED   CHAR(1) default '0'
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
  is '主键';
comment on column USERS.USERNAME
  is '账号';
comment on column USERS.PASSWORD
  is '密码';
comment on column USERS.SALT
  is '盐';
comment on column USERS.LOCKED
  is '账号是否锁定，1：锁定，0未锁定';
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
  add constraint USERSS_UK_USERNAME unique (USERNAME)
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
  add constraint USER_CK_LOCKED
  check (LOCKED IN('1','0'));

prompt Creating USERS_ROLES...
create table USERS_ROLES
(
  ID       NVARCHAR2(40) not null,
  USER_ID  NVARCHAR2(40) not null,
  ROLES_ID NVARCHAR2(40) not null
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
comment on column USERS_ROLES.ID
  is '主键';
comment on column USERS_ROLES.USER_ID
  is '用户id';
comment on column USERS_ROLES.ROLES_ID
  is '角色id';
alter table USERS_ROLES
  add constraint USERS_ROLES_PK_ID primary key (ID)
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
alter table USERS_ROLES
  add constraint USERS_ROLES_FK_ROLES_ID foreign key (ROLES_ID)
  references ROLES (ID) on delete cascade;

prompt Loading PERMISSIONS...
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('1', '权限', null, null, null, null, '0/', '0', '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('11', '商品管理', 'menu', '/item/queryItem.action', null, '1', '0/1/', '1.', '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('12', '商品新增', 'PERMISSIONS', '/item/add.action', 'item:create', '11', '0/1/11/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('13', '商品修改', 'PERMISSIONS', '/item/editItem.action', 'item:update', '11', '0/1/11/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('14', '商品删除', 'PERMISSIONS', null, 'item:delete', '11', '0/1/11/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('15', '商品查询', 'PERMISSIONS', '/item/queryItem.action', 'item:query', '11', '0/1/15/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('21', '用户管理', 'menu', '/user/query.action', 'user:query', '1', '0/1/', '2.', '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('22', '用户新增', 'PERMISSIONS', null, 'user:create', '21', '0/1/21/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('23', '用户修改', 'PERMISSIONS', null, 'user:update', '21', '0/1/21/', null, '1');
insert into PERMISSIONS (ID, NAME, TYPE, URL, PERCODE, PARENTID, PARENTIDS, SORTSTRING, AVAILABLE)
values ('24', '用户删除', 'PERMISSIONS', null, 'user:delete', '21', '0/1/21/', null, '1');
commit;
prompt 10 records loaded
prompt Loading ROLES...
insert into ROLES (ID, NAME, AVAILABLE)
values ('ebc8a441-c6f9-11e4-b137-0adc305c3f28', '商品管理员', '1');
insert into ROLES (ID, NAME, AVAILABLE)
values ('ebc9d647-c6f9-11e4-b137-0adc305c3f28', '用户管理员', '1');
commit;
prompt 2 records loaded
prompt Loading ROLES_PERMISSIONS...
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc8a441-c6f9-11e4-b137-0adc305c3f21', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '12');
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc8a441-c6f9-11e4-b137-0adc305c3f22', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '11');
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc8a441-c6f9-11e4-b137-0adc305c3f24', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '21');
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc8a441-c6f9-11e4-b137-0adc305c3f25', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '15');
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc9d647-c6f9-11e4-b137-0adc305c3f23', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '22');
insert into ROLES_PERMISSIONS (ID, ROLES_ID, PERMISSIONS_ID)
values ('ebc9d647-c6f9-11e4-b137-0adc305c3f26', 'ebc8a441-c6f9-11e4-b137-0adc305c3f28', '13');
commit;
prompt 6 records loaded
prompt Loading USERS...
insert into USERS (ID, USERNAME, PASSWORD, SALT, LOCKED)
values ('lisi', '李四', 'bf07fd8bbc73b6f70b8319f2ebb8748', 'uiwueylm', '0');
insert into USERS (ID, USERNAME, PASSWORD, SALT, LOCKED)
values ('zhangsan', '张三', 'cb571f7bd7a6f73ab004a70322b963d', 'eteokues', '0');
commit;
prompt 2 records loaded
prompt Loading USERS_ROLES...
prompt Table is empty
set feedback on
set define on
prompt Done.
