package jp.educure.problem1.loginauth;

import org.springframework.stereotype.Component;

@Component 
public class UserSession {
    private final boolean islogIn = false;

    public boolean isLoggedIn(){
        return islogIn;
    }
}
