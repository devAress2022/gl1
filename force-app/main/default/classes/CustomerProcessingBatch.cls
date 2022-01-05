global class CustomerProcessingBatch implements Database.Batchable<sObject> {
    global String [] email =New String[]{'dipak.mali@aress.com'};
        global Database.QueryLocator start(Database.BatchableContext BC)
    {
    return Database.getQueryLocator('SELECT Id, Name, DAM01__Status__c, DAM01__Active__c, DAM01__Description__c FROM DAM01__Customer1__c WHERE DAM01__Active__c=false ');
        
    }
    global void execute(Database.BatchableContext BC,List<sObject> Scope){
        List<DAM01__Customer1__c> updateCustomerList =new List<DAM01__Customer1__c> ();
        for(sobject	objscope :Scope){
            DAM01__Customer1__c newObjScope = (DAM01__Customer1__c) objscope;
            newObjScope.DAM01__Description__c ='Updated via Batch Job 22/09/2021';
            newObjScope.DAM01__Status__c='Pending';
            updateCustomerList.add(newObjScope);
            
        }
        if(updateCustomerList !=null && updateCustomerList.size() >0){
            Database.update(updateCustomerList);
        }
        
    }
    global void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        AsyncApexJob a= [SELECT a.TotalJobItems,a.Status,a.NumberOfErrors,a.JobType,a.JobItemsProcessed,a.ExtendedStatus,a.CreatedById,a.CompletedDate from AsyncApexJob a where id=:BC.getJobId()];
        mail.setToAddresses(email);
        mail.setReplyTo('dipak.mali@aress.com');
        mail.setSenderDisplayName('Apex Processing '+a.Status);
        mail.setPlainTextBody('The Batch Apex job Processed '+a.TotalJobItems+' Batches With '+a.NumberOfErrors +'failures'+ ' Job item processed are '+a.JobItemsProcessed);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail} );
        
    }
    
    

}