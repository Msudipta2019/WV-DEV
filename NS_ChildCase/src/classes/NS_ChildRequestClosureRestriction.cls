/*
Description  : This class is to restrict user for closing the parent case if internal request is open.
Developer    : Accenture Solutions
Date         : 12-03-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Sudipta Mukherjee    12-03-2018     Added Method to add error.
*/


public without sharing class NS_ChildRequestClosureRestriction {
    
    

    public static void closeCaseAlert(list<case> newcase){
        try{
        list<case> countCase= new list<case>();
       
        for(case caseNew: newcase)
            {
        for(case caseRequest:[select id from case where parentid=:casenew.id and status!=: NS_StaticVariablesUtility.NS_CLOSED and
                      RecordType.Name=:NS_StaticVariablesUtility.ChildCase Limit 100])
        {
            
          countcase.add(caseRequest);
            
        }
                  if( casenew.status == NS_StaticVariablesUtility.NS_CLOSED && countcase.size()>0 )
        {
            casenew.addError('All Internal Requests associated to this case must be closed in order to close this case.');
        }
                
            }
        }
        
        catch(exception exp)
        {
            NS_StaticVariablesUtility.createExceptionRecord(exp, 'NS_ChildRequestClosureRestriction', 'closeCaseAlert');
            
        }
         
    }
    
    
}