public class ContentDocumentLinkTriggerHandler 
{
    public static void onAfterInsert(List<ContentDocumentLink> cdl) 
    {
        System.debug('cdl==='+cdl);
        List <ContentDocumentLink> condoc =new  List <ContentDocumentLink>(); 
        List<ContentDocument> attListToUpdate = new List<ContentDocument>();
        ContentDocument updateAcc = new ContentDocument();
        String fileName;
        if(cdl.size() > 0)
        {
            For(ContentDocumentLink con : cdl)
            {
                System.debug('ContentDocumentId==='+con.ContentDocumentId);
                System.debug('LinkedEntityId======'+con.LinkedEntityId);
                List<Form__c> frm1 = [SELECT Id, DAM01__Account__c, DAM01__Account__r.Name,DAM01__Opportunity__c,DAM01__Opportunity__r.Name, DAM01__Contact__c,DAM01__Contact__r.Name FROM DAM01__Form__c 
                                      Where Id =: con.LinkedEntityId];
                //form
                if(frm1.size()>0){
                    
                    
                    ContentDocumentLink condoc1 =[SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink Where id=:con.id];   
                    ContentDocument attListToUpdate1 =[SELECT Id, Title FROM ContentDocument WHERE id=:con.ContentDocumentId];
                    System.debug('condoc1========='+condoc1);
                    System.debug('attListToUpdate1============='+attListToUpdate1);
                    Form__c frm = [SELECT Id, DAM01__Account__c, DAM01__Opportunity__c, DAM01__Contact__c FROM DAM01__Form__c 
                                   Where Id =: con.LinkedEntityId];
                    System.debug('frm==========='+frm);
                    
                    System.debug('frm1============'+frm1);
                    fileName='Change Name'+System.now();
                    System.debug('fileName========='+fileName);
                    if(frm!=null)
                    {
                        for(Form__c form :frm1)
                        {
                            //form 
                            List<ContentDocumentLink> confrm =[SELECT Id, LinkedEntityId, ContentDocumentId FROM 
                                                               ContentDocumentLink Where LinkedEntityId=:form.id]; 
                            System.debug('conACC============'+confrm);
                            for(ContentDocumentLink cdl1:confrm){
                                
                                
                                
                                List<ContentDocument> cdfrm=[SELECT Id, Title, FileExtension FROM ContentDocument 
                                                             WHERE id=:cdl1.ContentDocumentId AND Title LIKE 'ROK Financial%'  ];
                                if(cdfrm.Size()>0){
                                    for(ContentDocument cd1:cdfrm){
                                        System.debug('cdAcc====='+cdfrm);
                                        if(cdfrm!=null){
                                            ContentDocument cd =new ContentDocument();
                                            cd.Id=cd1.Id;
                                            cd.Title=fileName;
                                            attListToUpdate.add(cd);
                                            
                                        }
                                    }
                                }
                            }
                            //Form END
                            //Acc
                           List<ContentDocumentLink> conAcc=[SELECT Id, LinkedEntityId, ContentDocumentId FROM 
                                                               ContentDocumentLink Where LinkedEntityId=:form.DAM01__Account__c]; 
                            System.debug('conACC============'+conAcc);
                            for(ContentDocumentLink cdl1:conAcc){
                                
                                
                                
                                List<ContentDocument> cdfrm=[SELECT Id, Title, FileExtension FROM ContentDocument 
                                                             WHERE id=:cdl1.ContentDocumentId AND Title LIKE 'ROK Financial%'  ];
                                if(cdfrm.Size()>0){
                                    for(ContentDocument cd1:cdfrm){
                                        System.debug('cdAcc====='+cdfrm);
                                        if(cdfrm!=null){
                                            ContentDocument cd =new ContentDocument();
                                            cd.Id=cd1.Id;
                                            cd.Title=fileName;
                                            attListToUpdate.add(cd);
                                            
                                        }
                                    }
                                }
                            }
                               
                           //acc end
                           //
                          //Contact
                          List<ContentDocumentLink> conCont=[SELECT Id, LinkedEntityId, ContentDocumentId FROM 
                                                               ContentDocumentLink Where LinkedEntityId=:form.DAM01__Contact__c]; 
                            System.debug('conACC============'+conCont);
                            for(ContentDocumentLink cdl1:conCont){
                                
                                
                                
                                List<ContentDocument> cdfrm=[SELECT Id, Title, FileExtension FROM ContentDocument 
                                                             WHERE id=:cdl1.ContentDocumentId AND Title LIKE 'ROK Financial%'  ];
                                if(cdfrm.Size()>0){
                                    for(ContentDocument cd1:cdfrm){
                                        System.debug('cdAcc====='+cdfrm);
                                        if(cdfrm!=null){
                                            ContentDocument cd =new ContentDocument();
                                            cd.Id=cd1.Id;
                                            cd.Title=fileName;
                                            attListToUpdate.add(cd);
                                            
                                        }
                                    }
                                }
                            }
                           //Contactend
                           //Oppo 
                           List<ContentDocumentLink> conOppo=[SELECT Id, LinkedEntityId, ContentDocumentId FROM 
                                                               ContentDocumentLink Where LinkedEntityId=:form.DAM01__Opportunity__c]; 
                            System.debug('conACC============'+conOppo);
                            for(ContentDocumentLink cdl1:conOppo){
                                
                                
                                
                                List<ContentDocument> cdfrm=[SELECT Id, Title, FileExtension FROM ContentDocument 
                                                             WHERE id=:cdl1.ContentDocumentId AND Title LIKE 'ROK Financial%'  ];
                                if(cdfrm.Size()>0){
                                    for(ContentDocument cd1:cdfrm){
                                        System.debug('cdAcc====='+cdfrm);
                                        if(cdfrm!=null){
                                            ContentDocument cd =new ContentDocument();
                                            cd.Id=cd1.Id;
                                            cd.Title=fileName;
                                            attListToUpdate.add(cd);
                                            
                                        }
                                    }
                                }
                            }
                            
                            //Oppo End
                        }
                    }
                }
                //Form end
               
                
                
            }
            if(attListToUpdate.size()>0){
                Update attListToUpdate;
            }
        }
    }
}