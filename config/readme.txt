*.请不要擅自修改该目录的文件信息(除db.properties,log4j.properties);

*.对于action的配置采用xml配置的方式,在classpath:struts/struts-*.xml中;struts配置文件命名规则为:
	struts-(front/back)-[模块名];例如struts-front-users.xml;
	
*.一个模块,一个struts文件,一个package,一个namespace;
	例如:
	<package namespace="/users" name="users-package" extends="base-package">

*.action标签的class可以使用注入到了spring的action的bean,例如
	<action name="usersAction" class="usersAction">

*.配置action的result的名称时,如果为转发则result的name开头为f,例如fIndex;
	如果为重定向,name开头为r,例如rIndex;

*.dao(mybatis),service,action都采用注解将bean添加到spring容器,采用的注解分别为:
	@Repository,@Service,@Controller;
	
*.开发者最多要配置的是struts配置文件;


*.action的路径配置使用 "通配符" + "namespace"
	例如:<action name="*" class="usersAction" method="{0}">
	访问方式:http://localhost/sht/users/login.action
	
*.在对struts配置时,在自己负责的模块中,能够使用全局的result或者exception就用全局的,避免重复