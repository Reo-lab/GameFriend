package jp.educure.problem5.multipleaspects;

import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    public void processPayment() throws InterruptedException {
        System.out.println("支払い処理を実行中...");

        Thread.sleep(500);

        System.out.println("支払い完了");
    }
}