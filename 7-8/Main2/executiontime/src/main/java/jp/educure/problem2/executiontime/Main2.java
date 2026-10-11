package jp.educure.problem2.executiontime;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Main2 {

    public static void main(String[] args) {
        SpringApplication.run(Main2.class, args);
    }

    @Bean
    public CommandLineRunner run(CalculatorService calculatorService) {
        return args -> {
            calculatorService.add(10, 5);
            calculatorService.subtract(10, 5);
            calculatorService.multiply(10, 5);
            calculatorService.divide(10, 5);

            try {
                calculatorService.divide(10, 0);
            } catch (ArithmeticException e) {
                System.out.println(e.getMessage());
            }
        };
    }
}