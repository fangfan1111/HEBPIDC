package cn.huazx.ebp.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.baidu.fsg.uid.impl.CachedUidGenerator;

import cn.huazx.ebp.common.utils.SpringContextHolder;
import cn.huazx.ebp.modules.sys.utils.UserUtils;

/**
 * 
 * @author fu
 *
 */
public class UuidUtil{
	public static void main(String[] args) {
		ApplicationContext con=new ClassPathXmlApplicationContext("classpath:spring-context.xml","classpath:spring-context-activiti.xml","classpath:spring-context-shiro.xml","classpath:spring-context-uid.xml");
		CachedUidGenerator idgene=SpringContextHolder.getBean("cachedUidGenerator");
		for(int i=0;i<10;i++) {
		System.out.println(idgene.getUID());
		System.out.println("----->"+UserUtils.getLongId());
		}
	}
}
