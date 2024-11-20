@isTest
private class createOppLineControllerTest {
    
    @testSetup static void setup() {
        String projectsRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Projects').getRecordTypeId();
        String subscriptionRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Subscription').getRecordTypeId();
        
        Account testAccount = new Account(
            Name = 'Test Account',
            RecordTypeId = projectsRecTypeId
        );

        // Insert the Account
        insert testAccount;
        
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Proposal', // Set appropriate stage name
            CloseDate = Date.today() + 30, 
			AccountId = testAccount.Id,
			RecordTypeId = subscriptionRecTypeId		            
        );
        insert testOpportunity;  
        
        Product2 testProduct = new Product2(
            Name = 'Boost',
            Product_Type__c = 'Add-On',
            IsActive = true
        );

        insert testProduct;
        
        Pricebook2 testPricebook = new Pricebook2(
            Name = 'Standard Price Book',
            IsActive = true
        );

        // Insert the Pricebook
        insert testPricebook;
        
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = testProduct.Id,
            UnitPrice = 100.00, // Set the standard price as needed
            IsActive = true
            // Set other required fields as needed
        );
        insert standardPrice;
        
        PricebookEntry testPricebookEntry = new PricebookEntry(
            Pricebook2Id = testPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100.00, // Set the price as needed
            IsActive = true
        );

        // Insert the Pricebook Entry
        insert testPricebookEntry;
    }
    
    @isTest
    static void testComponentInit() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        
        // Call the componentInit method
        createOppLineController.InitializedResult result = createOppLineController.componentInit(opp.Id);
        
    }
    
    @isTest
    static void testSubmitRecord() {
        String subscriptionRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Subscription').getRecordTypeId();
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Pricebook2 pricebook = [SELECT Id, Name FROM Pricebook2 WHERE Name = 'Standard Price Book'];
        Product2 product = [SELECT Id, Name FROM Product2 WHERE Name = 'Boost'];
        
        // Call the sumbitRecord method
        createOppLineController.InitializedResult result = createOppLineController.sumbitRecord(new List<String>{product.Id}, new Map<String,Decimal>{}, opp.Id, subscriptionRecTypeId,
                                                                                                pricebook.Id, 'Essential', 100.00);
        
    }
}