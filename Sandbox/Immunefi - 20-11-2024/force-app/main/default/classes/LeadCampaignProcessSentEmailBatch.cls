global class LeadCampaignProcessSentEmailBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        String queryStr = 'SELECT Id, Status__c, Lead__c, Email_template__c, Lead__r.Email FROM Lead_Campaign_Process__c WHERE Status__c = \'Pending\' AND Lead__c != null AND Email_template__c != null AND Send_Date__c <= TODAY';
        return Database.getQueryLocator(queryStr);
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope){
        // process each batch of records
        if(!scope.isEmpty()) {
            
            List<Lead_Campaign_Process__c> lcpToUpdate = new List<Lead_Campaign_Process__c>();
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            Map<Integer, Lead_Campaign_Process__c> lcpMap = new Map<Integer, Lead_Campaign_Process__c>();
            Set<String> emailTemplateNameSet = new Set<String>();
            Set<Id> leadIdSet = new Set<Id>();
            Integer ctr = 0;

            for(Lead_Campaign_Process__c lcp : (List<Lead_Campaign_Process__c>) scope) {
                
                leadIdSet.add(lcp.Lead__c);
                if(String.isNotBlank(lcp.Email_template__c)) {
                    emailTemplateNameSet.add(lcp.Email_template__c);
                }
            }

            Map<String, String> etMap = emailTemplateMap(emailTemplateNameSet);
            Map<Id, Id> leadOwnerMap = new Map<Id, Id>();
            for (Lead leads : [SELECT Id, OwnerId FROM Lead WHERE Id IN : leadIdSet]) {
                leadOwnerMap.put( leads.OwnerId, leads.Id );
            }
    
            Map<String, Id> userMap = new Map<String, Id>();
            for (User users : [SELECT Id, Email FROM User WHERE Id IN : leadOwnerMap.keySet()]) {
                userMap.put( users.Email, users.Id);
            }
    
            Map<Id, Id> leadOwaMap = new Map<Id, Id>();
            for (OrgWideEmailAddress owa : [SELECT Id, Address 
                                            FROM OrgWideEmailAddress
                                            WHERE Address IN : userMap.keySet() AND IsVerified = true]){
                Id ownerId = userMap?.get(owa.Address);
                if (ownerId != null) {
                    Id leadIdData = leadOwnerMap.get(ownerId);
                    if (leadIdData != null) {
                        leadOwaMap.put(leadIdData, owa.Id);
                    }
                }
            }

            List<Lead_Campaign_Process__c> toUpdateLCP = new List<Lead_Campaign_Process__c> ();
            for(Lead_Campaign_Process__c lcp : (List<Lead_Campaign_Process__c>) scope) {

                if (!leadOwaMap.isEmpty() && leadOwaMap.containsKey(lcp.Lead__c) ) {
                    String emailTemplateId = !etMap.isEmpty() && etMap.containsKey(lcp.Email_template__c) ? etMap.get(lcp.Email_template__c) : '';

                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTemplateId(emailTemplateId);
                    mail.setToAddresses(new List<String> {lcp.Lead__r.Email});
                    mail.setTargetObjectId(lcp.Lead__c);
                    mail.setSaveAsActivity(true);
                    mail.setOrgWideEmailAddressId(leadOwaMap.get(lcp.Lead__c));
                    allmsg.add(mail);
                    lcpMap.put(ctr, lcp);
                    ctr++;
                } else {
                    toUpdateLCP.add(new Lead_Campaign_Process__c(
                        Id = lcp.Id,
                        //Status__c = 'Pending',
                        Unable_to_Send_email__c = true,
                        Email_Error__c = 'Unable to find related Org Wide EmailAddress'
                    ));
                }
            }

            if (allmsg.size() > 0) {
                try {
                    List<Messaging.SendEmailResult> result = Messaging.sendEmail(allmsg, false);
                    lcpToUpdate = updateLcpSentEmails(result, lcpMap, toUpdateLCP);
                    if(!lcpToUpdate.isEmpty()) {
                        Database.update(lcpToUpdate, false);
                    }
                } 
                catch (Exception e) {
                    System.debug('email exception:::' + e);
                }
            }
        }
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    

    private static List<Lead_Campaign_Process__c> updateLcpSentEmails(List<Messaging.SendEmailResult> result, Map<Integer, Lead_Campaign_Process__c> lcpMap, List<Lead_Campaign_Process__c> toUpdateLCP) {

        for (Integer i = 0; i < result.size(); i++) {
            if(result.get(i).success) {
                if(!lcpMap.isEmpty() && lcpMap.containsKey(i)) {
                    lcpMap.get(i).Status__c = 'Sent';
                    lcpMap.get(i).Unable_to_Send_email__c = false;
                    toUpdateLCP.add(lcpMap.get(i));
                }
            } else {
                System.debug('*** error ' + result.get(i).getErrors());
                lcpMap.get(i).Unable_to_Send_email__c = true;
                lcpMap.get(i).Email_Error__c = String.valueOf(result.get(i).getErrors());
                //lcpMap.get(i).Status__c = 'Pending';
                toUpdateLCP.add(lcpMap.get(i));
            }
        }
        return toUpdateLCP;
    }

    private static Map<String, String> emailTemplateMap(Set<String> emailTemplateNameSet) {
        
        Map<String, String> templateMap = new Map<String, String>();

        for(EmailTemplate et : [SELECT Id, DeveloperName FROM EmailTemplate WHERE DeveloperName IN : emailTemplateNameSet]) {
            templateMap.put(et.DeveloperName, et.Id);
        }

        return templateMap;
    }
}