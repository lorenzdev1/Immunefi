/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 12-21-2023
 * @last modified by  : julian.yong
**/
public with sharing class IMM_OpportunityTriggerHandler {

   public static Map<Id, List<String>> validateContactRoles(List<Id> oppIds){
        Map<Id, List<OpportunityContactRole>> oppIdToOppContactRoles = getOpportunitiesContactRoles(oppIds);
        Map<Id, List<String>> returnMap = new Map<Id, List<String>>();
        Set<String> missingConRoles;

        for (Id oppId : oppIdToOppContactRoles.keySet()) {
            missingConRoles = new Set<String>();
            missingConRoles = validateContactRole(oppIdToOppContactRoles.get(oppId));
            if (missingConRoles.isEmpty()) {
                continue;
            }
            returnMap.put(oppId, new List<String>(missingConRoles));
        }

        return returnMap; //return list of IDs that has missing contact roles along with a list of contact roles that are not available

   }

   private static Set<String> validateContactRole(List<OpportunityContactRole> oppContactRoles) {
        
        Set<String> expectedContactRoles = IMM_Utility.getValidateOppConRoles();
        if (Test.isRunningTest() && injectTestData) {
            expectedContactRoles = testExpectedContactRoles;
        }
        Set<String> existingContactRoles = new Set<String>();
        for (OpportunityContactRole oppConRole : oppContactRoles) {
           existingContactRoles.add(oppConRole.Role);
        }
        expectedContactRoles.removeAll(existingContactRoles);
        return expectedContactRoles;
   }

   private static Map<Id, List<OpportunityContactRole>> getOpportunitiesContactRoles(List<Id> oppIds){
       
        Map<Id, List<OpportunityContactRole>> returnMap = new Map<Id, List<OpportunityContactRole>>();
        if (oppIds.isEmpty()) {
            return returnMap;
        }

        Set<String> expectedContactRoles = IMM_Utility.getValidateOppConRoles();
        if (Test.isRunningTest() && injectTestData) {
            expectedContactRoles = testExpectedContactRoles;
        }
        List<OpportunityContactRole> contactRoles = [   SELECT 
                                                            ContactId, 
                                                            OpportunityId, 
                                                            Role
                                                        FROM
                                                            OpportunityContactRole
                                                        WHERE
                                                            OpportunityId IN :oppIds AND
                                                            ContactId != null AND 
                                                            Role IN :expectedContactRoles
                                                    ];

        if (Test.isRunningTest() && injectTestData) {
            contactRoles = testOppContactRoles;
        }

        for (Id oppId : oppIds) {
            returnMap.put(
                oppId,
                new List<OpportunityContactRole>()
            );
        }

        for (OpportunityContactRole oppConRole : contactRoles) {
              returnMap.get(oppConRole.OpportunityId).add(oppConRole);
        }

        


        return returnMap;
   }

   @TestVisible
   private static List<OpportunityContactRole> testOppContactRoles;
   @TestVisible
   private static Set<String> testExpectedContactRoles = new Set<String>();
   @TestVisible
   private static List<Opportunity> testResults = new List<Opportunity>();
   @TestVisible
   private static boolean injectTestData = false;
   
}