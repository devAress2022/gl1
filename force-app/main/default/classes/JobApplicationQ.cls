public class JobApplicationQ implements Queueable {
    List<DAM01__Job_Application__c> JA =new List<DAM01__Job_Application__c>();
    public JobApplicationQ(List<DAM01__Job_Application__c> JAlist){
        this.JA=JAlist;
    }
    public void execute(QueueableContext context)
    {
        for(DAM01__Job_Application__c job: JA)
        {
            job.DAM01__Description__c = 'Aress';
            
        }
        update JA;
    }
    
    

}