public with sharing class UserController {
    @AuraEnabled
    public static List<User> getUserList() {
        return [Select id,name,email FROM User ];
    }
}