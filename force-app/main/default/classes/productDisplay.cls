public class productDisplay {
    List<Product2> lstAcc = new  List<Product2>();
    @AuraEnabled
    public static List<Product2> GetProduct()
    {
        List<Product2> lstProduct=[Select Name,DefaultQuantity__c,Description,TYPE__c FROM Product2 Limit 10];
        return lstProduct;
    } 
    @AuraEnabled
    public static List<Product2> delAccount(String[] lstAccountId){
        string msg='';
        List<Product2> lstAcc=[Select Name,DefaultQuantity__c,Description,TYPE__c FROM Product2 WHERE Id IN: lstAccountId];
        system.debug('lstAcc'+lstAcc);
        return lstAcc;
    }
    @AuraEnabled
    public static String updateProduct2(List<Product2> draftvalues,String recId){
        string msg='';
        List<Product2> newProductList = new  List<Product2>();
        List<PriceBookEntry> newEntry = new  List<PriceBookEntry>();
        system.debug('draftvalues'+draftvalues);
        system.debug('selectedIds'+recId);
        //system.debug('temp'+temp);
        Map<ID,String> mapProd = New Map<Id,String>();
        List<Product2> lstprod2 = [Select Id,Name  from Product2];
        for(Product2 prod : lstprod2 ){
            mapProd.put(prod.Id,prod.Name);     
        }
        Opportunity OppName = [Select Id,Name From Opportunity where Id=:recId ];
        List<OpportunityLineItem> oppLineItem = New List<OpportunityLineItem> ();
        // List <PriceBookEntry> pb = [SELECT Id,Name, PriceBook2Id, UnitPrice FROM PriceBookEntry WHERE IsActive=TRUE AND Name !='GenWatt Diesel 200kW' ];
        for(Product2 p2 :draftvalues){
            Product2 pr = new Product2();
            pr.Name=mapProd.get(p2.Id);
            pr.isActive=true;
            pr.DefaultQuantity__c = p2.DefaultQuantity__c;
            //pr.Family=p2.Family;
            newProductList.add(pr) ;
        }
        if(newProductList.Size()>0){
            Insert newProductList;
        }
        map<Id, String> mapprod2 = New map<Id, String>();
        for(Product2 p3 :newProductList){
            mapprod2.put(p3.id,p3.DefaultQuantity__c);    
        }    
        PriceBook2 customPriceBook = new PriceBook2();
        customPriceBook.Name='Custom Pricebook';
        customPriceBook.IsActive=true;  
        insert customPriceBook;     
        //Pricebook2 customPriceBookRec=[select Id from Pricebook2 where id=:customPriceBook.Id ];
        Pricebook2 customPriceBookRec = [select id from Pricebook2 where isStandard=true];
        Id stdPriceBookRecId = customPriceBookRec.Id;
        for(Product2 prod2 : newProductList){
            PriceBookEntry customPriceBookEntry = new PriceBookEntry();
            customPriceBookEntry.Product2Id=prod2.Id;
            customPriceBookEntry.Pricebook2Id=stdPriceBookRecId;
            customPriceBookEntry.UnitPrice=5000;
            customPriceBookEntry.IsActive=true;
            newEntry.add(customPriceBookEntry);
        }
        if(newEntry.Size()>0){
            Insert newEntry;
        }
         Opportunity OppName1 = [Select Id,Name,Pricebook2Id  From Opportunity where Id=:recId ];
        OppName1.Pricebook2Id =stdPriceBookRecId;
        Update OppName1;
        for(PriceBookEntry PBE : newEntry ){
            OpportunityLineItem LineItem = new OpportunityLineItem();
            LineItem.OpportunityId = recId;
            LineItem.PricebookEntryId =PBE.ID;
            LineItem.UnitPrice = 7000;
            LineItem.Quantity = Decimal.valueOf(mapprod2.get(PBE.Product2Id));
            oppLineItem.add(LineItem);
        }
        if(oppLineItem.Size()>0){
            Insert oppLineItem;
        }
        return msg;       
    }   
      @AuraEnabled
    public static List<String> getPicklistvalues(String Product2, String Family,Boolean nullRequired){
        List<String> optionlist = new List<String>();
        
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get(Product2.toLowerCase()).getDescribe().fields.getMap(); 
        
        List<Schema.PicklistEntry> picklistValues = field_map.get(Family).getDescribe().getPickListValues();
        
        if(nullRequired == true){
            optionlist.add('--None--');
        }
        
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getValue());
        }
        return optionlist;
    }
}