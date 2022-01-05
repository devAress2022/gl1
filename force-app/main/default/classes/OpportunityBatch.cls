global class OpportunityBatch implements Database.Batchable<sObject>{
    global String [] email =New String[]{'dipak.mali@aress.com'};
        global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String stageName= 'Closed Won';
        return Database.getQueryLocator('SELECT Id, Name, StageName, CloseDate,AccountId FROM Opportunity WHERE StageName=:stageName AND CloseDate =NEXT_N_DAYS:5');
        
    }
    global void execute(Database.BatchableContext BC,List<Opportunity> Scope){

        Map<Id, Opportunity> opp = new Map<Id, Opportunity>(Scope);
        System.debug('BatchArticleEmail   ' +opp);       
        for(Opportunity oppty : opp.Values()) {
            System.debug('--------------'+oppty.Id);
            Account acc=[SELECT Id, Name, DAM01__Email__c FROM Account WHERE Id=:oppty.AccountId];
            Contact con=[Select Id,name,AccountId From Contact Where AccountId=:oppty.AccountId];
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setTargetObjectId(con.id); 
            message.setSenderDisplayName('Company Support'); 
            message.setReplyTo('no-reply@company.com');
            message.setUseSignature(false); 
            message.setBccSender(false); 
            message.setSaveAsActivity(false); 
            EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'opportunity closing notification'];
            message.setTemplateID(emailTemplate.Id); 
            message.setWhatId(oppty.Id); //This is important for the merge fields in template to work
            message.toAddresses = new String[] { acc.DAM01__Email__c};
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                    System.debug('messages'+messages);
            System.debug('messages'+messages.Size());
            Messaging.SendEmailResult[] results = New Messaging.SendEmailResult[]{};
                if(messages.Size()>0){
                    results = Messaging.sendEmail(messages);
                }
            if (results[0].success) 
            {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' +  results[0].errors[0].message);
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        
        
    }
    
    
}

        /* system.debug('Scope'+Scope);
Map<Id, Opportunity> opp = new Map<Id, Opportunity>(Scope);
System.debug('BatchArticleEmail Known_Error_Subscription__c Map ' +opp);
List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
EmailTemplate template = [SELECT Id,Name,HTMLValue, Subject,Body FROM EmailTemplate 
WHERE Name ='opportunity closing notification'];
System.debug('template'+template);
for(Opportunity oppty : opp.Values()) {
System.debug('--------------'+oppty.Id);
Account acc=[SELECT Id, Name, DAM01__Email__c FROM Account WHERE Id=:oppty.AccountId];
Contact con=[Select Id,name,AccountId From Contact Where AccountId=:oppty.AccountId];
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setTargetObjectId(acc.Id);
Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(template.Id, con.Id, oppty.Id);            
String[] sendingTo = new String[]{acc.DAM01__Email__c};
mail.setToAddresses(sendingTo);
mail.setSubject(template.Subject);
mail.setSaveAsActivity(false);
mail.setHtmlBody(template.Body);
allmsg.add(mail);  
}
Messaging.SendEmailResult [] results = Messaging.sendEmail(allmsg, False);
System.debug('result'+results);
for(Messaging.SendEmailResult res : results) {
System.debug('Email result: ' + res.isSuccess());
if(res.IsSuccess()) {
System.debug('isSuccess');
}
System.debug('Error: ' +  res.getErrors());
} */