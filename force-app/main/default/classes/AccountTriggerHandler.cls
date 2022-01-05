public class AccountTriggerHandler {
    
    public static void afterAccountUpdate(List<Account> Acc){
        List<Contact> lstCon = New List<Contact>();
        List<Contact> UpdateLstCon = New List<Contact>();
        Set <Id> accIdFalse = New Set <Id>();
        Set <Id> accIdTrue = New Set <Id>();
        for(Account a:Acc){
            if(a.DAM01__Activate_Contacts__c==False){
                accIdFalse.add(a.Id);
            }
            if(a.DAM01__Activate_Contacts__c==True){
                accIdTrue.add(a.Id);
            }
        }
        lstCon=[SELECT Id, AccountId, Name, DAM01__Active__c FROM Contact WHERE AccountId IN:accIdFalse];
        for(Contact con : lstCon){
            Contact updateCon = New Contact();
            updateCon.Id =con.Id;
            updateCon.DAM01__Active__c=False;
            UpdateLstCon.add(updateCon);
        }
        lstCon=[SELECT Id, AccountId, Name, DAM01__Active__c FROM Contact WHERE AccountId IN:accIdTrue ];
        for(Contact con : lstCon){
            Contact updateCon = New Contact();
            updateCon.Id =con.Id;
            updateCon.DAM01__Active__c=True;
            UpdateLstCon.add(updateCon);
        }
        if(UpdateLstCon.Size()>0){
            update UpdateLstCon;
        }
        
    }
}