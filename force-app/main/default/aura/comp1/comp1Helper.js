({
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Account Name', fieldName: 'Name', type: 'text',sort:'true'},
                {label: 'Status', fieldName: 'DAM01__Status__c', type: 'text'},
                {label: 'Desc', fieldName: 'DAM01__Description__c', type: 'text'},
                {label: 'Active', fieldName: 'DAM01__Active__c ', type: 'text '}
            ]);
        var action = component.get('c.customer');
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            alert(state);
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})