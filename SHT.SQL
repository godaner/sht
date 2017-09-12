prompt PL/SQL Developer import file
prompt Created on 2017年9月11日 by Kor_Zhang
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
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table USERS
  add constraint USER_PK_ID primary key (ID)
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
alter table USERS_ROLES
  add constraint USERS_ROLES_FK_USER_ID foreign key (USER_ID)
  references USERS (ID) on delete cascade;

prompt Loading PERMISSIONS...
prompt Table is empty
prompt Loading ROLES...
prompt Table is empty
prompt Loading ROLES_PERMISSIONS...
prompt Table is empty
prompt Loading USERS...
prompt Table is empty
prompt Loading USERS_ROLES...
prompt Table is empty
set feedback on
set define on
prompt Done.
