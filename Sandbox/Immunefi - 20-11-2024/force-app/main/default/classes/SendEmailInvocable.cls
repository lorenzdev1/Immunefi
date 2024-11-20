public without sharing class SendEmailInvocable {
    
    /*
* invocable method
*/
    @InvocableMethod
    public static List<Results> execute(List<Requests> requestList) {
        System.debug('requestList :::' + requestList);
        System.debug('size :::' + requestList.size());
        if(requestList.size() > 0){
            List<Results> results = new List<Results>();
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            
            List<Id> leadIds = new List<Id>();
            for (Requests req : requestList) {
                leadIds.add(req.targetRecordId);
            }
            System.debug('leadIds :::' + leadIds);
            
            Map<Id, Id> leadOwaMap = getLeadOwnerOrgWide(leadIds);
            System.debug('leadOwaMap :::' + leadOwaMap);
            
            for (Requests request : requestList) {
                Messaging.SingleEmailMessage email = collectEmail(
                    request.emailTemplateId, 
                    request.recipientEmail,
                    request.targetRecordId,
                    leadOwaMap.get(request.targetRecordId)
                );
                allmsg.add( email );
            }
            System.debug('allmsg :::' + allmsg);
            System.debug('size :::' + allmsg.size());
            
            if ( allmsg.size() > 0 ) {
                try {
                    System.debug('*** enter try :::');
                    List<Messaging.SendEmailResult> result = Messaging.sendEmail(allmsg);
                    System.debug('*** SendEmailResult '+ result);
                    System.debug('*** result '+ result.size());
                    for (Messaging.SendEmailResult r : result) {
                        
                        Results res = new Results();
                        if (r.success) {
                            res.isSuccess = true;
                        } else {
                            res.isSuccess = false;
                        }
                        results.add(res);
                    }
                    
                } catch (Exception e) {
                    System.debug('email exception:::' + e);
                }
            }
            System.debug('*** results '+ results);
            System.debug('*** results size '+ results.size());
            return results;
        }else{
            return null;
        }
        
    }
    
    private static Messaging.SingleEmailMessage collectEmail( String emailTemplateId, String email, String targetObjectId, String orgWideId ) {
        
        List<string> toAddress = new List<string>();
        toAddress.add(email);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(emailTemplateId);
        mail.setToAddresses(toAddress);
        mail.setTargetObjectId(targetObjectId);
        mail.setSaveAsActivity(true); 
        
        if (orgWideId != null) {
            mail.setOrgWideEmailAddressId(orgWideId);
        }
        
        return mail;
    }
    
    private static Map<Id, Id> getLeadOwnerOrgWide( List<Id> leadId ) {
        
        Map<Id, Id> leadOwnerMap = new Map<Id, Id>();
        for (Lead leads : [SELECT Id, OwnerId FROM Lead WHERE Id IN : leadId]) {
            leadOwnerMap.put( leads.OwnerId, leads.Id );
        }
        
        Map<String, Id> userMap = new Map<String, Id>();
        for (User users : [SELECT Id, Email FROM User WHERE Id IN : leadOwnerMap.keySet()]) {
            userMap.put( users.Email, users.Id);
        }
        
        Map<Id, Id> leadOrgWideMap = new Map<Id, Id>();
        for (OrgWideEmailAddress owa : [SELECT Id, Address 
                                        FROM OrgWideEmailAddress
                                        WHERE Address IN : userMap.keySet() AND IsVerified = TRUE]) 
        {
            Id ownerId = userMap.get(owa.Address);
            if (ownerId != null) {
                Id leadIdData = leadOwnerMap.get(ownerId);
                if (leadIdData != null) {
                    leadOrgWideMap.put(leadIdData, owa.Id);
                }
            }
        }
        
        return leadOrgWideMap;
    }
    
    public class Requests {
        @InvocableVariable(label='Email Template' description='' required=true)
        public String emailTemplateId;
        
        @InvocableVariable(label='Recipient email' description='' required=true)
        public String recipientEmail;
        
        @InvocableVariable(label='Lead record id' description='' required=true)
        public String targetRecordId;
    }
    
    public class Results {
        @InvocableVariable(label='Send mail outcome' description='true/false')
        public Boolean isSuccess; 
    }
}