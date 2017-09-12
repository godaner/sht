*.请不要擅自修改目录结构和文件,只允许修改自己负责的项目模块的文件和结构;

*.包结构
	包含action,mapper,po,service,users,util,模块包等包;

*.模块包结构同上述;
	
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

*.所有的action继承BaseAction,所有的service继承BaseService;
	原因:
		因为BaseXX中含有许多工具,方便开发中直接调用;
		因为BaseXX中提供了封装前台参数的对象po;
		因为BaseXX中提供了实例业务对象service;
		
*.action中最好只有一个参数接受类(已经被BaseAction封装),一个Service(已经被BaseAction封装),service层中可以有多个mapper(dao);

*.dao(mybatis),service,action,po都采用注解将bean添加到spring容器,采用的注解分别为:
	@Repository,@Service,@Controller,@Component;

*.开发者最多要配置的是struts配置文件;

*.项目中不要使用生成的po,使用方法为:继承生成的po然后使用,例如com.sht.users.po.CustomUsers

