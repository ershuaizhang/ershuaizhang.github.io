package org.joven.consume2;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

//表示当前服务是一个 Eureka 的客户端 向注册中心上注册服务 @EnableEurekaClient 只适用于Eureka作为注册中心，@EnableDiscoveryClient 可以是其他注册中心
@EnableDiscoveryClient
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
public class ServiceConsume2 {
    public static void main(String[] args) {
        SpringApplication.run(ServiceConsume2.class, args);
    }
}
