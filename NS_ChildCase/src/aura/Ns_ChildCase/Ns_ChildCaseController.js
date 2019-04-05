({
    init : function (component) {
         //alert('in init');
     
         /* // Create action to find an case
        var action = component.get("c.getCase");
        action.setParams({
            "caseId" : component.get("v.recordId"),
            
        });
        
        
        
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();       
            //alert("Test!"+state);  
            if (state === "SUCCESS" ) {                         
                
                // Pass the case data into the component's case attribute 
                //component.set("v.Case", response.getReturnValue());
                //alert( "Accountid"+ response.getReturnValue());
                //list<case> caselist=response.getReturnValue();
                var casedetails = response.getReturnValue();
                
                
               var accid= casedetails[0];
                var conid= casedetails[1];
                var casesubject= casedetails[2];
             
               // Find the component whose aura:id is "flowData"
                var flow = component.find("flowData");     
                          
                 
                var inputVariables = [
                    {
                        name : "ParentId",
                        type : "String",
                        value: component.get("v.recordId")
                    },
                     {
                        name : "AccountofCase",
                        type : "String",
                        value: accid
                    },
                     {
                        name : "ContactOfCase",
                        type : "String",
                        value: conid
                    },                   
                    {
                        name : "Casesubject",
                        type : "String",
                        value: casesubject
                    }
                       
                ];
                
                // In the component whose aura:id is "flowData, start your flow
                // and initialize the account sObject variable. Reference the flow's
                // Unique Name.
                flow.startFlow("Test_Child",inputVariables);
                }
                           
                                   
            else {
                console.log("Failed to get Case data.");
                alert("hello here!"+state); 
            }
            // $A.get('e.force:refreshView').fire();
        });       

        
        // Send action to be executed
        $A.enqueueAction(action);
    
           
      */  
 
        var controllerMethod = component.get("c.getChildcase");
        controllerMethod.setParams({ "caseId" : component.get("v.recordId")});
        // Configure response handler        
        controllerMethod.setCallback(this, function(response) {
            var state = response.getState();
            var respText = response.getReturnValue();
            var r = JSON.stringify(respText);
            var casedetails = JSON.parse(r);
            //alert('State:'+state);
            if (state === "SUCCESS") {
                
                // component.set("v.account", respText);
                //console.log("Account Name Retrieved",respText);
                /*var r = JSON.stringify(respText);
                var casedetails = JSON.parse(r);*/
                // alert("Message:"+ casedetails.Message) ;
                var massagecase=casedetails.Message;
                if(casedetails.Message === true){
                    
                    //alert(casedetails.AccountId);
                    var accid= casedetails.AccountId;
                    var conid= casedetails.ContactId;
                    var casesubject= casedetails.Subject;
                    
                    
                    var flow = component.find("flowData");     
                    
                    
                    var inputVariables = [
                        {
                            name : "ParentId",
                            type : "String",
                            value: component.get("v.recordId")
                        },
                     /*   {
                            name : "AccountofCase",
                            type : "String",
                            value: accid
                        },
                        {
                            name : "ContactOfCase",
                            type : "String",
                            value: conid
                        }, */                  
                        {
                            name : "Casesubject",
                            type : "String",
                            value: casesubject
                        }
                        
                    ];
                    
                    // In the component whose aura:id is "flowData, start your flow
                    // and initialize the account sObject variable. Reference the flow's
                    // Unique Name.
                    flow.startFlow("Test_Child",inputVariables);
                    
                }
                
                else
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Not Authorized!!!",
                        "message": "This case is Closed, You cannot raise any request for this!!!"
                    });
                    toastEvent.fire();
                   // alert('This is a request,you cannot raise any request for this.!!!');
                }
            }         
            else if (state === "INCOMPLETE") {
                      // console.log("Incomplete");
            }
                else if (state === "ERROR") {
                     //console.log("Error");
                }
                    else {
                     //   console.log("Unknown error");
                    }
        });
        $A.enqueueAction(controllerMethod);
    }
})