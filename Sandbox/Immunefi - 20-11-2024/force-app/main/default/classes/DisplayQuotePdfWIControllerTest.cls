/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class DisplayQuotePdfWIControllerTest {
    private static testMethod void displayQuotePdfTest() {

        Account objAccount = new Account(Name = 'Test Acc1', 
                                        BillingCity = 'Test City', 
                                        BillingState = 'Test State', 
                                        BillingStreet = 'Test Street', 
                                        BillingPostalCode = '12345', 
                                        BillingCountry = 'Test Country',
                                        Phone = '123456');
        insert objAccount;

        Product2 objProduct = new Product2(Name = 'Test product1', Family = 'Test');
        insert objProduct;

        PriceBookEntry objPBE = new PriceBookEntry(UnitPrice = 300, 
                        PriceBook2Id = Test.getStandardPricebookId(),
                        Product2Id = objProduct.Id, IsActive = true);
        insert objPBE;

        Opportunity objOpp = new Opportunity(Name = 'Test Opp', 
                                            AccountId = objAccount.Id, 
                                            StageName = 'In Review', 
                                            CloseDate = Date.today()+1);
        insert objOpp;

        Quote q = new Quote(OpportunityId = objOpp.Id, 
                            Name = 'Test Quote', 
                            Pricebook2Id = objPBE.PriceBook2Id, 
                            Status = 'In Review');
        insert q;

        QuoteDocument qd = new QuoteDocument(quoteId = q.Id, Document = Blob.valueOf('Hello World'));
        insert qd;

        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitRequest();
        app.setObjectId(q.id);
        Approval.ProcessResult result = Approval.process(app);
        System.debug('app : '+result.getInstanceId());

        ProcessInstanceWorkItem approvalWI = [SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkItem 
                                            WHERE ProcessInstanceId =: result.getInstanceId()];

        ApexPages.StandardController sc = new ApexPages.StandardController(approvalWI);
        PageReference pageRef = Page.DisplayQuotePdfWorkItem;
        Test.setCurrentPage(pageRef);

        DisplayQuotePdfWIController ctrl = new DisplayQuotePdfWIController(sc);        
        System.assert(ctrl.pdfBlobStr != null);
    }
}