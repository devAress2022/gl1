global class createTask implements Messaging.InboundEmailHandler{
        global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail Email,Messaging.InboundEnvelope env){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
            String Myplaintext='';
            Task[] newTask=new Task[0];
            try{
                Contact vcon=[SELECT Id, Name, Email FROM Contact WHERE email=:email.fromAddress LIMIT 1];
                newTask.add(New Task(
                    Description=Myplaintext,
                    Priority='Normal',
                    Status='Inbound Email',
                    Subject=email.subject,
                    IsReminderSet=true, 
                    ReminderDateTime=System.now()+1,                    
                    WhoId=vcon.Id
                ));
                Insert newTask;
                System.debug('New Task Obj'+vcon.Name+'id='+vcon.Id);
            }
            catch(QueryException e){
                                System.debug('Query Issue'+e);

            }
            result.success=true;
            return result;
    }

}