@istest
global class testABC_test {
    
    @istest
    global static void createcontact(){
        Account a= new Account();
        a.Name='test';
        Insert a;
        
        test.startTest();
        testABC.createContact(a);
        test.stopTest();
        
        
        
        
    }
    

}