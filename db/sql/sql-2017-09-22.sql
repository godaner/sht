/**
 * 9:26
 */
/*添加admins的email字段*/
ALTER TABLE admins add email nvarchar2(255);
/*修改admins的username字段*/
ALTER TABLE admins modify username nvarchar2(255);

/**
 * 11:41
 */
/*主题注解*/
COMMENT ON COLUMN admins.THEME
IS '管理员的界面主题'
/*emial注解*/
COMMENT ON COLUMN admins.email
IS '管理员的邮箱'
