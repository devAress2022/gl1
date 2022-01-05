({
    getData : function(component, event, helper) {
        var action = component.get("c.getProjectAssigned");
        action.setParams({
            'recID' : component.get('v.recordId')
        });
        action.setCallback(this, function(response){            
            var state = response.getState();    
            if (state === "SUCCESS"){      
                var lstAction = response.getReturnValue();
                var lstdev= response.getReturnValue();
                lstAction.forEach(function(item){
                    item['ActiontUrl'] = '/lightning/r/DAM01__Action__c/' +item['Id'] +'/view';
                });
                lstdev.forEach(function(item){
                    item['devUrl'] = '/lightning/r/DAM01__Devloper__c/' +item['DAM01__Action_Owner__c'] +'/view';
                });
                component.set("v.data", response.getReturnValue()); 
            }
        }); 
        $A.enqueueAction(action);
    }
});