public class ProjectController {
    
    @AuraEnabled
    public static List<DAM01__Action__c> getProjectAssigned(Id recID){
        List<DAM01__Action__c> act = [SELECT Id, Name, DAM01__Project__r.Name, DAM01__Budgeted_Hours__c, DAM01__Remaining_Hours__c, 
                               DAM01__Status__c, DAM01__Action_Owner__c FROM  DAM01__Action__c WHERE 
                               DAM01__Status__c =:Label.Assigned AND DAM01__Project__c =:recID];
        System.debug('lst----'+act);
        return act;
        
    }
     @AuraEnabled
    public static List<DAM01__Action__c> getProjectWIP(Id recID){
        List<DAM01__Action__c> act = [SELECT Id, Name, DAM01__Project__r.Name, DAM01__Budgeted_Hours__c, DAM01__Remaining_Hours__c, 
                               DAM01__Status__c, DAM01__Action_Owner__c FROM  DAM01__Action__c WHERE 
                               DAM01__Status__c =:Label.WIP AND DAM01__Project__c =:recID];
        System.debug('lst----'+act);
        return act;
        
    } @AuraEnabled
    public static List<DAM01__Action__c> getProjectValidating(Id recID){
        List<DAM01__Action__c> act = [SELECT Id, Name, DAM01__Project__r.Name, DAM01__Budgeted_Hours__c, DAM01__Remaining_Hours__c, 
                               DAM01__Status__c, DAM01__Action_Owner__c FROM  DAM01__Action__c WHERE 
                               DAM01__Status__c =:Label.Validating AND DAM01__Project__c =:recID];
        System.debug('lst----'+act);
        return act;
        
    }
     @AuraEnabled
    public static List<DAM01__Action__c> getProjectReadyToDeploy(Id recID){
        List<DAM01__Action__c> act = [SELECT Id, Name, DAM01__Project__r.Name, DAM01__Budgeted_Hours__c, DAM01__Remaining_Hours__c, 
                               DAM01__Status__c, DAM01__Action_Owner__c FROM  DAM01__Action__c WHERE 
                               DAM01__Status__c =:Label.Ready_To_Deploy AND DAM01__Project__c =:recID];
        System.debug('lst----'+act);
        return act;
        
    } @AuraEnabled
    public static List<DAM01__Action__c> getProjectOnHold(Id recID){
        List<DAM01__Action__c> act = [SELECT Id, Name, DAM01__Project__r.Name, DAM01__Budgeted_Hours__c, DAM01__Remaining_Hours__c, 
                               DAM01__Status__c, DAM01__Action_Owner__c FROM  DAM01__Action__c WHERE 
                               DAM01__Status__c =:Label.On_Hold AND DAM01__Project__c =:recID];
        System.debug('lst----'+act);
        return act;
        
    }

}