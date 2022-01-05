trigger AccountTrigger on Account (after update) {
    
        if(Trigger.isAfter){
        if(Trigger.isUpdate){
            AccountTriggerHandler.afterAccountUpdate(Trigger.New);
        }
        }

}