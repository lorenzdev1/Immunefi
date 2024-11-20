/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 10-04-2023
 * @last modified by  : julian.yong
**/
@isTest
public with sharing class IMM_TestDataFactory {
    public static String loadJSON(String staticResourceName) {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(staticResourceName);
        Test.setMock(HttpCalloutMock.class, mock);
        return (new Http()).send(new HttpRequest()).getBody();
    }

    public static Account createAccount(){
        Account acc = new Account();
        acc.Id = TriggerTestUtility.getFakeId(Account.getSObjectType());
        acc.Name = 'Test Account';
        return acc;
    }


    public static Opportunity createOpportunity(Id accId){
        Opportunity opp = new Opportunity();
        opp.Id = TriggerTestUtility.getFakeId(Opportunity.getSObjectType());
        opp.Name = 'TestOpp';
        return opp;
    }
}