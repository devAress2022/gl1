({
 getAccounts : function(component) {
  var action=component.get("c.GetProduct");
        action.setCallback(this,function(e){
            if(e.getState()=='SUCCESS'){
                var result=e.getReturnValue();                
                if(result.length>0){
                    component.set("v.AccountList",result);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    deleteAcc:function(component,selectedAccount){
        var action=component.get("c.delAccount");
        alert(action);
        action.setParams({
            lstAccountId:selectedAccount
        });
        action.setCallback(this,function(e){
            if(e.getState()=='SUCCESS'){
                var result=e.getReturnValue();                
                if(result.length>0){
                    component.set("v.SelectedAccountList",result);
                  //  alert(result);
                }
                else{
                    this.getAccounts(component);
                    alert('Product added successfully');                    
                }
            } 
             component.set("v.isModalOpen", true);
        });
        $A.enqueueAction(action);
    },
    updatedata : function (component,draftValues,temp){
        alert('updatedatahelper');
        
    var pklist =component.get('v.temp');
        console.log(JSON.stringify(pklist));
        alert(JSON.stringify(pklist));
    var action=component.get("c.updateProduct2");
        action.setParams({
            "temp": pklist,
            "draftvalues" : draftValues ,
            "recId" : component.get("v.recordId")
        });
        
        action.setCallback(this,function(e){
            alert(e.getState());
            alert(e.getError());
           alert(JSON.stringify(e.getError()));
            if(e.getState()=='SUCCESS'){
                var result=e.getReturnValue();                
                if(result.length>0){
                    component.set("v.AccountList",result);
                }
            }
            
        });
        $A.enqueueAction(action);
},
    
 })