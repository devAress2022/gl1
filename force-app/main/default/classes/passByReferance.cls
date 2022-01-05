public class passByReferance {
    
    public void mainMethod(){
        Account a = new Account();
        a.Name = 'Deepak';
        a.Website ='www.sf.com';
        system.debug('Before=====>'+a);
        passbyref(a);
        system.debug('After=====>'+a);
        
        
    }
    
    public void passbyref(Account a){
        a.Website='www.salesforce.com';
        
        
    }
    

}