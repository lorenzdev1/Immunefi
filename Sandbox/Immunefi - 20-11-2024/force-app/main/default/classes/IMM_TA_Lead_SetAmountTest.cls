/**
 * @description       : Test Class for IMM_TA_Lead_SetAmount
 * @author            : Jahnavi Manne
 * @group             : 
 * @last modified on  : 01-05-2024
 * @last modified by  : julian.yong
**/
@IsTest
public class IMM_TA_Lead_SetAmountTest {

   @IsTest
    static void testOpportunityAmount(){
        
        List<Lead> newList = new List<Lead>();
        String jsonString = IMM_TestDataFactory.loadJSON('IMM_TA_Lead_SetAmountTest');
        newList = (List<Lead>)JSON.deserialize(jsonString, List<Lead>.class);
        Test.startTest();
        IMM_TA_Lead_SetAmount.afterUpdate(newlist, new List<Lead>());
        Test.stopTest();
        Assert.areEqual(1, IMM_TA_Lead_SetAmount.testResults.size(), 'testOpportunityAmount failed: No item in update');
        Assert.areEqual(1000, IMM_TA_Lead_SetAmount.testResults[0].Amount,'testOpportunityAmount failed: amount is not expected');

    }
}