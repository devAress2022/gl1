public class testObjField {
    
    public static void test()
    {
        String query ='';
        String SobjectApiName = 'Account';
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
        
        String strFields = '';
        String conWhere ='';
        
        for(String fieldName : fieldMap.keyset() )
            
        {
            if(strFields == null || strFields == '')
            {
                strFields = fieldName;
                conWhere = fieldName+'!=null';
            }else{
                strFields = strFields + ' , ' + fieldName;
                if(fieldName =='BillingAddress' || fieldName =='ShippingAddress' || fieldName=='description')
                {
                   // System.debug(fieldName);
                    
                }else{
                   // System.debug(fieldName);
                    conWhere = conWhere +' '+ 'OR '+' '+fieldName+'!=null';
                }    
            }
        }
        System.debug('conWhere-->'+conWhere);
        
        query = 'select ' + strFields + ' from ' + SobjectApiName + ' Where '+conWhere+' Limit 1 ';
        
        Account accList = Database.query(query);
        String abc = String.valueOf(accList);
        abc = abc.toLowerCase();
        System.debug('abc=='+abc);
        
        
        List<String> lstAlpha = strFields.split(','); 
        System.debug('lstAlpha=='+lstAlpha);
        List<String> lstAlpha2 = New List<String>();
        Map<String,String> mapacc = New Map<String,String>();
       //String a='Account:{Id=0015g00000Ur1i7AAB, IsDeleted=false, Name=opp 2 close, BillingAddress=null, ShippingAddress=null, PhotoUrl=/services/images/photo/0015g00000Ur1i7AAB, OwnerId=0055g000006DxPJAA0, CreatedDate=2021-10-12 10:41:21, CreatedById=0055g000006DxPJAA0, LastModifiedDate=2021-10-12 13:25:40, LastModifiedById=0055g000006DxPJAA0, SystemModstamp=2021-10-12 13:25:40, LastViewedDate=2021-10-13 06:26:13, LastReferencedDate=2021-10-13 06:26:13, CleanStatus=Pending, DAM01__Out_of_Business__c=false, DAM01__No_of_Contacts__c=1, DAM01__Activate_Contacts__c=false, DAM01__Email__c=dipak.mali@aress.com}';
  //a = a.toLowerCase();
     //   System.debug('a=='+a);

        For(Integer i = 0; i< lstAlpha.size(); i++){
           
            String t = lstAlpha[i].replaceAll( '\\s+', '');
             System.debug('**'+t+'**');
            if(abc.contains(t)){
             if(abc.contains(t+'=null')){
                 System.debug('@@@'+lstAlpha[i]);
             }
            }
            
            
        }
        
        System.debug('==========>'+lstAlpha2.Size());
        
         
            
        
        
        if(accList.Id != null)
        {
            system.debug('Id==============>>>>>'+accList.Id);
            system.debug('strFields==============>>>>>'+lstAlpha);
        }
        System.debug('accList'+accList);
    }
}