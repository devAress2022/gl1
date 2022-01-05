public class EditProduct {
    
    @AuraEnabled
    public static List<OpportunityLineItem> getOppProduct(Id recordId){
        
        return [SELECT Id, Name, Quantity,Product2Id,OpportunityId, TotalPrice, UnitPrice, ListPrice, Description, ServiceDate,Discount
                FROM OpportunityLineItem WHERE OpportunityId =: recordId ];
        
        
    }
    @AuraEnabled
    public static List<OpportunityLineItem> saveAccountList(List<OpportunityLineItem> draftvalues,Id recordId){
        if(draftvalues.Size()>0){
            update draftvalues;
        }
       
         return [SELECT Id, Name, Quantity,Product2Id,OpportunityId, TotalPrice, UnitPrice, ListPrice, Description, ServiceDate,Discount
                FROM OpportunityLineItem where OpportunityId =:recordId  ]; 
        
    }
     @AuraEnabled
    public static  List<OpportunityLineItem> cloneRow( List<OpportunityLineItem> draftvalues, Integer index){
        System.debug('draftvalues'+draftvalues);
        List<OpportunityLineItem> lstoppline = New List<OpportunityLineItem>();
       
            OpportunityLineItem OLI1 = draftvalues[index].clone(false, false, false, false);
        OLI1.TotalPrice=null;
       
        
     
        if(OLI1 != null){
           Insert OLI1; 
        }
        
        return [SELECT Id, Name, Quantity,Product2Id,OpportunityId, TotalPrice, UnitPrice, ListPrice, Description, ServiceDate,Discount
          FROM OpportunityLineItem WHERE OpportunityId =: draftvalues[index].OpportunityId ];
    }
      @AuraEnabled
    public static  List<OpportunityLineItem> delRow( List<OpportunityLineItem> draftvalues, Integer index){
       System.debug('delete');
        delete draftvalues[index];
        
        return [SELECT Id, Name, Quantity,Product2Id,OpportunityId, TotalPrice, UnitPrice, ListPrice, Description, ServiceDate,Discount
          FROM OpportunityLineItem 
                WHERE OpportunityId =: draftvalues[index].OpportunityId ];
    }
}