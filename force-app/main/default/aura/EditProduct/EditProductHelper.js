({
    validateAccountRecords: function(component, event) {
        //Validate all account records
        var isValid = true;
        var productList = component.get("v.productList");
        for (var i = 0; i < productList.length; i++) {
            if (productList[i].Name == '') {
                isValid = false;
                alert('Account Name cannot be blank on '+(i + 1)+' row number');
            }
        }
        return isValid;
    },
})