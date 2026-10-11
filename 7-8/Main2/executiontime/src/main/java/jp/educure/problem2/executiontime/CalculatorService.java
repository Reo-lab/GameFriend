package jp.educure.problem2.executiontime;

import org.springframework.stereotype.Service;

@Service
public class CalculatorService {

    public int add(int a, int b) throws InterruptedException {
        Thread.sleep(500);
        return a + b;
    }

    public int subtract(int a, int b) throws InterruptedException {
        Thread.sleep(300);
        return a - b;
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    public int divide(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("Division by zero");
        }

        return a / b;
    }
}