package jp.educure.problem2.executiontime;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ExecutionTimeAspect {

    @Around(
        "execution(* jp.educure.problem2.executiontime.CalculatorService.*(..))"
    )
    public Object measureExecutionTime(
            ProceedingJoinPoint joinPoint) throws Throwable {

        long startTime = System.nanoTime();

        try {
            return joinPoint.proceed();
        } finally {
            long elapsedTime =
                    (System.nanoTime() - startTime) / 1_000_000;

            String method = joinPoint.getSignature()
                    .toString()
                    .replace(",", ", ");

            System.out.println(
                    "execution + " + method
                    + " + executed in " + elapsedTime + "ms"
            );
        }
    }
}