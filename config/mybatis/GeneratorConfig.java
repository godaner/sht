package mybatis;


import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * Title:GeneratorConfig
 * <p>
 * Description:mybatis逆向生成mapper接口,mapperxml,bean
 * <p>
 * 
 * @author Kor_Zhang
 * @date 2017年9月5日 下午4:44:27
 * @version 1.0
 */
public class GeneratorConfig {
	/**
	 * Title:
	 * <p>
	 * Description:生成入口
	 * <p>
	 * 
	 * @author Kor_Zhang
	 * @date 2017年9月5日 下午4:44:50
	 * @version 1.0
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		// 指定逆向工程配置文件
		File configFile = new File(GeneratorConfig.class.getResource("").getPath() + "generatorConfig.xml");
		ConfigurationParser cp = new ConfigurationParser(warnings);
		Configuration config = cp.parseConfiguration(configFile);
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
				callback, warnings);
		myBatisGenerator.generate(null);
	}
	

}
