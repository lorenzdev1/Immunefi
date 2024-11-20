@isTest
public class LCPSentEmailSchedulerTest {
    
    @isTest
    static void testExecute() {
        // Setup test data if needed
        // Example: Insert Leads or other necessary records
        Lead l = new Lead(
            Firstname = 'Fname',
            Lastname  = 'Lname',
            Email = 'email@test.com',
            Company = 'Test Company',
            LeadSource = 'Employee Referral'
        );
        insert l;

        List<Lead_Campaign_Process__c> lcpList = new List<Lead_Campaign_Process__c>();
        Map<Integer, String> emailTemplateMap = new Map<Integer, String>{
            0 => 'Introducing_Immunefi_1715087906364',
            1 => 'Checking_In_Follow_Up_on_Immunefi_Collaboration_Opportunity_1715088562590',
            2 => 'Checking_In_Immunefi_Partnership_Opportunity_1715088425062'
        };

        for(Integer i = 0; i < 3; i++) {
            Lead_Campaign_Process__c lcp = new Lead_Campaign_Process__c(
                Lead__c = l.Id,
                Send_Date__c = Date.today() - i,
                Status__c = 'Pending',
                Email_template__c = emailTemplateMap.get(i)
            );
            lcpList.add(lcp);
        }

        insert lcpList;

        // Create an instance of the class
        LeadCampaignProcessSentEmailScheduler scheduler = new LeadCampaignProcessSentEmailScheduler();
        
        // Create a mock SchedulableContext
        Test.StartTest();
        String jobId = System.schedule('Test Job', '0 0 0 15 5 ?', scheduler);
        System.assertNotEquals(null, jobId, 'Job ID should not be null');
        
        // Execute the scheduler
        scheduler.execute(null);

        // Verify that the batch job was called
        Integer jobCount = [SELECT count() FROM AsyncApexJob WHERE JobType='BatchApex' AND Status = 'Queued'];
        System.assertEquals(1, jobCount, 'There should be one batch job queued');

        Test.StopTest();
    }
}