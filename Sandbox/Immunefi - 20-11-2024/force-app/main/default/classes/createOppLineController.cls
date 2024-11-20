/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-08-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class createOppLineController {
    @AuraEnabled
    public static InitializedResult componentInit(String recordId) {
        InitializedResult initResult = new InitializedResult();
        try {
            initResult.data = DataResult(recordId);
            initResult.error = null;
        } catch(Exception e){
            initResult.data = null;
            initResult.error = 'Error Message: ' + e;
        }
        return initResult;
    }

    @AuraEnabled
    public static InitializedResult sumbitRecord(List<String> productIdList, Map<String,Decimal> pbProductPriceMap, string recordId, string oppRecTypeId,
                                                String paymentStructureSelected, String corePlanSelected, Decimal prizePoolValue) {
        InitializedResult initResult = new InitializedResult();
        try {
            deleteOppLine(recordId);
            updateOpp(paymentStructureSelected, corePlanSelected, recordId, prizePoolValue);
            
            initResult.oppLineItems = createOppLines(productIdList, pbProductPriceMap, prizePoolValue, recordId, oppRecTypeId);
            initResult.data = 'SUBMIT SUCCESS';
            initResult.error = null;
        } catch(Exception e){
            initResult.data = null;
            initResult.error = 'Error Message: ' + e;
        }
        return initResult;
    }

    private static String DataResult(String recordId) {
        DataResult newDataResult = new DataResult();
        List<CustomOption> paymentStructureOptions = new List<CustomOption>();
        Set<String> oppLinesSelected = new Set<String>();
        Set<String> priceBookNamesSet = new Set<String>();
        Map<String, String> priceBookNameOptionLabelMap = new Map<String, String>();
        Map<String, List<customOption>> addOnOptionsMap = new Map<String, List<customOption>>();
        Map<String, Map<String,Decimal>> pbProductPricingMap = new Map<String, Map<String,Decimal>>();
        Map<String, String> corePlanProducts = new Map<String, String>();
        Opportunity oppRecord = getOpportunity(recordId);

        for(Product2 product : getCorePlanProducts()){
            corePlanProducts.put(product.Name, product.Formatted_Product_Description__c);
        }

        for(CreateOppLine_PriceBook__mdt customMetadataRec : [SELECT MasterLabel, Option_Label__c,Order__c FROM CreateOppLine_PriceBook__mdt ORDER BY Order__c desc]) {
            System.debug('*** priceBookNamesSet '+customMetadataRec.MasterLabel);
            priceBookNameOptionLabelMap.put(customMetadataRec.MasterLabel, customMetadataRec.Option_Label__c);
            priceBookNamesSet.add(customMetadataRec.MasterLabel);
        }


        for(Pricebook2 priceBook : getPriceBooks(priceBookNamesSet)){
            String priceBookLabel = '';
            Map<String,Decimal> productPriceMap = new Map<String,Decimal>();

            priceBookLabel = priceBookNameOptionLabelMap.get(priceBook.Name);
            System.debug('*** paymentStructureOptions '+priceBookLabel);
            paymentStructureOptions.add(new CustomOption(priceBookLabel, priceBook.Id.toString()));
            

            for(PricebookEntry priceBookEntryRec : priceBook.PricebookEntries){
                productPriceMap.put(priceBookEntryRec.Product2Id.toString(), priceBookEntryRec.UnitPrice);
                if(priceBookEntryRec.Product2.Product_Type__c == 'Add-On'){
                    if(addOnOptionsMap.containsKey(priceBook.Id)){
                    addOnOptionsMap.get(priceBook.Id).add(new CustomOption(priceBookEntryRec.Name, priceBookEntryRec.Product2Id.toString()));
                    } else {
                        addOnOptionsMap.put(priceBook.Id, new List<CustomOption>{new CustomOption(priceBookEntryRec.Name, priceBookEntryRec.Product2Id.toString())});
                    }
                }
            }
            if(productPriceMap.size() > 0){
                pbProductPricingMap.put(priceBook.Id, productPriceMap);
            }
        }

        for(OpportunityLineItem oppLineItem : oppRecord.OpportunityLineItems){
            oppLinesSelected.add(oppLineItem.Product2Id);
        }
        
        newDataResult.corePlanProducts = corePlanProducts;
        newDataResult.paymentStructureOptions = paymentStructureOptions;
        newDataResult.addOnOptionsMap = addOnOptionsMap;
        newDataResult.oppId = oppRecord.Id;
        newDataResult.oppCorePlan = oppRecord.Core_Plan__c;
        newDataResult.oppPaymentStructure = oppRecord.Pricebook2Id;
        newDataResult.oppRecTypeId = oppRecord.RecordTypeId;
        newDataResult.oppPrizePool = oppRecord.Whitehat_Reward_Structure__c;
        newDataResult.oppLinesSelected = oppLinesSelected;
        newDataResult.pbProductPricingMap = pbProductPricingMap;
        return JSON.serialize(newDataResult);
    }

    private static void updateOpp(String paymentStructureSelected, String corePlanSelected, string recordId, Decimal prizePoolValue) {
        Opportunity oppToUpdate = new Opportunity();
        
        String pricebookName = [Select Name from Pricebook2 WHERE Id =: paymentStructureSelected LIMIT 1].Name;
        CreateOppLine_PriceBook__mdt customMetadataRec = [SELECT MasterLabel, Option_Label__c FROM CreateOppLine_PriceBook__mdt WHERE MasterLabel =: pricebookName];
        System.debug('****** '+paymentStructureSelected);
        oppToUpdate.Id = recordId;
        oppToUpdate.Pricebook2Id = paymentStructureSelected;
        oppToUpdate.Core_Plan__c = corePlanSelected;
        oppToUpdate.Whitehat_Reward_Structure__c = prizePoolValue;
        oppToUpdate.Subscription_Payment_Structure__c  = customMetadataRec.Option_Label__c;
                                                        
        update oppToUpdate;
    }

    private static List<OpportunityLineItem> createOppLines(List<String> productIdList, Map<String,Decimal> pbProductPriceMap, Decimal prizePoolValue, string recordId, string oppRecTypeId) {
        List<OpportunityLineItem> oppLinesToInsert = new List<OpportunityLineItem>();
        String boostRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Boost').getRecordTypeId();
		String subsRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Subscription').getRecordTypeId(); //Added Apr-1-2024
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id, 
                                                                Whitehat_Reward_Structure__c,
                                                                Core_Plan__c
                                                                FROM Opportunity WHERE Id =: recordId]); //Added Apr-1-2024
        
        for(String productId :  productIdList){
            OpportunityLineItem tempOppLine = new OpportunityLineItem();
            tempOppLine.OpportunityId = recordId;
            tempOppLine.Product2Id = productId;
            tempOppLine.Quantity = 1;
            if(productId == System.Label.Run_as_Invite_Only_Program_Product_Id){
                System.debug('******** Run_as_Invite_Only_Program_Product_Id ');
                tempOppLine.UnitPrice = prizePoolValue * 0.25;
            } else if(productId == System.Label.Attackathon_Product_Id){
                System.debug('******** Attackathon_Product_Id ');
                tempOppLine.UnitPrice = prizePoolValue * 0.3;
            } else if(productId == System.Label.Boost_Product_Id) { //Added Apr-1-2024
                System.debug('******** Boost_Product_Id ');
                if(oppRecTypeId == boostRecTypeId) {
                     System.debug('******** boostRecTypeId ');
                	tempOppLine.UnitPrice = 0.275 * 500000;
                } 
                else if(oppRecTypeId == subsRecTypeId) {
                    System.debug('******** subsRecTypeId ');
                    Opportunity opp = oppMap.get(recordId);
                    System.debug('******** Whitehat_Reward_Structure__c ' +opp.Whitehat_Reward_Structure__c);
                    System.debug('******** Core_Plan__c ' +opp.Core_Plan__c);
                    if(opp.Whitehat_Reward_Structure__c < 100000 && (opp.Core_Plan__c == 'Pro' || opp.Core_Plan__c == 'Elite')) {
                        tempOppLine.UnitPrice = (opp.Whitehat_Reward_Structure__c - 50000) * 0.2;
                    }
                    else if(opp.Whitehat_Reward_Structure__c > 100000 && opp.Core_Plan__c == 'Pro') {
                        tempOppLine.UnitPrice = (opp.Whitehat_Reward_Structure__c - 50000) * 0.2;
                    }
                    else if(opp.Whitehat_Reward_Structure__c > 100000 && opp.Core_Plan__c == 'Elite') {
                        tempOppLine.UnitPrice = (opp.Whitehat_Reward_Structure__c - 50000) * 0.185;
                    }else{
                        tempOppLine.UnitPrice = pbProductPriceMap.get(productId);
                    }
                }
            }
            else if(oppRecTypeId == boostRecTypeId){
                if(productId == System.Label.Mitigation_Review_Low_Severity_Product_Id){
                    tempOppLine.UnitPrice = 2500;
                } else if(productId == System.Label.Mitigation_Review_Medium_Severity_Product_Id){
                    tempOppLine.UnitPrice = 5000;
                } else if(productId == System.Label.Mitigation_Review_High_Severity_Product_Id){
                    tempOppLine.UnitPrice = 6000;
                } else if(productId == System.Label.Mitigation_Review_Critical_Severity_Product_Id){
                    tempOppLine.UnitPrice = 8000;
                } else {
                    tempOppLine.UnitPrice = pbProductPriceMap.get(productId);
                }
            } else{
                tempOppLine.UnitPrice = pbProductPriceMap.get(productId);
            }
            oppLinesToInsert.add(tempOppLine);
        }
        system.debug('oppLinesToInsert: ' + oppLinesToInsert);
        if(oppLinesToInsert.size() > 0){
            insert oppLinesToInsert;
        }
        return oppLinesToInsert;
    }

    private static void deleteOppLine(String recordId) {
        delete [SELECT Id FROM OpportunityLineItem WHERE OpportunityId =: recordId];
    }

    private static List<Pricebook2> getPriceBooks(Set<String> priceBookNamesSet) {
        return [SELECT Id, Name,Order__c, (SELECT Id, Name, Product2Id, Product2.Name, UnitPrice, Product2.Product_Type__c FROM PricebookEntries ORDER BY Product2.Name ASC) FROM Pricebook2
               WHERE Name IN: priceBookNamesSet ORDER BY Order__c ASC];
    }

    private static List<Product2> getCorePlanProducts() {
        return [SELECT Id, Name, Formatted_Product_Description__c FROM Product2 WHERE Name = 'Essential' OR Name = 'Pro' OR Name = 'Elite'];
    }

    private static Opportunity getOpportunity(String recordId) {
        return [SELECT Id, Name, Core_Plan__c, Pricebook2Id, RecordTypeId,Whitehat_Reward_Structure__c, 
        (SELECT Id, Name, Product2Id, ProductCode FROM OpportunityLineItems WHERE Product2.Name != 'Essential' AND Product2.Name != 'Elite' AND Product2.Name != 'Pro') 
        FROM Opportunity WHERE Id =: recordId];
    }

    public class CustomOption {
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}

        public CustomOption(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }

    public class InitializedResult {
        @AuraEnabled public String data {get;set;}
        @AuraEnabled public String error {get;set;}
        @AuraEnabled public List<OpportunityLineItem> oppLineItems;
    }

    public class DataResult {
        @AuraEnabled public List<customOption> paymentStructureOptions {get;set;}
        @AuraEnabled public Map<String, List<customOption>> addOnOptionsMap {get;set;} //Key = PricebookId
        @AuraEnabled public Map<String, Map<String,Decimal>> pbProductPricingMap {get;set;} //Key = PricebookId
        @AuraEnabled public Map<String, String> corePlanProducts {get;set;} //Key = Product Name
        @AuraEnabled public String oppCorePlan {get;set;}
        @AuraEnabled public String oppId {get;set;}
        @AuraEnabled public String oppPaymentStructure {get;set;}
        @AuraEnabled public Set<String> oppLinesSelected {get;set;}
        @AuraEnabled public Decimal oppPrizePool {get;set;}
        @AuraEnabled public String oppRecTypeId {get;set;}
    }

}