/**
 * @description       : DEPRECATED**************
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-09-2023
 * @last modified by  : julian.yong
**/
public with sharing class IMM_TA_Opportunity_ValidateTriage implements TriggerAction.BeforeInsert{
    public static void beforeInsert(List<Opportunity> newList) {
        //validateAccountHasClosedWonOpps(newList);
    }

    // private static void validateAccountHasClosedWonOpps(List<Opportunity> newList){
    //     List<Id> accIds = new List<Id>();
    //     for (Opportunity opp : newList) {
    //         if (opp.RecordTypeId == IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID) {
    //             accIds.add(opp.AccountId);
    //         }
    //     }

    //     if (accIds.isEmpty()) {
    //         return;
    //     }

    //     List<Opportunity> closedWonOpps = new List<Opportunity>();
    //     List<Id> validRecordTypeIds = new List<Id>{IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID};
    //     if (!accIds.isEmpty()) {
    //         closedWonOpps = [SELECT Id, Name, RecordType.DeveloperName, RecordTypeId, StageName, AccountId, Account.Name FROM Opportunity WHERE AccountId IN :accIds AND StageName = :IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON AND RecordTypeId IN :validRecordTypeIds];
    //     }

    //     if (Test.isRunningTest()) {
    //         closedWonOpps = testOpportunities;
    //     }

    //     Map<Id, List<Opportunity>> accIdToClosedWonOpp = new Map<Id, List<Opportunity>>();
    //     if (!closedWonOpps.isEmpty()) {
    //         for (Opportunity opp : closedWonOpps) {
    //             if (!accIdToClosedWonOpp.containsKey(opp.AccountId)) {
    //                 accIdToClosedWonOpp.put(opp.AccountId, new List<Opportunity>());
    //             }
    //             accIdToClosedWonOpp.get(opp.AccountId).add(opp);
    //         }
    //     }

    //     for (Opportunity opp : newList) {
    //         if (!accIdToClosedWonOpp.containsKey(opp.AccountId) || 
    //             accIdToClosedWonOpp.get(opp.AccountId).isEmpty() || 
    //             accIdToClosedWonOpp.get(opp.AccountId) == null) {
    //             opp.addError(IMM_Util_Constants.ERR05_ACCOUNTDOESNOTHAVECLOSEDWONOPP);
    //         }
            
    //     }

    //     if (Test.isRunningTest()) {
    //         testResults = newList;
    //         return;
    //     }
       
    // }

    // @TestVisible
    // private static List<Opportunity> testOpportunities;
    // @TestVisible
    // private static List<Opportunity> testResults = new List<Opportunity>();
}