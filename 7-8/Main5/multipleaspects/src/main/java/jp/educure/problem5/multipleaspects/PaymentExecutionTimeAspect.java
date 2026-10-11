package jp.educure.problem5.multipleaspects;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Order(3)
public class PaymentExecutionTimeAspect {

    @Around("execution(* jp.educure.problem5.multipleaspects.PaymentService.*(..))")
    public Object measureExecutionTime(ProceedingJoinPoint joinPoint)
            throws Throwable {

        long startTime = System.nanoTime();

        try {
            return joinPoint.proceed();
        } finally {
            long elapsedTime =
                (System.nanoTime() - startTime) / 1_000_000;

            String methodName = joinPoint.getSignature().getName();

            System.out.println(
                "[実行時間] " + methodName + ": " + elapsedTime + "ms"
            );
        }
    }
}