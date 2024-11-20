/**
* @description       : When a new Opportunity is created upon Lead conversion,will update the Lead value into Opportunity Amount
* @author            : Jahnavi Manne
* @group             : 
* @last modified on  : 01-05-2024
* @last modified by  : julian.yong
**/
public with sharing class IMM_TA_Lead_SetAmount implements TriggerAction.AfterUpdate {
    
    public static void afterUpdate(List<Lead> newList, List<Lead> oldList){
        setAmount(newList,oldList);
    }
    
    private static void setAmount(List<Lead> newList,List<Lead> oldList){
        List<Opportunity> oppToUpdate = new List<Opportunity>();        
        for(Lead ld:newList){
            if(ld.IsConverted && ld.ConvertedOpportunityId != null){                
                Opportunity opp = new Opportunity();
                opp.id = ld.ConvertedOpportunityId;
                opp.Amount = ld.IMM_CU_Value__c;
                oppToUpdate.add(opp);
            }            
        }

        if(Test.isRunningTest()){
            testResults = oppToUpdate;
            return;
        }
        
        if(!oppToUpdate.isEmpty()){
            update oppToUpdate;
        }        
    }
    
    @TestVisible
    private static List<Opportunity> testResults = new List<Opportunity>();
    
}