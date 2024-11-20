@isTest
public class LeadCampaignProcessSentEmailBatchTest {
    
    private static testMethod void sendEmailTest() {
        OrgWideEmailAddress specificOrgWideEmailAddress = [SELECT Id, Address FROM OrgWideEmailAddress WHERE IsVerified = true LIMIT 1];
        System.debug('specificOrgWideEmailAddress' + specificOrgWideEmailAddress);

        Profile pf= [Select Id from profile where Name='System Administrator']; 

        String orgId=UserInfo.getOrganizationId(); 

        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;

        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 

        String uniqueName=orgId+dateString+RandomId; 

        User uu=new User(firstname = 'ABC', 
                         lastName = 'XYZ', 
                         email = specificOrgWideEmailAddress.Address, 
                         Username = specificOrgWideEmailAddress.Address + 'testClass', 
                         EmailEncodingKey = 'ISO-8859-1', 
                         Alias = uniqueName.substring(18, 23), 
                         TimeZoneSidKey = 'America/Los_Angeles', 
                         LocaleSidKey = 'en_US', 
                         LanguageLocaleKey = 'en_US', 
                         ProfileId = pf.Id
                        ); 

        insert uu;
        System.runAs(uu) {
            Lead l = new Lead(
                Firstname = 'Fname',
                Lastname  = 'Lname',
                Email = specificOrgWideEmailAddress.Address,
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
        }

        Test.startTest();
            Database.executeBatch(new LeadCampaignProcessSentEmailBatch());
        Test.stopTest();
    }
}