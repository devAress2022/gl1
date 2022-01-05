global class Contact_Attachment implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail Email,Messaging.InboundEnvelope env)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String subToCompare ='Create Contact';
        List<Attachment> attchList = new List<Attachment>();
        Contact c =new Contact();
        if(email.subject.equalsIgnoreCase(subToCompare))
        {
            	
            c.LastName=email.plainTextBody;
            insert c;
            system.debug('contact id'+c.Id);
            
        }
        if(email.textAttachments!=null){
            for(Messaging.InboundEmail.TextAttachment tAttch: email.textAttachments)
            {
                attachment att=new attachment();
                att.Name=tAttch.filename;
                att.Body=blob.valueOf(tAttch.body);
                att.ParentId=c.Id;
                System.debug('textAttachments'+c.Id);
                 System.debug('ParentId'+c.Id);
                attchList.add(att);
                
                
                
            }
        }
       if(email.binaryAttachments!=null){
            for(Messaging.InboundEmail.binaryAttachment battch :email.binaryAttachments)
            {
                Attachment attchment = new Attachment();
                attchment.Name=battch.filename;
                attchment.Body=battch.body;
                attchment.ParentId=c.id;
                System.debug('binaryAttachments'+c.Id);
                 System.debug('ParentId'+c.Id);
                attchList.add(attchment);
            }
       }
        if(!attchList.isEmpty()){
            insert attchList; 	
            System.debug('Attchment'+attchList);
        }
        result.success=true;
            return result;
    }
}