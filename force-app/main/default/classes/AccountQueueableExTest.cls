@isTest
public class AccountQueueableExTest {
@testsetup
    Static void setup(){
        List<Account> accounts 	= new List<Account>();
        for(Integer i=0;i<100;i++){
            accounts.add(New Account(Name='Test Account'+i));
        }
        Insert accounts;
        
    }
    static testmethod void testQueueable(){
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];
AccountQueueableEx accQobj= new AccountQueueableEx(accounts);
        Test.startTest();
        System.enqueueJob(accQobj);
        Test.stopTest();
        System.assertEquals(100, [SELECT count() FROM Account WHERE Name LIKE '%Test Account%']);
    }
}