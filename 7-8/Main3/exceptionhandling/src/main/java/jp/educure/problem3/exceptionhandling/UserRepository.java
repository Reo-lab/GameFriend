package jp.educure.problem3.exceptionhandling;

import org.springframework.stereotype.Repository;

@Repository
public class UserRepository {

    public void save(User user) {

        if ("error@example.com".equals(user.getEmail())) {
            throw new RuntimeException(
                "Error: Unable to save user with email " + user.getEmail()
            );
        }

        System.out.println(
            "User saved: " + user.getName() + ", " + user.getEmail()
        );
    }
}