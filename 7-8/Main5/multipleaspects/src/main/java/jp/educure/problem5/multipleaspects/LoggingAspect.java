package jp.educure.problem5.multipleaspects;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Order(2)
public class LoggingAspect {

    @After("execution(* jp.educure.problem5.multipleaspects.PaymentService.*(..))")
    public void logAfter(JoinPoint joinPoint) {
        String methodName = joinPoint.getSignature().getName();

        System.out.println(
            "[ログ出力] " + methodName + " メソッドの実行が完了しました。"
        );
    }
}