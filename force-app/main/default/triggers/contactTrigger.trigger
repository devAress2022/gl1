trigger contactTrigger on Contact (after insert,after delete) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            Accountprocessor.onAfterSave(Trigger.New);
            ContactTriggerHandler.contactAfterInsert(Trigger.New);
        }
        
        if(Trigger.isDelete){
            Accountprocessor.onAfterSave(Trigger.old);
        }
    }
    
}