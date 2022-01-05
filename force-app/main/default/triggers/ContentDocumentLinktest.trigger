trigger ContentDocumentLinktest on ContentDocumentLink (after insert) {
    if(trigger.isAfter && trigger.isInsert) {   
        
        ContentDocumentLinkTriggerHandler.onAfterInsert(trigger.new);
    }
}