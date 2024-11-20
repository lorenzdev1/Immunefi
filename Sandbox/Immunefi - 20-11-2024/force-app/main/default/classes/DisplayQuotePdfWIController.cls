/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class DisplayQuotePdfWIController {

    public ProcessInstanceWorkitem approvalWorkItem {get; set;}
    public String pdfBlobStr {get; set;}
    
	public DisplayQuotePdfWIController(ApexPages.StandardController stdController) {
        if(!Test.isRunningTest()) {
            stdController.addFields(new List<String>{
                'ProcessInstanceId'
            });
        }
        approvalWorkItem = (ProcessInstanceWorkitem) stdController.getRecord();
        
        String quoteId = [SELECT Id, TargetObjectId FROM ProcessInstance 
                          WHERE Id =: approvalWorkItem.ProcessInstanceId LIMIT 1]?.TargetObjectId;
        
        if(String.isNotBlank(quoteId) && quoteId.startsWith('0Q0')) {
			QuoteDocument quoteDoc = [SELECT Id, Name, ContentVersionDocumentId, QuoteId FROM QuoteDocument 
                                      WHERE QuoteId =: quoteId ORDER BY CreatedDate DESC LIMIT 1];
            
            ContentVersion cv = [SELECT Id, VersionData FROM ContentVersion WHERE Id =: quoteDoc.ContentVersionDocumentId
                                AND IsLatest = true LIMIT 1];
            pdfBlobStr = EncodingUtil.base64Encode(cv.VersionData);
        }
    }
}