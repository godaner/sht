/**
 * 00:00
 */

/**
 * 游客访问记录
 */
CREATE TABLE wander_log(
       ID NVARCHAR2(40) PRIMARY KEY,
       ip NVARCHAR2(20) NOT NULL,
       page NVARCHAR2(40) NOT NULL,
       old_link NVARCHAR2(40),
       title NVARCHAR2(40),
       SYSTEM NVARCHAR2(40) NOT NULL,
       dpi NVARCHAR2(40),
       browser NVARCHAR2(40) NOT NULL,
       country NVARCHAR2(40) NOT NULL,
       province NVARCHAR2(40) NOT NULL,
       city NVARCHAR2(40) NOT NULL,
       keyword NVARCHAR2(40),
       TIME TIMESTAMP(6) NOT NULL
       
       
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




/**
 * 用户登录记录
 */
CREATE TABLE users_login_log(
       ID NVARCHAR2(40) PRIMARY KEY,
       login_user NVARCHAR2(40) NOT NULL,
       ip NVARCHAR2(20) NOT NULL,
       SYSTEM NVARCHAR2(40) NOT NULL,
       dpi NVARCHAR2(40),
       browser NVARCHAR2(40) NOT NULL,
       country NVARCHAR2(40) NOT NULL,
       province NVARCHAR2(40) NOT NULL,
       city NVARCHAR2(40) NOT NULL,
       TIME TIMESTAMP(6) NOT NULL,
       RESULT NUMBER(1) NOT NULL,
       CONSTRAINT u_l_l_fk_login_user FOREIGN KEY (login_user) REFERENCES users(ID)
);
comment on column users_login_log.ID
  is '主键';
comment on column users_login_log.LOGIN_user
  is '登录的用户';
comment on column users_login_log.IP
  is 'ip地址';
comment on column users_login_log.SYSTEM
  is '系统,例如windows';
comment on column users_login_log.DPI
  is '分辨率,例如1920x1080';
comment on column users_login_log.BROWSER
  is '浏览器';
comment on column users_login_log.COUNTRY
  is '登录国家';
comment on column users_login_log.PROVINCE
  is '登录省份';
comment on column users_login_log.CITY
  is '登录城市';
comment on column users_login_log.TIME
  is '登陆时间';
comment on column users_login_log.RESULT
  is '1为登录成功,0为因为登录失败';
  
  
/**
 * 管理员登录记录
 */
CREATE TABLE admins_login_log(
       ID NVARCHAR2(40) PRIMARY KEY,
       login_admin NVARCHAR2(40) NOT NULL,
       ip NVARCHAR2(20) NOT NULL,
       SYSTEM NVARCHAR2(40) NOT NULL,
       dpi NVARCHAR2(40),
       browser NVARCHAR2(40) NOT NULL,
       country NVARCHAR2(40) NOT NULL,
       province NVARCHAR2(40) NOT NULL,
       city NVARCHAR2(40) NOT NULL,
       TIME TIMESTAMP(6) NOT NULL,
       RESULT NUMBER(1) NOT NULL,
       CONSTRAINT u_l_l_fk_login_admin FOREIGN KEY (login_admin) REFERENCES ADMINs(ID)
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

