@IsTest
public class SendEmailInvocableTest {

    @TestSetup
    static void makeData() {

        Lead lead = new Lead();
        lead.LeadSource = 'Websites';
        lead.FirstName = 'test';
        lead.LastName = 'test';
        lead.Email = 'testemail@gmail.com';
        insert lead;
    }

    static testMethod void doTest() {

        EmailTemplate et = new EmailTemplate();
        et.isActive = true;
        et.Name = 'testTemplateTestclass';
        et.DeveloperName = 'testTemplate' + System.now().getTime();
        et.TemplateType = 'text';
        et.FolderId = UserInfo.getUserId();
        et.Body = '';
        insert et; 

        List<Lead> lead = [SELECT Id,Email FROM Lead WHERE FirstName = 'test'];
 
        Test.startTest();

            SendEmailInvocable.Requests r = new SendEmailInvocable.Requests();
            r.emailTemplateId = et.Id;
            r.recipientEmail = lead[0].Email;
            r.targetRecordId = lead[0].Id;

            List<SendEmailInvocable.Results> result = SendEmailInvocable.execute( 
                new SendEmailInvocable.Requests[]{r}
            );

        Test.stopTest();
    }
     
}