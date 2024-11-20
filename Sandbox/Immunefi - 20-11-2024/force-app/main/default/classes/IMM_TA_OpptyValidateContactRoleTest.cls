/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 01-09-2024
 * @last modified by  : julian.yong
**/
@isTest
private class IMM_TA_OpptyValidateContactRoleTest {
   @IsTest
   static void validateContactRolesShouldTrigger() {
      List<Opportunity> testOpps = new List<Opportunity>();
      Opportunity opp = new Opportunity();
      opp.Id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
      opp.StageName = IMM_Util_Constants.OPP_STAGENAME_ONBOARDING;
      opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
      testOpps.add(opp);
      opp = new Opportunity();
      opp.Id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
      opp.StageName = IMM_Util_Constants.OPP_STAGENAME_HANDOVER;
      opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_BBPID;
      testOpps.add(opp);
      opp = new Opportunity();
      opp.Id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
      opp.StageName = IMM_Util_Constants.OPP_STAGENAME_ONBOARDING;
      opp.RecordTypeId = IMM_Util_Constants.RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID;
      testOpps.add(opp);
      injectTestData(testOpps[0].Id);
      callCUT(testOpps);
      validate(testOpps[0].Id);
      
   }


   static void injectTestData(Id oppId){
      IMM_TA_Opportunity_ValidateContactRole.testOppIdToListOfContactRolesMissing = new Map<Id, List<String>>();
      List<String> missingConRoles= new List<String>{ 'Program Administrator', 
                                                      'Alternate Program Administrator',
                                                      'Business User'
                                                    };
      IMM_TA_Opportunity_ValidateContactRole.testOppIdToListOfContactRolesMissing.put(oppId, missingConRoles);
      IMM_TA_Opportunity_ValidateContactRole.injectTestData = true;
   }

   static void callCUT(List<Opportunity> newList){
       Test.startTest();
       IMM_TA_Opportunity_ValidateContactRole.beforeUpdate(newList, new List<Opportunity>());
       Test.stopTest();
       
   }    

   static void validate(Id expOppId){      
     Assert.areEqual(3,IMM_TA_Opportunity_ValidateContactRole.testResults.size(), 'Negative test Failed, no opportunity retrieved');
     for (Opportunity opp : IMM_TA_Opportunity_ValidateContactRole.testResults) {
         List<Database.Error> oppErrors = opp.getErrors();
         if (opp.Id == expOppId) {
            Assert.areEqual(1, oppErrors.size(), 'test failed: no errors found when it should log an error');
            List<String> missingConRoles= new List<String>{ 'Program Administrator', 
                                                               'Alternate Program Administrator',
                                                               'Business User'
                                                            };
            Assert.areEqual(System.Label.IMM_LB_ContactRoles + ' ' + String.join(missingConRoles, ', '), oppErrors[0].getMessage(), 'Negative test failed: No Such Error');
            continue;
         }

         Assert.areEqual(0, oppErrors.size(), 'test failed: errors found when it should not');
         
     }
     
   }
}