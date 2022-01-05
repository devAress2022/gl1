global class PositionBatch implements Database.Batchable<sObject> {
    global String [] email =New String[]{'dipak.mali@aress.com'};
        global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String Status = 'Open - Approved';

        return Database.getQueryLocator('SELECT Id, Name, DAM01__Status__c, DAM01__Job_Description__c FROM DAM01__Position__c WHERE DAM01__Status__c=:Status');
        
    }
    global void execute(Database.BatchableContext BC,List<sObject> Scope){
        List<DAM01__Position__c > updatePositionList =new List<DAM01__Position__c > ();
        for(sobject	objscope :Scope){
            DAM01__Position__c  newObjScope = (DAM01__Position__c ) objscope;
            newObjScope.DAM01__Job_Description__c  ='Updated via Batch Job 22/09/2021';
           
            updatePositionList.add(newObjScope);
            
        }
        if(updatePositionList !=null && updatePositionList.size() >0){
            Database.update(updatePositionList);
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