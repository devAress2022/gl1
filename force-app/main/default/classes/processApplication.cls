global class processApplication implements Messaging.InboundEmailHandler {
    DAM01__Candidate__c[] newCandidate = new DAM01__Candidate__c[0];
    DAM01__Job_Application__c[] newApplication =new DAM01__Job_Application__c[0];
    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope){
            Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
            String emailAddress= envelope.fromAddress;
            String fName= email.fromname.substring(0,email.fromname.indexof(' '));
            String lName= email.fromname.substring(email.fromname.indexof(' '));
            try{
                newCandidate.add(new DAM01__Candidate__c(
                    DAM01__First_Name__c=fName,
                    DAM01__Last_Name__c=lName,
                    DAM01__Email__c =emailAddress
                ));
                insert newCandidate;
            }
            catch(System.DmlException e){
                system.debug('Error: Not able to create Candidate :'+e);
            }
            
            
            DAM01__Position__c pos;
            pos=[select Id from DAM01__Position__c where name=:email.subject limit 1];
            Id jobid= pos.Id;
            
            newApplication.add(new DAM01__Job_Application__c(
                DAM01__Position__c=jobid,
                DAM01__Candidate__c = newCandidate[0].id)
                              );
            insert newApplication;
            return result;
            
        }
}