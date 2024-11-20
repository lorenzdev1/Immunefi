({
    handleClick : function (cmp, event, helper) {
        var name = event.getParam('Name');
        var city = event.getParam('City');
        cmp.set("v.name", name);
        cmp.set("v.city", city);
         
        /*var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "mode" : 'sticky',
            "title" : "Success",
            "message" : 'call from LWC component',
            "type" : "success"
        });
        toastEvent.fire();*/
        
        $A.get('e.force:refreshView').fire();
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }
})