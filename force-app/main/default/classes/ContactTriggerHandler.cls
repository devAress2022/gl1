public class ContactTriggerHandler {
    
    public static void contactAfterInsert(List<Contact> con){
        List<Contact> lstContact = New List<Contact>();
        Set<Id>AccId = New Set<Id>();
        Id ConId;
        for(Contact c: con){
            if(c.AccountId!=Null){
                AccId.add(c.AccountId);
                ConId=c.Id;
                
                }
            }
       List <Account> accObj =[SELECT Id, Name, DAM01__Activate_Contacts__c FROM Account WHERE Id IN:AccId];
        for(Account Acc :accObj){
                if(Acc.DAM01__Activate_Contacts__c==True){
                    Contact conObj = New Contact();
                    conObj.Id =ConId;
                    conObj.DAM01__Active__c = True;
                    lstContact.add(conObj);
            
                }
           
            
        }
        if(lstContact.Size()>0){
           Update lstContact; 
        }
        
        
        
    }
    
}