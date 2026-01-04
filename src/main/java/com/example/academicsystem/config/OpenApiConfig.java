package com.example.academicsystem.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("高校实习教务管理系统 API")
                        .description("基于 Spring Boot + MyBatis 的教务管理后端示例")
                        .version("0.0.1"));
    }
}
