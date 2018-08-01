package com.mashensoft.main;

import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.mashensoft.intercepter.AuthorityIntercepter;

@MapperScan("com.mashensoft.mapper")
@SpringBootApplication(scanBasePackages = "com.mashensoft")
public class Springboot2Application {
	Logger log = LoggerFactory.getLogger(Springboot2Application.class);

	public static void main(String[] args) {
		SpringApplication.run(Springboot2Application.class, args);
	}
//	@Configuration
//	 class WEbMvcCopnfigurer extends WebMvcConfigurerAdapter{
//		@Override
//		public void addInterceptors(InterceptorRegistry registry) {
//			registry.addInterceptor(new AuthorityIntercepter()).addPathPatterns("/admin/**");
//			super.addInterceptors(registry);
//		}
//	}
}
