package jp.educure.problem4.customannotation;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LogExecutionAspect {

    @Around("@annotation(jp.educure.problem4.customannotation.LogExecution)")
    public Object logExecution(ProceedingJoinPoint joinPoint) throws Throwable {

        String method = joinPoint.getSignature().toString();

        System.out.println("[LOG] 開始: " + method);

        try {
            return joinPoint.proceed();
        } finally {
            System.out.println("[LOG] 終了: " + method);
        }
    }
}