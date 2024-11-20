/**
 * @description       : DEPRECATED************** Handled in Flow Immunefi: Update Account When Opp Closed
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-12-2023
 * @last modified by  : julian.yong
**/
public with sharing class IMM_TA_Opportunity_CloseLostTriageOpp implements TriggerAction.AfterUpdate{
    public static void afterUpdate(List<Opportunity> newList, List<Opportunity> oldList){
        //setManagedTriageToClosedLost(newList, oldList);
    }

    // private static void setManagedTriageToClosedLost(List<Opportunity> newList, List<Opportunity> oldList){
    //     Map<Id, Opportunity> newMap = new Map<Id, Opportunity>(newList);
    //     Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>(oldList);
    //     Set<Id> accIds = new Set<Id>();

    //     for (Opportunity opp : newList) {

    //         if (oldMap.get(opp.Id).StageName == opp.StageName || oldMap.get(opp.Id).StageName != IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON) {
    //             continue;
    //         }
    //         accIds.add(opp.AccountId);
    //     }

    //     if (accIds.isEmpty()) {
    //         return;
    //     }
    //     //get all closed won opps, including managed triage
    //     List<Opportunity> closedWonOpps = getAllClosedWonOpportunities(new List<Id>(accIds));

    //     //convert all opportunities above to a map of accountIds with a list of opportunities
    //     Map<Id, List<Opportunity>> accIdToListOfOpps = getaccIdToListOfOpps(closedWonOpps);

    //     //Select all accounts Ids which have a manage triage opportunity
    //     List<Id> accWithManagedTriage = getAllAccountsWithManageTriageOpportunity(closedWonOpps);

    //     Map<Id, List<Opportunity>> accIdToListOfOppsWithManagedTriage = new Map<Id, List<Opportunity>>();
    //     List<Opportunity> oppsToUpdate = new List<Opportunity>();

    //     //remove all accounts without a managed triage opportunity
    //     for (Id accId : accIdToListOfOpps.keySet()) {
    //         if (accWithManagedTriage.contains(accId)) {
    //             accIdToListOfOppsWithManagedTriage.put(accId, accIdToListOfOpps.get(accId));
    //         }
    //     }

    //     //process the remaining
    //     for (Id accId : accIdToListOfOppsWithManagedTriage.keySet()) {
    //         //refresh map for every account in the map
    //         Map<String, List<Opportunity>>  groupedMap = new Map<String, List<Opportunity>>();

    //         //split the list opportunities into managed triage list and the others
    //         groupedMap = groupOpps(accIdToListOfOppsWithManagedTriage.get(accId));
    //         //if there are no closed won opportunities (BBP/Renewals) we set the managed triage opportunities to closed lost
    //         if (groupedMap.get('OTHERS').isEmpty()) {
    //             for (Opportunity managedTriageOpportunity : groupedMap.get('MANAGEDTRIAGE')) {
    //                 managedTriageOpportunity.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
    //                 managedTriageOpportunity.Loss_Reason__c = IMM_Util_Constants.LOSSREASON_OPP_CLOSUREOFBBP;
    //                 oppsToUpdate.add(managedTriageOpportunity);
    //             }
    //         }
    //     }
    //     if (Test.isRunningTest()) {
    //         testResults = oppsToUpdate;
    //         return;
    //     }

    //     if (!oppsToUpdate.isEmpty()) {
    //         update oppsToUpdate;
    //     }


    // }

    

    // private static List<Opportunity> getAllClosedWonOpportunities(List<Id> accIds){
    //     List<Opportunity> opps = new List<Opportunity>();
    //     if (!accIds.isEmpty()) {
    //         //only select closed won opportunities
    //         opps = [SELECT Id, Name, StageName, RecordTypeId, AccountId
    //                 FROM Opportunity 
    //                 WHERE   AccountId = :accIds AND 
    //                         StageName = :IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON];
        
    //     }

    //     if (Test.isRunningTest()) {
    //         opps = testOpportunities;
    //     }

    //     if (opps.isEmpty()) {
    //         return opps;
    //     }

    //     return opps;
    // }

    // private static Map<Id, List<Opportunity>> getaccIdToListOfOpps(List<Opportunity> opps){
    //     Map<Id, List<Opportunity>> accIdToListOfOpps = new Map<Id, List<Opportunity>>();
    //     for (Opportunity opp : opps) {
    //         if (!accIdToListOfOpps.containsKey(opp.AccountId)) {
    //             accIdToListOfOpps.put(opp.AccountId, new List<Opportunity>());
    //         }
    //         accIdToListOfOpps.get(opp.AccountId).add(opp);
    //     }
    //     return accIdToListOfOpps;
    // }

    // private static List<Id> getAllAccountsWithManageTriageOpportunity(List<Opportunity> opps){
    //     Set<Id> returnAccWithManagedTriage = new Set<Id>();
    //     for (Opportunity opp : opps) {
    //         if (opp.RecordTypeId == IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID) {
    //             returnAccWithManagedTriage.add(opp.AccountId);
    //         }
    //     }

    //     return new List<Id>(returnAccWithManagedTriage);
    // }

    // private static Map<String, List<Opportunity>> groupOpps(List<Opportunity> opps){
    //     List<Opportunity> managedTriageOpps = new List<Opportunity>();
    //     List<Opportunity> nonManagedTriageOpps = new List<Opportunity>();
    //     for (Opportunity opp : opps) {
    //         if (opp.RecordTypeId == IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID) {
    //             managedTriageOpps.add(opp);
    //             continue;
    //         }

    //         nonManagedTriageOpps.add(opp);
    //     }

    //     Map<String, List<Opportunity>> bundleMap = new Map<String, List<Opportunity>>{'MANAGEDTRIAGE' => managedTriageOpps, 'OTHERS' => nonManagedTriageOpps};

    //     return bundleMap;
    // }
       
    
    // @TestVisible
    // private static List<Opportunity> testOpportunities;
    // @TestVisible
    // private static List<Opportunity> testResults = new List<Opportunity>();

}