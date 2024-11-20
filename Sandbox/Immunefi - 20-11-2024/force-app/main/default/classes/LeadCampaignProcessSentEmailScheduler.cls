global class LeadCampaignProcessSentEmailScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new LeadCampaignProcessSentEmailBatch(new List<String>()));
    }
}