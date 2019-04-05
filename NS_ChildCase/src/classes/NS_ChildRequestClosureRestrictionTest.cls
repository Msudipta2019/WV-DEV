/*
Description  : This is test class for NS_ChildRequestClosureRestriction.
Developer    : Accenture Solutions
Date         : 12-03-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Sudipta Mukherjee    12-03-2018     This is test class for NS_ChildRequestClosureRestriction..
*/
@isTest(SeeAllData=false)
public class NS_ChildRequestClosureRestrictionTest {
    
    public static testmethod void childCaseInsertUpdate()
    {
        Profile sysprof = UserTestFactory.createProfile(NS_StaticVariablesUtility.SystemAdministratorProfile);
        User admin = UserTestFactory.createUser(14,sysprof.Id);
        Case cs1 = new Case();
        Case cs2 = new Case();
        User atest;
        
         System.runAs( admin ){ 
            NS_TriggerSettings__c cs = new NS_TriggerSettings__c(Name= NS_StaticVariablesUtility.caseTrigger); 
            cs.NS_IsActive__c = true;
            database.insert(cs);
                 
            Profile agent = UserTestFactory.createProfile(NS_StaticVariablesUtility.UserRep);
            atest = UserTestFactory.createUser(21,agent.Id);
            UserTestFactory.assignUserQueue(atest);
            
        }
        system.test.StartTest();
        Account acc = AccountTestFactory.createAccountRecord(NS_StaticVariablesUtility.Name);
        AccountTestFactory.accountShare(acc.Id,atest.Id,NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,
                                        NS_StaticVariablesUtility.readAccess,NS_StaticVariablesUtility.rowCause);
        
        
        
        System.runAs(admin) {      
                       
            cs1 = CaseTestFactory.createCaseRecord('Local Service Inquiry','Local Service',acc.Id);    
            
            database.insert(cs1);  
            cs2 = CaseTestFactory.createChildCaseRecord('Local Service Inquiry','Local Service',acc.Id,cs1.id);    
            
            database.insert(cs2); 
            Ns_ChildCaseController.getChildcase(cs2.id);
            Ns_ChildCaseController.getChildcase(cs1.id);
            try{
            cs1.status=NS_StaticVariablesUtility.NS_CLOSED;
            
            database.update(cs1);
              
            }
            catch(Exception e)
            {
               String message = e.getMessage();
                
               system.assert(message.contains('All Internal Requests associated to this case must be closed in order to close this case.'), 'message=' + message); 
                
            }
        }   
        
    }
    

}