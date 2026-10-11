package jp.educure.problem3.exceptionhandling;

import org.springframework.stereotype.Service;

@Service
public class UsermanagementService {

    private final UserRepository userRepository;

    public UsermanagementService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void createUser(User user) {
        userRepository.save(user);
    }
}