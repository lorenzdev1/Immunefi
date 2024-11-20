/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 01-09-2024
 *                      04-03-2024 - Added assigned permission set check to running user
 * @last modified by  : julian.yong
**/
public with sharing class IMM_TA_Opportunity_ValidateContactRole implements TriggerAction.BeforeUpdate {
    public static void beforeUpdate(List<Opportunity> newList, List<Opportunity> oldList){
        
        Integer byPassValidation = [SELECT COUNT() FROM PermissionSetAssignment 
                                    WHERE AssigneeId =: UserInfo.getUserId()
                                    AND PermissionSet.Name = 'IMM_PS_ExcludeFromValidation'];

        if(byPassValidation == 0) {                            
            validateContactRoles(newList);
        }
    }

    public static void validateContactRoles(List<Opportunity> newList){
        List<Id> oppsToVerify = new List<Id>();
        for (Opportunity opp : newList) {
            if (opp.StageName == IMM_Util_Constants.OPP_STAGENAME_ONBOARDING && 
                opp.RecordTypeId == IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID) {
                oppsToVerify.add(opp.Id);
            }
        }

        Map<Id, List<String>> invalidOpps = IMM_OpportunityTriggerHandler.validateContactRoles(oppsToVerify);
        if (Test.isRunningTest() && injectTestData) {
            invalidOpps = testOppIdToListOfContactRolesMissing;
        }
        for (Opportunity opp: newList) {
            if (invalidOpps.containsKey(opp.Id)) {
                opp.addError(System.Label.IMM_LB_ContactRoles + ' ' + String.join(invalidOpps.get(opp.Id), ', '));
            }
        }
        if (Test.isRunningTest()) {
            testResults = newList;
        }
    }

    @TestVisible
    private static Map<Id, List<String>> testOppIdToListOfContactRolesMissing;
    @TestVisible
    private static List<Opportunity> testResults = new List<Opportunity>();
    @TestVisible
    private static boolean injectTestData = false;
}