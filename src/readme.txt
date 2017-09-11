*.请不要擅自修改目录结构和文件,只允许修改自己负责的项目模块的文件和结构;

*.包结构
	com.sht.action:全局的action,所有的action继承之,一般不修改;
	com.sht.mapper:全局的,mybatis自动生成的mapper,一般不修改;
	com.sht.po:全局的,mybatis自动生成的普通的java类,子模块一般继承其中的类,一般不修改;
	com.sht.util:全局的,工具包,子模块一般继承其中的类,一般不修改;
	com.sht.service:全局的,service接口;
	com.sht.service.impl:全局的,service实现;
	子模块结构类似,但是本模块开发者可以修改;
	
*.类命名规范:
	类:
		action层:
			xxAction
		service层:
			接口:
				xxServiceI
			实现类:
				xxService
		mapper(dao)层:
			接口:xxMapper
	

*.servie层,dao层,action层的每个public方法都需要声明抛出java.lang.Exeption级别的异常;

*.所有的action继承BaseAction;

*.dao(mybatis),service,action都采用注解将bean添加到spring容器,采用的注解分别为:
	@Repository,@Service,@Controller;