({
    doInit : function(component) {
         var recordId = component.get("v.recordId");
        var action=component.get("c.getOppProduct");
         action.setParams({
            "recordId": recordId
           
        });
        action.setCallback(this,function(e){
            if(e.getState()=='SUCCESS'){
                var result=e.getReturnValue();                
                if(result.length>0){
                    component.set("v.productList",result);
                }
            }
        });
        $A.enqueueAction(action);
    },
    calDiscount : function(component, event, helper) {
        var productList = component.get("v.productList");
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
        alert(index)
        var qnt = productList[index].Quantity;
        
        console.log('productList'+JSON.stringify(productList));
        var unitprice = productList[index].UnitPrice;
        var Discount =productList[index].Discount;
        //alert(Discount)
        var TotalPrice = productList[index].TotalPrice;
        var original_price= unitprice*qnt;
        var discounted_price = original_price - (original_price * Discount / 100)
        // var total=(unitprice*qnt)-((unitprice*Discount));
        
        console.log(JSON.stringify(productList[index]));
        productList[index].TotalPrice = discounted_price;
        component.set("v.productList", productList);
        
        
    },
    
    addRow: function(component, event, helper) {
        //get the account List from component  
        
        var productList = component.get("v.productList");
        //console.log(JSON.stringify(productList));
       
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
        var addRowData = productList[index];
        
        var action = component.get("c.cloneRow");
        action.setParams({
            "draftvalues": productList,
            "index" : index
        });
        action.setCallback(this, function(response) {
            //get response status 
            var state = response.getState();
            alert(state)
            var result=response.getReturnValue();  
            if (state === "SUCCESS") {
                //set empty account list
                component.set("v.productList", result);
                alert('Accounts saved successfully');
            }
        }); 
        $A.enqueueAction(action);
        
    },
    
    removeRecord: function(component, event, helper) {
        //Get the account list
        var productList = component.get("v.productList");
        //Get the target object
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
       // alert(index)
        var action = component.get("c.delRow");
         alert(index)
        action.setParams({
            "draftvalues": productList,
            "index" : index
        });
        action.setCallback(this, function(response) {
            //get response status 
            var state = response.getState();
            alert(state)
            var result=response.getReturnValue();  
            if (state === "SUCCESS") {
                //set empty account list
                component.set("v.productList", result);
                alert('Accounts saved successfully');
            }
        }); 
        $A.enqueueAction(action);
        
    },
    
    saveAccounts: function(component, event, helper) {      
        if (helper.validateAccountRecords(component, event)) {
            //Call Apex method and pass account list as a parameters
            var action = component.get("c.saveAccountList");
            action.setParams({
                "draftvalues": component.get("v.productList"),
                 "recordId": component.get("v.recordId")
            });
            action.setCallback(this, function(response) {
                //get response status 
                var result=response.getReturnValue();  
                var state = response.getState();
                if (state === "SUCCESS") {
                    //set empty account list
                    component.set("v.productList", result);
                    alert('Accounts saved successfully');
                }
            }); 
            $A.enqueueAction(action);
        }
    },
})