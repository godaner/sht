*.请不要擅自修改该目录的文件信息;
*.dao(mybatis),service,action都采用注解将bean添加到spring容器,采用的注解分别为:
	@Repository,@Service,@Controller;
	
*.对于action的配置采用xml配置的方式,在classpath:struts/struts-*.xml中;struts配置文件命名规则为:
	struts-(front/back)-[模块名];例如struts-front-users.xml;
	
*.对于每一个struts文件,一般要求有一个新的package,并且继承引用本struts文件的文件中的packgae;
	新的pakeage一般以本模块命名;例如
	<package namespace="/front/users" name="front-users-package" extends="front-package">

*.action标签的class可以使用注入到了spring的action的bean,例如
	<action name="usrAction" class="usrAction">

*