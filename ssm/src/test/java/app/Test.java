package app;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Test {
//get the list of spring beans
	public static void main(String args[]) {
		@SuppressWarnings("resource")
		ApplicationContext context=new ClassPathXmlApplicationContext("classpath:spring-mvc.xml");
		String[] str=context.getBeanDefinitionNames();
		for (String string : str) {
		System.out.println("..."+string);
		}

		}

}
