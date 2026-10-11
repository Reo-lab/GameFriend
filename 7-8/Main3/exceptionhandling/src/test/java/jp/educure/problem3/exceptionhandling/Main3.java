package jp.educure.problem3.exceptionhandling;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Main3 {

    public static void main(String[] args) {
        SpringApplication.run(Main3.class, args);
    }

    @Bean
    public CommandLineRunner run(UsermanagementService service) {
        return args -> {

            User user = new User("John Doe", "john.doe@example.com");
            service.createUser(user);

            User errorUser = new User("Error User", "error@example.com");

            try {
                service.createUser(errorUser);
            } catch (RuntimeException ex) {

            }
        };
    }
}