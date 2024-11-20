/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 12-21-2023
 * @last modified by  : julian.yong
**/
@IsTest
private class IMM_OpportunityTriggerHandlerTest {

    @IsTest
    static void validateContactRolesShouldTrigger() {
        List<Id> testIds = new List<Id>();
        List<OpportunityContactRole> testConRoles = new List<OpportunityContactRole>();

        OpportunityContactRole testConRole = new OpportunityContactRole();
        testConRole.ContactId = TriggerTestUtility.getFakeId(Contact.getSObjectType());
        testConRole.OpportunityId = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
        testConRole.Role = 'Program Administrator';
        testConRoles.add(testConRole);

        testIds.add(testConRole.OpportunityId);

        testConRole = new OpportunityContactRole();
        testConRole.ContactId = TriggerTestUtility.getFakeId(Contact.getSObjectType());
        testConRole.OpportunityId = testIds[0];
        testConRole.Role = 'Alternate Program Administrator';
        testConRoles.add(testConRole);

        injectTestData(testConRoles);
        validate(callCUT(testIds), testIds[0], 1);
    }

    @IsTest
    static void validateContactRolesShouldTriggerWhenNoResultFromSOQL() {
        List<Id> testIds = new List<Id>();
        List<OpportunityContactRole> testConRoles = new List<OpportunityContactRole>();
        testIds.add(TriggerTestUtility.getFakeId(Opportunity.getSObjectType()));
        injectTestData(testConRoles);
        validate(callCUT(testIds), testIds[0], 2);
    }


    @IsTest
    static void validateContactRolesShouldNotTrigger() {
        List<Id> testIds = new List<Id>();
        List<OpportunityContactRole> testConRoles = new List<OpportunityContactRole>();

        OpportunityContactRole testConRole = new OpportunityContactRole();
        testConRole.ContactId = TriggerTestUtility.getFakeId(Contact.getSObjectType());
        testConRole.OpportunityId = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
        testConRole.Role = 'Program Administrator';
        testConRoles.add(testConRole);

        testIds.add(testConRole.OpportunityId);

        testConRole = new OpportunityContactRole();
        testConRole.ContactId = TriggerTestUtility.getFakeId(Contact.getSObjectType());
        testConRole.OpportunityId = testIds[0];
        testConRole.Role = 'Alternate Program Administrator';
        testConRoles.add(testConRole);

        testConRole = new OpportunityContactRole();
        testConRole.ContactId = TriggerTestUtility.getFakeId(Contact.getSObjectType());
        testConRole.OpportunityId = testIds[0];
        testConRole.Role = 'Business User';
        testConRoles.add(testConRole);

        injectTestData(testConRoles);
        validate(callCUT(testIds), testIds[0], 3);
    }

    static void injectTestData(List<OpportunityContactRole> oppConRoles){
        IMM_OpportunityTriggerHandler.testExpectedContactRoles = new Set<String>{   'Program Administrator',
                                                                                    'Alternate Program Administrator',
                                                                                    'Business User'
                                                                                    };
        IMM_OpportunityTriggerHandler.testOppContactRoles = new List<OpportunityContactRole>();
        IMM_OpportunityTriggerHandler.testOppContactRoles = oppConRoles;
        IMM_OpportunityTriggerHandler.injectTestData = true;


    }

    static Map<Id, List<String>> callCUT(List<Id> oppIds){
        Test.startTest();
        Map<Id, List<String>> testResults = IMM_OpportunityTriggerHandler.validateContactRoles(oppIds);
        Test.stopTest();
        return testResults;
    }    

    static void validate(Map<Id, List<String>> testResult, Id oppId, Integer testNo){
        if (testNo == 1) {
            assert.areEqual(1, testResult.size(), 'No Record in map');
            assert.areEqual(1, testResult.get(oppId).size(), 'No Record in list');
            assert.areEqual('Business User', testResult.get(oppId)[0], 'wrong record retrieved');
        }
        if (testNo == 2) {
            assert.areEqual(1, testResult.size(), 'No Record in map');
            assert.areEqual(3, testResult.get(oppId).size(), 'Record in list insufficient');
            Set<String> expValues = new Set<String>{    'Program Administrator',
                                                        'Alternate Program Administrator',
                                                        'Business User'
                                                        };
            expValues.removeAll(testResult.get(oppId));                                            
            assert.areEqual(0, expValues.size(), 'Test 2: Values Remain');
        }


        if (testNo == 3) {
            assert.areEqual(0, testResult.size(), 'Negative Test: there is Record in map');
            return;
        }
    }
}