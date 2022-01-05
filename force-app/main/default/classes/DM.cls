public class DM {
    public static void getAccount(){
        Integer conCount=0;
        Integer oppCount=0;
        Id accId;
        
        List <Account> accObj =[SELECT Id, Name,(SELECT Id, Name From Contacts),(SELECT Id, Name, StageName FROM Opportunities WHERE StageName IN ('Closed Won', 'Closed Lost')) FROM Account];
        For(Account acc :accObj){
            accId =acc.Id;
            for(Contact con :acc.Contacts){
                conCount++;
                
                
            }
            
            for(Opportunity opp :acc.Opportunities){
                oppCount++;
                
            }
            
            
            
        }
        if(conCount>100){
                    System.debug('conCount'+conCount);
                    
                    System.debug('accId'+accId);
                }
        if(oppCount>=20){
                    
                    System.debug('oppCount'+oppCount);
                    System.debug('accId'+accId);
                }
        
        
    }
}