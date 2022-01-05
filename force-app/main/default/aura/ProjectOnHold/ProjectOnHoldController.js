({
    doInit  : function(component, event, helper) {
        
        component.set('v.columns', [    
           {label: 'Name', fieldName: 'ActiontUrl', type: 'url',  typeAttributes:{
                        label: {
                            fieldName: 'Name'
                        }
                    }},
            {label: 'Budgeted Hours', fieldName: 'DAM01__Budgeted_Hours__c', type: 'Text',sortable: true},
            {label: 'Remaining Hours', fieldName: 'DAM01__Remaining_Hours__c', type: 'Text', sortable: true} ,
            {label: 'Status', fieldName: 'DAM01__Status__c', type: 'Text', sortable: true} ,
             {label: 'Action Owner', fieldName: 'devUrl', type: 'url',  typeAttributes:{
                        label: {
                            fieldName: 'DAM01__Action_Owner__c'
                        }
                    }},
        ]); 
        
        
        helper.getData(component);
        
    },
     createAction : function(component, event, helper) {
        var createRecord =$A.get('e.force:createRecord');
        createRecord.setParams({
            "entityApiName" : "DAM01__Action__c",
            "defaultFieldValues":{
            'DAM01__Project__c':component.get('v.recordId'),
            'DAM01__Status__c':'On Hold'
            }
                
            
        });
		createRecord.fire(); 
	}    
});