trigger Trigger_Customer on DAM01__Customer1__c (after update) {
    List<DAM01__Invoice__c> invoice =new List<DAM01__Invoice__c>();
    for(DAM01__Customer1__c cust : trigger.new){
        if(cust.DAM01__Status__c=='Active' && trigger.oldmap.get(cust.Id).DAM01__Status__c =='Inactive'){
            DAM01__Invoice__c inv = new DAM01__Invoice__c();
            inv.DAM01__Status__c ='Pending';
            inv.DAM01__Customer1__c = cust.Id;
            invoice.add(inv);
        }
    }
Insert invoice;
}