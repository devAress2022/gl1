public  class comp1 {
    @AuraEnabled
    public static List<DAM01__Customer1__c> customer(){
        List<DAM01__Customer1__c> cust =[SELECT Id, Name, DAM01__Status__c, DAM01__Description__c, DAM01__Active__c FROM DAM01__Customer1__c];
        system.debug(cust);
        return cust;
    }

}