/**
 * @description       : DEPRECATED*********
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-06-2023
 * @last modified by  : julian.yong
**/
@isTest
private class IMM_TA_Oppotunity_ValidateHandoverTest {
    @IsTest
    static void testBeforeUpdatePositive() {
    //  List<Opportunity> newList = new List<Opportunity>();
    //  List<Opportunity> oldList = new List<Opportunity>();
    //  Opportunity opp = new Opportunity();
    //  opp.id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
    //  opp.Name = 'New Opp 1';   
    //  opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    //  opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //  newList.add(opp);
    //  Opportunity oppOld = new Opportunity();
    //  oppOld = opp.clone(true, false, false, false);
    //  oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //  oldList.add(oppOld);
    //  injectReviews(1, 1, opp.id);
    //  callCUT(newList, oldList);
    //  validate(true);
    }

    // @IsTest
    // static void testBeforeUpdateNegetiveTechReview() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Opportunity opp = new Opportunity();
    //     opp.id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
    //     opp.Name = 'New Opp 1';   
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     injectReviews(1, 1, opp.id);
    //     IMM_TA_Oppotunity_ValidateHandover.technicalReviewTest[0].IMM_PL_Status__c = IMM_Util_Constants.REVIEW_STAGENAME_FINALTECHREVIEW;
    //     callCUT(newList, oldList);
    //     validate(false);
    // }

    // @IsTest
    // static void testBeforeUpdateNegetiveLegalReview() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Opportunity opp = new Opportunity();
    //     opp.id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
    //     opp.Name = 'New Opp 1';   
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     injectReviews(1, 1, opp.id);
    //     IMM_TA_Oppotunity_ValidateHandover.legalReviewTest[0].IMM_PL_Status__c = IMM_Util_Constants.REVIEW_STAGENAME_LEGALEXTERNAL;
    //     callCUT(newList, oldList);
    //     validate(false);
    // }

    // @IsTest
    // static void testBeforeUpdateNegetiveMissingReviews() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Opportunity opp = new Opportunity();
    //     opp.id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
    //     opp.Name = 'New Opp 1';   
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     injectReviews(0, 0, opp.id);
    //     callCUT(newList, oldList);
    //     validate(false);
    // }

    // @IsTest
    // static void testBeforeUpdateNegetiveMissingOneReview() {
    //     List<Opportunity> newList = new List<Opportunity>();
    //     List<Opportunity> oldList = new List<Opportunity>();
    //     Opportunity opp = new Opportunity();
    //     opp.id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
    //     opp.Name = 'New Opp 1';   
    //     opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    //     opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
    //     newList.add(opp);
    //     Opportunity oppOld = new Opportunity();
    //     oppOld = opp.clone(true, false, false, false);
    //     oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_INREVIEW;
    //     oldList.add(oppOld);
    //     injectReviews(1, 0, opp.id);
    //     callCUT(newList, oldList);
    //     validate(false);
    // }

    // static void injectReviews(Integer noOfTechReviews, Integer noOfLegalReviews, Id oppId){
    //     IMM_TA_Oppotunity_ValidateHandover.technicalReviewTest = new List<IMM_CO_ReviewProcess__c>();
    //     IMM_TA_Oppotunity_ValidateHandover.legalReviewTest = new List<IMM_CO_ReviewProcess__c>();
    //     for (Integer i = 0; i < noOfTechReviews; i++) {
    //         IMM_CO_ReviewProcess__c techReview = new IMM_CO_ReviewProcess__c();
    //         techReview.RecordTypeId = IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_TECHREVIEWID;
    //         techReview.Name = 'TechReview' + String.valueOf(i);
    //         techReview.IMM_MD_OpportunityNumber__c = oppId;
    //         techReview.IMM_PL_Status__c = IMM_Util_Constants.REVIEW_STAGENAME_APPROVEDFORLAUNCH;
    //         IMM_TA_Oppotunity_ValidateHandover.technicalReviewTest.add(techReview);
    //     }

    //     for (Integer i = 0; i < noOfLegalReviews; i++) {

    //         IMM_CO_ReviewProcess__c legalReview = new IMM_CO_ReviewProcess__c();
    //         legalReview.RecordTypeId =  IMM_Util_Constants.RECORDTYPE_REVIEWPROCESS_LEGALREVIEWID;
    //         legalReview.Name = 'LegalReview' + String.valueOf(i);
    //         legalReview.IMM_MD_OpportunityNumber__c = oppId;
    //         legalReview.IMM_PL_Status__c = IMM_Util_Constants.REVIEW_STAGENAME_COMPLETE;
    //         IMM_TA_Oppotunity_ValidateHandover.legalReviewTest.add(legalReview);
    //     }
    // }


 
    // static void callCUT(List<Opportunity> newList, List<Opportunity> oldList){
    //      Test.startTest();
    //      IMM_TA_Oppotunity_ValidateHandover.beforeUpdate(newList,oldList);
    //      Test.stopTest();
    // }
 
    // static void validate(Boolean isPositiveTest) {
        
    //     Assert.areEqual(1, IMM_TA_Oppotunity_ValidateHandover.testResults.size(), 'Test Results should always have one item');
    //     List<Database.Error> oppErrors = IMM_TA_Oppotunity_ValidateHandover.testResults[0].getErrors();

    //     if (isPositiveTest) {
    //         Assert.areEqual(0, oppErrors.size(), 'Positive test failed: errors found');
    //         return;
    //     }

    //     Assert.areEqual(1, oppErrors.size(), 'Negetive test failed: no errors found');
    //     Assert.areEqual(IMM_Util_Constants.ERR02_REVIEWSNOTAPPROVED, oppErrors[0].getMessage(), 'Negative test failed: No Such Error');
        
    // }
 
}