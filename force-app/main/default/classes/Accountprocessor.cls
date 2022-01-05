public with sharing class Accountprocessor {
    public static void onAfterSave(List<Contact> contacts){
        Set<id> acctIds =new Set<id>();
        for(Contact con :contacts){
            if(con.AccountId!=null){
                acctIds.add(con.AccountId);
            }
        }
        if(acctIds.size() > 0 && acctIds !=null){
            updateAccount(acctIds);
        }
    }
    
  //  @future(callout=false)
    private static void updateAccount(Set<Id> accIds){
        List<Account> accnts  = [SELECT Id, Name, DAM01__No_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id=:accIds] ;
        system.debug('Query result==: '+ accIds.size());
        for( Account acc :accnts ){
            List<Contact> cons =acc.Contacts;
            acc.DAM01__No_of_Contacts__c= cons.Size();
            System.debug('Accounts: 	'+acc.Name+'has'+ acc.DAM01__No_of_Contacts__c+'Contact childs');
        }
        try{
            update accnts;
        }
        catch(DmlException	e){
            throw new StringException('Faild to Update the account :'+e.getMessage());
            
        }
    }
    
    
}