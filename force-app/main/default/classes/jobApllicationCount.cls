public with sharing class jobApllicationCount {
    
    public Static void afterInsert(List <DAM01__Job_Application__c> jobapp){
         Set<id> pos =new Set<id>();
        for(DAM01__Job_Application__c ja :jobapp){
            if(ja.DAM01__Position__c!=null){
                pos.add(ja.DAM01__Position__c);
            }
        }
        if(pos.size() > 0 && pos !=null){
            updateCount(pos);
        }
        
    }
    @future(callout=false)
    public static void updateCount(Set<id> pos)
    {
        List<Position__c> poss  = [SELECT Id, Name, DAM01__No_of_Job_Applications__c, (SELECT Id FROM DAM01__Job_Applications__r) 
                                   FROM Position__c WHERE Id=:pos] ;
        system.debug('Query result==: '+ poss.size());
        for( Position__c p :poss ){
            List<DAM01__Job_Application__c> ja =p.DAM01__Job_Applications__r;
            p.DAM01__No_of_Job_Applications__c= ja.Size();
                    }
        try{
            update poss;
        }
        catch(DmlException	e){
            throw new StringException('Faild to Update the account :'+e.getMessage());
            
        }
    }
    

}