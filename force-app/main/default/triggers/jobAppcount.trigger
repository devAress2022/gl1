trigger jobAppcount on DAM01__Job_Application__c  (after insert,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            jobApllicationCount.afterInsert(Trigger.New);
        }
        if(Trigger.isDelete){
            jobApllicationCount.afterInsert(Trigger.old);
        }
    }
}