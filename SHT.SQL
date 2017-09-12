prompt PL/SQL Developer import file
prompt Created on 2017年9月12日 by Kor_Zhang
set feedback off
set define off
prompt Creating USERS...
create table USERS
(
  ID       NVARCHAR2(40) not null,
  USERNAME NVARCHAR2(32) not null,
  PASSWORD NVARCHAR2(32) not null,
  SALT     NVARCHAR2(40) default '' not null,
  LOCKED   CHAR(1) default '0' not null,
  ISDELETE CHAR(1) default '0' not null
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
  add constraint USERS_CK_ISDELETE
  check (LOCKED IN('1','0'));
alter table USERS
  add constraint USERS_CK_LOCKED
  check (LOCKED IN('1','0'));

prompt Loading USERS...
prompt Table is empty
set feedback on
set define on
prompt Done.
