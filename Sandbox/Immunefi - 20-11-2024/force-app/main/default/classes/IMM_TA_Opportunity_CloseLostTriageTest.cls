/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-12-2023
 * @last modified by  : julian.yong
**/
@IsTest
private class IMM_TA_Opportunity_CloseLostTriageTest {
    @IsTest
    static void testAfterUpdatePositive() {
        // List<Opportunity> newList = new List<Opportunity>();
        // List<Opportunity> oldList = new List<Opportunity>();
        // Account acc = IMM_TestDataFactory.createAccount();
        // Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
        // opp.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
        // opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
        // opp.AccountId = acc.Id;
        // newList.add(opp);
        // Opportunity oppOld = new Opportunity();
        // oppOld = opp.clone(true, false, false, false);
        // oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
        // oldList.add(oppOld);
        // //Inject Test Data
        // IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities = new List<Opportunity>();
        // Opportunity oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
        // oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
        // oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
        // IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);
        // callCUT(newList, oldList);
        // Assert.areEqual(1, IMM_TA_Opportunity_CloseLostTriageOpp.testResults.size(), 'testAfterUpdatePositive FAILED: should not be processed');
        // Assert.areEqual(IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST, IMM_TA_Opportunity_CloseLostTriageOpp.testResults[0].StageName, 'testAfterUpdatePositive FAILED: Stagename is Unexpected');
    }

    // @IsTest
    // static void testAfterUpdatePositiveManagedTriageOpps() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Account acc = IMM_TestDataFactory.createAccount();
    //     Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_ONBOARDING;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
    //     opp.AccountId = acc.Id;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
    //     oldList.add(oppOld);
    //     //Inject Test Data
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities = new List<Opportunity>();
    //     Opportunity oppInject = opp;
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);
    //     callCUT(newList, oldList);
    //     Assert.areEqual(1, IMM_TA_Opportunity_CloseLostTriageOpp.testResults.size(), 'testAfterUpdatePositiveManagedTriageOpps FAILED: should not be processed');
    //     Assert.areEqual(IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST, IMM_TA_Opportunity_CloseLostTriageOpp.testResults[0].StageName, 'testAfterUpdatePositive FAILED: Stagename is Unexpected');
    // }

    // @IsTest
    // static void testAfterUpdateNegativeNoChangeInStagename() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Account acc = IMM_TestDataFactory.createAccount();
    //     Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     opp.AccountId = acc.Id;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
    //     oldList.add(oppOld);
    //     //Inject Test Data
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities = new List<Opportunity>();
    //     Opportunity oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
    //     oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);
    //     callCUT(newList, oldList);
    //     Assert.areEqual(0, IMM_TA_Opportunity_CloseLostTriageOpp.testResults.size(), 'testAfterUpdateNegativeNoChangeInStagename FAILED: should not be processed');
    // }

    // @IsTest
    // static void testAfterUpdateNegativeOldStagenameNotClosedWon() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Account acc = IMM_TestDataFactory.createAccount();
    //     Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     opp.AccountId = acc.Id;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     //Inject Test Data
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities = new List<Opportunity>();
    //     Opportunity oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
    //     oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);
    //     callCUT(newList, oldList);
    //     Assert.areEqual(0, IMM_TA_Opportunity_CloseLostTriageOpp.testResults.size(), 'testAfterUpdateNegativeOldStagenameNotClosedWon FAILED: should not be processed');
    // }

    // @IsTest
    // static void testAfterUpdateNegativeHasClosedWonOpps() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Account acc = IMM_TestDataFactory.createAccount();
    //     Opportunity opp = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDLOST;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     opp.AccountId = acc.Id;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     //Inject Test Data
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities = new List<Opportunity>();
    //     Opportunity oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
    //     oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);
    //     oppInject = new Opportunity();
    //     oppInject = IMM_TestDataFactory.createOpportunity(acc.Id);
    //     oppInject.Name = 'Closed Won BBP Test';
    //     oppInject.StageName = IMM_Util_Constants.OPP_STAGENAME_CLOSEDWON;
    //     oppInject.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     IMM_TA_Opportunity_CloseLostTriageOpp.testOpportunities.add(oppInject);

    //     callCUT(newList, oldList);
    //     Assert.areEqual(0, IMM_TA_Opportunity_CloseLostTriageOpp.testResults.size(), 'testAfterUpdateNegativeHasClosedWonOpps FAILED: should not be processed');
    // }

    // static void callCUT(List<Opportunity> newList, List<Opportunity> oldList){
    //      Test.startTest();
    //      IMM_TA_Opportunity_CloseLostTriageOpp.afterUpdate(newList, oldList);
    //      Test.stopTest();
    // }
 
    
}