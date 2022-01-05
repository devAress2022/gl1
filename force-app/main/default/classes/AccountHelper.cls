public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Type, Rating,
                Phone, Website, AnnualRevenue
                FROM Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Account.Name, Email, Title, Phone FROM Contact];
    }
}