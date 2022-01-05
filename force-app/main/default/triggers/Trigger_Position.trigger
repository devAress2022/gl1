trigger Trigger_Position on DAM01__Position__c (after update)
{
    List<DAM01__Job_Application__c> jobApp =new List<DAM01__Job_Application__c>();    
    for(DAM01__Position__c pos : trigger.new)
    {
        if(pos.DAM01__Status__c=='Open - Approved' && trigger.oldmap.get(pos.Id).DAM01__Status__c =='Pending Approval')
        {             
            DAM01__Job_Application__c job =new DAM01__Job_Application__c();
            job.DAM01__Position__c = pos.Id;
            jobApp.add(job);
        }
        insert jobApp;
    }
}