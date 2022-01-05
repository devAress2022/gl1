public class testABC {

    public static void createContact(Account a){
        
        Contact c = new Contact();
        c.LastName= a.name;
        c.Email = a.name+'@gmail.com';
        c.AccountId =a.id;
        
        insert c;
        
    }
    
    
    
}