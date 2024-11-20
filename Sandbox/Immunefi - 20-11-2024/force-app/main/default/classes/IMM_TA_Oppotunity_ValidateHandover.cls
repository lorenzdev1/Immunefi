/**
 * @description       : DEPRECATED**************
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-06-2023
 * @last modified by  : julian.yong
**/
public with sharing class IMM_TA_Oppotunity_ValidateHandover implements TriggerAction.BeforeUpdate {
    public static void beforeUpdate(
    List<Opportunity> newList,
    List<Opportunity> oldList
  ) {
    // validateHandover(newList, oldList);
  }

  // private static void validateHandover(List<Opportunity> newList, List<Opportunity> oldList) {
  //   Map<Id, Opportunity> newMap = new Map<Id, Opportunity>(newList);
  //   Map<Id, Opportunity> oldMap = new Map<Id, Opportunity>(oldList);
  //   Set<Id> oppIds = new Set<Id>();

  //   for (Opportunity opp : newList) {
  //     if (opp.RecordTypeId == IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID && oldMap.get(opp.Id).StageName != opp.StageName && oldMap.get(opp.Id).StageName == IMM_Util_Constants.OPP_STAGENAME_INREVIEW  
  //      && opp.StageName == IMM_Util_Constants.OPP_STAGENAME_HANDOVER) {
  //       oppIds.add(opp.Id);
  //     }
  //   }

  //   if (oppIds.isEmpty()) {
  //     return;
  //   }

  //   Map<Id, List<IMM_CO_ReviewProcess__c>> oppIdToReviewProcessesMap = getAllReviews(
  //     oppIds
  //   );

  //   for (Opportunity opp : newList) {
  //     // Guard Clauses---------
  //       if (!oppIdToReviewProcessesMap.containsKey(opp.Id)) {
  //         opp.addError(IMM_Util_Constants.ERR02_REVIEWSNOTAPPROVED);
  //         if (Test.isRunningTest()) {
  //           testResults.add(opp);
  //         }
  //         continue;
  //       }

  //       if (oppIdToReviewProcessesMap.get(opp.Id).size() < 2) {
  //         opp.addError(IMM_Util_Constants.ERR02_REVIEWSNOTAPPROVED);
  //         if (Test.isRunningTest()) {
  //           testResults.add(opp);
  //         }
  //         continue;
  //       }

  //     //----------------------
  //     for (IMM_CO_ReviewProcess__c review : oppIdToReviewProcessesMap.get(opp.Id)) {
  //       // Guard Clauses---------
  //       if (review.RecordTypeId == IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_TECHREVIEWID && review.IMM_PL_Status__c != IMM_Util_Constants.REVIEW_STAGENAME_APPROVEDFORLAUNCH) {
  //         opp.addError(IMM_Util_Constants.ERR02_REVIEWSNOTAPPROVED);
  //       }

  //       if (review.RecordTypeId == IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_LEGALREVIEWID && review.IMM_PL_Status__c != IMM_Util_Constants.REVIEW_STAGENAME_COMPLETE) {
  //         opp.addError(IMM_Util_Constants.ERR02_REVIEWSNOTAPPROVED);
  //       }
       
  //     }

  //     if (Test.isRunningTest()) {
  //       testResults.add(opp);
  //     }

  //   }

  // }

  // private static Map<Id, List<IMM_CO_ReviewProcess__c>> getAllReviews(Set<Id> oppIds) {
  //   Map<Id, List<IMM_CO_ReviewProcess__c>> returnMap = new Map<Id, List<IMM_CO_ReviewProcess__c>>();

  //   if (oppIds.isEmpty()) {
  //     return returnMap;
  //   }

  //   List<Id> oppIdList = new List<Id>(oppIds);
  //   Map<Id, IMM_CO_ReviewProcess__c> OppIdToTechnicalReviewMap = mapReviews([
  //     SELECT
  //       Id,
  //       IMM_PL_Status__c, 
  //       IMM_MD_OpportunityNumber__c,
  //       RecordType.DeveloperName
  //     FROM IMM_CO_ReviewProcess__c
  //     WHERE
  //     IMM_MD_OpportunityNumber__c IN :oppIdList 
  //     AND RecordType.DeveloperName = :IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_TECHREVIEW
  //   ]);

  //   Map<Id, IMM_CO_ReviewProcess__c> OppIdToLegalReviewMap = mapReviews([
  //       SELECT
  //         Id,
  //         IMM_PL_Status__c, 
  //         IMM_MD_OpportunityNumber__c,
  //         RecordType.DeveloperName
  //       FROM IMM_CO_ReviewProcess__c
  //       WHERE
  //       IMM_MD_OpportunityNumber__c IN :oppIdList 
  //       AND RecordType.DeveloperName = :IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_LEGALREVIEW
  //     ]);

  //   if (Test.isRunningTest()) {
  //       OppIdToTechnicalReviewMap = mapReviews(technicalReviewTest);
  //       OppIdToLegalReviewMap = mapReviews(legalReviewTest);
  //   }
  //   if (OppIdToTechnicalReviewMap.isEmpty() && OppIdToLegalReviewMap.isEmpty()) {
  //       return returnMap;
  //   }
  //   for (Id oppId : oppIdList) {
  //     if (!returnMap.containsKey(oppId)) {
  //       returnMap.put(oppId, new List<IMM_CO_ReviewProcess__c>());
  //     }
  //     if (OppIdToTechnicalReviewMap.containsKey(oppId)) {
  //        returnMap.get(oppId).add(OppIdToTechnicalReviewMap.get(oppId));
  //     }
  //     if (OppIdToLegalReviewMap.containsKey(oppId)) {
  //       returnMap.get(oppId).add(OppIdToLegalReviewMap.get(oppId));
  //    }
     
  //   }
    
  //   return returnMap;
  // }

  // private static Map<Id, IMM_CO_ReviewProcess__c> mapReviews(List<IMM_CO_ReviewProcess__c> reviewProcesses){
  //   if (reviewProcesses.isEmpty()) {
  //       return new Map<Id, IMM_CO_ReviewProcess__c>();
  //   }

  //   Map<Id, IMM_CO_ReviewProcess__c> oppIdToReviewProcessMap = new Map<Id, IMM_CO_ReviewProcess__c>();

  //   for (IMM_CO_ReviewProcess__c reviewProcess : reviewProcesses) {
  //       if (!oppIdToReviewProcessMap.containsKey(reviewProcess.IMM_MD_OpportunityNumber__c)) {
  //           oppIdToReviewProcessMap.put(reviewProcess.IMM_MD_OpportunityNumber__c, reviewProcess);
  //       }
  //   }
    
  //   return oppIdToReviewProcessMap;


  // }

  // @TestVisible
  // private static List<IMM_CO_ReviewProcess__c> technicalReviewTest;
  // @TestVisible
  // private static List<IMM_CO_ReviewProcess__c> legalReviewTest;
  // @TestVisible
  // private static List<Opportunity> testResults = new List<Opportunity>();
    
}