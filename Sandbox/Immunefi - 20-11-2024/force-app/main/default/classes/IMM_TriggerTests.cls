/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 01-05-2024
 * @last modified by  : julian.yong
**/
@isTest
private class IMM_TriggerTests {
    @isTest
    static void testTriggers() {
        TriggerBase.bypass('Account');
        TriggerBase.bypass('Opportunity');

        Test.startTest();
        Account account = createAccount();
        Opportunity opportunity = createOpportunity(account);
        Lead lead = createLead();
        Test.stopTest();
    }

    private static Account createAccount() {
        Account account = new Account();
        account.Name = 'Immunifi Test';
        insert account;
        return account;
    }

    private static Opportunity createOpportunity(Account account) {
        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = account.Id;
        opportunity.Name = 'Test Opportunity';
        opportunity.StageName = 'Proposal';
        opportunity.CloseDate = Date.today();
        insert opportunity;
        return opportunity;
    }

    private static Lead createLead(){
        Lead lead = new Lead();
        lead.LastName = 'TestLead';
        lead.LeadSource = 'Other';
        lead.Company = 'TestCompany';
        insert lead;
        return lead;
    }
}