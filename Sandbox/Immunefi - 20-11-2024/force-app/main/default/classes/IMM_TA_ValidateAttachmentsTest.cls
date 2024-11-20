/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 01-09-2024
 * @last modified by  : julian.yong
**/
@isTest
private class IMM_TA_ValidateAttachmentsTest {
   @IsTest
   static void testBeforeUpdatePositive() {
    List<Opportunity> newList = new List<Opportunity>();
    List<Opportunity> oldList = new List<Opportunity>();
    String jsonString = IMM_TestDataFactory.loadJSON('IMM_TA_ValidateAttachmentsTest');
    IMM_TA_ValidateAttachments.testContentVersions = (List<ContentVersion>)JSON.deserialize(jsonString, List<ContentVersion>.class);
    Opportunity opp = new Opportunity();
    opp.id = IMM_TA_ValidateAttachments.testContentVersions[0].FirstPublishLocationId;
    opp.Name = 'New Opp 1';   
    opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    newList.add(opp);
    Opportunity oppOld = new Opportunity();
    oppOld = opp.clone(true, false, false, false);
    oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_NEGOTIATION;
    oldList.add(oppOld);
    callCUT(newList, oldList);
    validate(true);
   }

   @IsTest
   static void testBeforeUpdateNegative() {
    List<Opportunity> newList = new List<Opportunity>();
    List<Opportunity> oldList = new List<Opportunity>();
    String jsonString = IMM_TestDataFactory.loadJSON('IMM_TA_ValidateAttachmentsTest');
    IMM_TA_ValidateAttachments.testContentVersions = (List<ContentVersion>)JSON.deserialize(jsonString, List<ContentVersion>.class);
    Opportunity opp = new Opportunity();
    opp.id = IMM_TA_ValidateAttachments.testContentVersions[0].FirstPublishLocationId;
    opp.Name = 'New Opp 1';   
    opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    newList.add(opp);
    Opportunity oppOld = new Opportunity();
    oppOld = opp.clone(true, false, false, false);
    oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_NEGOTIATION;
    oldList.add(oppOld);
    IMM_TA_ValidateAttachments.testContentVersions.remove(0);
    callCUT(newList, oldList);
    validate(false);
    IMM_TA_ValidateAttachments.testHack();
   }

   @IsTest
   static void testBeforeUpdateNegativeNoDocType() {
    List<Opportunity> newList = new List<Opportunity>();
    List<Opportunity> oldList = new List<Opportunity>();
    String jsonString = IMM_TestDataFactory.loadJSON('IMM_TA_ValidateAttachmentsTest');
    IMM_TA_ValidateAttachments.testContentVersions = (List<ContentVersion>)JSON.deserialize(jsonString, List<ContentVersion>.class);
    Opportunity opp = new Opportunity();
    opp.id = IMM_TA_ValidateAttachments.testContentVersions[0].FirstPublishLocationId;
    opp.Name = 'New Opp 1';   
    opp.StageName =  IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
    newList.add(opp);
    Opportunity oppOld = new Opportunity();
    oppOld = opp.clone(true, false, false, false);
    oppOld.StageName = IMM_Util_Constants.OPP_STAGENAME_NEGOTIATION;
    oldList.add(oppOld);
    IMM_TA_ValidateAttachments.testContentVersions[0].IMM_PL_DocumentType__c = '';
    system.debug(IMM_TA_ValidateAttachments.testContentVersions);
    callCUT(newList, oldList);
    validate(false);
   }

   static void callCUT(List<Opportunity> newList, List<Opportunity> oldList){
        Test.startTest();
        IMM_TA_ValidateAttachments.beforeUpdate(newList,oldList);
        Test.stopTest();
   }

   static void validate(Boolean isPositiveTest) {
      if (isPositiveTest) {
         Assert.areEqual(1, IMM_TA_ValidateAttachments.testResults.size(), 'Positive test failed: Should not have error in opportunity with all required documents');
         return;
      }

      Assert.areEqual(1, IMM_TA_ValidateAttachments.testResults.size(), 'Negative test failed: Should add Error to opportunity');
      List<Database.Error> oppErrors = IMM_TA_ValidateAttachments.testResults[0].getErrors();
      Assert.areEqual(1, oppErrors.size(), 'Negetive test failed: no errors found');
      Assert.areEqual(System.Label.IMM_LB_DocumentIncomplete, oppErrors[0].getMessage(), 'Negative test failed: No Such Error');

   }
}