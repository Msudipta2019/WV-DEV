/*
Description  : This class is created to refer the wrapper class in Childcase controller.
Developer    : Accenture Solutions
Date         : 12-03-2018

-----------------------------------------------------------------------
Developer name        Date          Description        
-----------------------------------------------------------------------
@Sudipta Mukherjee    12-03-2018     Added Method to refer in Child case controller.
*/

public without sharing class ChildCaseWrapper  { 
     @AuraEnabled
   public Id AccountId {get;set;}
     @AuraEnabled
   public Id ContactId {get;set;}
     @AuraEnabled
   public String Subject {get;set;}
     @AuraEnabled
   public Id ParentId {get;set;}
     @AuraEnabled
   public Boolean Message {get;set;}
}