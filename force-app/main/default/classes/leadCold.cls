global class leadCold implements Messaging.InboundEmailHandler{
    Lead[] newlead = new Lead[0];
    
    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope){
            Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
            String emailAddress= envelope.fromAddress;
            String fName= email.fromname.substring(0,email.fromname.indexof(' '));
            String lName= email.fromname.substring(email.fromname.indexof(' '));
            String statusSet;
            System.debug('email'+email);
              System.debug('envelope'+envelope);
            if(email.subject=='Cold'){
                       statusSet  = 'Closed - Converted';
                                            }
            else{
                statusSet = 'Open - Not Contacted';
            }
            try{
                newlead.add(new Lead(
                    FirstName=fName,
                    LastName=lName,
                    Email =emailAddress,
                    Company ='$'+fName+lName,
                    Rating=email.subject,
                    Status = statusSet

                    
                    
                ));
               
                insert newlead;
            }
            catch(System.DmlException e){
                system.debug('Error: Not able to create Candidate :'+e);
            }
            
            
            
            return result;
            
        }
    
}