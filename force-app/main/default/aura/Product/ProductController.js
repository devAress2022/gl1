({
    doInit : function(component, event, helper) {
        helper.getAccounts(component);
        
        var actions = [
            { label: 'Network', name: 'show_details' },
            { label: 'Hardware', name: 'delete' },
            { label: 'Software', name: 'delete1' }
        ];
    },              
    getSelectedAccount : function(component, event,helper) { 
        
        var selectedId='';
        //when using <ui:inputCheckbox> instead html checkbox
        //selectedId=event.getSource().get("v.text");                
        selectedId = event.target.getAttribute('id');
        if(document.getElementById(selectedId).checked && component.get("v.SelectedAccount").indexOf(selectedId) < 0)
            component.get('v.SelectedAccount').push(selectedId);
        else{
            var index = component.get("v.SelectedAccount").indexOf(selectedId);
            if (index > -1) {
                component.get("v.SelectedAccount").splice(index, 1); 
            }
        }
    },
    
    openModel:function(component,event,helper){
        
        var selectedAccount=component.get("v.SelectedAccount");
        if(selectedAccount.length>0){
            helper.deleteAcc(component,selectedAccount);
            alert('vk')
        }
        else{
            alert('Please select product to add')
        }
        component.set("v.isModalOpen", true);
    },
    
    
    init: function (cmp, event, helper) {
        var actions = [
            { label: 'Network', name: 'show_details' },
            { label: 'Hardware', name: 'delete' },
            { label: 'Software', name: 'delete1' }
        ];
        cmp.set('v.columns', [
            {label: 'Product name', fieldName: 'Name', type: 'text'},
            {label: 'Quantity name', fieldName: 'SBQQ__DefaultQuantity__c', type: 'Number',editable:'true'},
            {label: 'Product Family', fieldName: 'Types__c', type: 'picklist',editable:'true'},
            {
                label: 'Rating', fieldName: 'Rating', type: 'picklist', typeAttributes: {
                    placeholder: 'Choose rating', options: [
                        { label: 'A', value: 'A' },
                        { label: 'B', value: 'B' },
                        { label: 'C', value: 'C' },
                    ] // list of all picklist options
                    , value: { fieldName: 'TYPE__c' } // default value for picklist
                    , context: { fieldName: 'Id' } // binding account Id with context variable to be returned back
                },editable:'true'
            }
        ])  
        
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        var temp = event.getParam('action');
        alert(temp+'picklist');
        alert(temp+'temp');
        console.log(JSON.stringify(temp));
        alert(JSON.stringify(temp));
         cmp.set("v.temp",temp);
        helper.updatedata(cmp,temp);

        
        /*  switch (action.name) {
            case 'Hardware':
                 alert('Showing Details: ' + JSON.stringify(row));
                break;
            case 'Software':
                 alert('Showing Details: ' + JSON.stringify(row));
                break;
            case 'Network':
                helper.Network(cmp, row);
        }*/
    },
    handleSelectedRow: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        alert('from handle seleted'+selectedRows);
        cmp.set("v.selectedRows",selectedRows);     
    },
    
    newmethodjs : function(cmp,event,helper)
    {
        var draftValues = event.getParam('draftValues');
        var selectedIds =cmp.get('v.selectedRows');
        var temp = event.getParam('SelectedAccountList');
        alert(temp+'temp');
        console.log(JSON.stringify(temp));
        alert(JSON.stringify(temp));
        //cmp.set("v.selectedRows",selected); 
        //var selectedIds = cmp.get('v.selectedRows');
        alert('selectedCount'+draftValues);
        helper.updatedata(cmp,draftValues);
    },
    
    closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
    
    submitDetails: function(component, event, helper) {
        // Set isModalOpen attribute to false
        //Add your code to call apex method or do some processing
        component.set("v.isModalOpen", false);
    },
    newComponent : function(component) {
var newEvent = $A.get("e.force:navigateToComponent");
        newEvent.setParams({
            componentDef: "inlineEditTable",
            componentAttributes: {
                //Set you attributes here if required.
            }
        });
        newEvent.fire();
}
    
})