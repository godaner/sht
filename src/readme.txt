*.请不要擅自修改目录结构和文件,只允许修改自己负责的项目模块的文件和结构;

*.包结构
	包含action,mapper,po,service,util,模块包(users等)等包;

*.模块包结构同上述;
	
*.类命名规范:
	类:
		在本模块的类中加上本模块名的首字母大写,避免冲突
	

*.servie层,dao层,action层的每个public方法都需要声明抛出java.lang.Exeption级别的异常;

*.*.业务层不符合判断的可以直接向上抛出异常,由action捕获处理;

*.所有的action继承xxBaseAction,所有的service继承xxBaseAction;
	原因:
		因为xxBaseAction和xxBaseService中含有许多工具,方便开发中直接调用;通过xx()调用;
		因为xxBaseAction中提供了封装前台参数的对象po;通过po.xx()调用;
		因为xxBaseAction中提供了实例业务对象service;通过service.xx()调用;
		
*.action中最好只有一个参数接受类(已经被BaseAction封装),一个Service(已经被BaseAction封装);但是service层中可以有多个mapper(dao);

*.dao(mybatis),service,action,po都采用注解将bean添加到spring容器,采用的注解分别为:
	@Repository,@Service,@Controller,@Component;

*.开发者最多要配置的是struts配置文件;

*.项目中不要直接使用生成的po;正确的做法:在本模块的po包继承生成的po然后使用,例如com.sht.users.po.CustomUsers

*.如果想要自定义本模块的工具类,原则上应该继承上一层的util包中的工具类;

*.action的scope为@Scope("prototype")

