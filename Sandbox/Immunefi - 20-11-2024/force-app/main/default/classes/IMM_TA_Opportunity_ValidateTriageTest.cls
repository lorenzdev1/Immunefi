/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-09-2023
 * @last modified by  : julian.yong
**/
@IsTest
private class IMM_TA_Opportunity_ValidateTriageTest {
    @IsTest
    static void testbeforeInsertPositive() {
        // //should create Manage Triage
        // List<Opportunity> newList = new List<Opportunity>();
        // List<Opportunity> oldList = new List<Opportunity>();
        // Account acc = IMM_TestDataFactory.createAccount();
        // Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
        // opp.StageName = IMM_Util_Constants.OPP_STAGENAME_PROPOSAL;
        // opp.CloseDate = Date.today() + 7;
        // opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
        // newList.add(opp);
        // //Inject Test Data
        // IMM_TA_Opportunity_ValidateTriage.testOpportunities = new List<Opportunity>();
        // Opportunity oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
        // oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
        // oppInject.CloseDate = Date.today();
        // oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
        // IMM_TA_Opportunity_ValidateTriage.testOpportunities.add(oppInject);
        // callCUT(newList, oldList);
        // Assert.areEqual(1, IMM_TA_Opportunity_ValidateTriage.testResults.size(), 'testbeforeInsertPositive FAILED: should return object)');
        // List<Database.Error> oppErrors = IMM_TA_Opportunity_ValidateTriage.testResults[0].getErrors();
        // Assert.areEqual(0, oppErrors.size(), 'testbeforeInsertPositive FAILED: error found');
    }

//     @IsTest
//     static void testbeforeInsertNegative() {
//         //should create Manage Triage
//         List<Opportunity> newList = new List<Opportunity>();
//         List<Opportunity> oldList = new List<Opportunity>();
//         Account acc = IMM_TestDataFactory.createAccount();
//         Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
//         opp.StageName = IMM_Util_Constants.OPP_STAGENAME_PROPOSAL;
//         opp.CloseDate = Date.today() + 7;
//         opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
//         newList.add(opp);
//         //Inject Test Data
//         IMM_TA_Opportunity_ValidateTriage.testOpportunities = new List<Opportunity>();
//         callCUT(newList, oldList);
//         Assert.areEqual(1, IMM_TA_Opportunity_ValidateTriage.testResults.size(), 'testbeforeInsertPositive FAILED: should return object)');
//         List<Database.Error> oppErrors = IMM_TA_Opportunity_ValidateTriage.testResults[0].getErrors();
//         Assert.areEqual(1, oppErrors.size(), 'testbeforeInsertPositive FAILED: error found');
//     }

//     static void callCUT(List<Opportunity> newList, List<Opportunity> oldList){
//         Test.startTest();
//         IMM_TA_Opportunity_ValidateTriage.beforeInsert(newList);
//         Test.stopTest();
//    }
}