/**
 * @description       : utility class to store all string literals for better management of string literals in the entire project
 * @author            : julian.yong
 * @group             : VASS
 * @last modified on  : 01-09-2024
 * @last modified by  : julian.yong
**/
public class IMM_Util_Constants {
    //Opportunity
    public static final String OPP_STAGENAME_HANDOVER = 'Handover';
    public static final String OPP_STAGENAME_NEGOTIATION = 'Proposal';
    public static final String OPP_STAGENAME_INREVIEW = 'In Review';
    public static final String OPP_STAGENAME_ONBOARDINGCALLBOOKED = 'Onboarding Call Booked';
    public static final String OPP_STAGENAME_ONBOARDING = 'Onboarding';
    public static final String OPP_STAGENAME_CLOSEDWON = 'Closed Won';
    public static final String OPP_STAGENAME_CLOSEDLOST= 'Closed Lost';

    //Review Process
    public static final String REVIEW_STAGENAME_APPROVEDFORLAUNCH = 'Approved for Launch';
    public static final String REVIEW_STAGENAME_COMPLETE = 'Complete';
    public static final String REVIEW_STAGENAME_FINALTECHREVIEW = 'Final Tech Review';
    public static final String REVIEW_STAGENAME_LEGALEXTERNAL = 'Legal (External)';

    //ContentVersion
    public static final String CONTENTVERSION_DOCUMENTTYPE_TELEGRAMCHAT = 'Telegram Chat' ;
    public static final String CONTENTVERSION_DOCUMENTTYPE_MSA = 'MSA' ;
    public static final String CONTENTVERSION_DOCUMENTTYPE_SIGNEDSOW = 'Signed SOW' ;
    public static final String CONTENTVERSION_DOCUMENTTYPE_APPROVEDBBPDRAFT = 'Approved BBP Draft' ;

    // Record Type
    //Review Process
    public static final String RECORDTYPE_REVIEWPROCESS_LEGALREVIEW = 	'IMM_RT_LegalReview' ;
    public static final Id RECORDTYPE_REVIEWPROCESS_LEGALREVIEWID = Schema.SObjectType.IMM_CO_ReviewProcess__c.getRecordTypeInfosByDeveloperName().get(RECORDTYPE_REVIEWPROCESS_LEGALREVIEW)?.getRecordTypeId(); 
    public static final String RECORDTYPE_REVIEWPROCESS_TECHREVIEW = 'IMM_RT_TechnicalReview' ;
    public static final Id RECORDTYPE_REVIEWPROCESS_TECHREVIEWID = Schema.SObjectType.IMM_CO_ReviewProcess__c.getRecordTypeInfosByDeveloperName().get(RECORDTYPE_REVIEWPROCESS_TECHREVIEW)?.getRecordTypeId();
    //Opportunity
    public static final String RECORDTYPE_OPPORTUNITY_BBP = 'IMM_RT_BugBountyProgram' ;
    public static final Id RECORDTYPE_OPPORTUNITY_BBPID = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(RECORDTYPE_OPPORTUNITY_BBP)?.getRecordTypeId();
    public static final String RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGE = 'IMM_RT_ManagedTriage';
    public static final Id RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGEID = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(RECORDTYPE_OPPORTUNITY_MANAGEDTRIAGE)?.getRecordTypeId();
    // Error Messages moved to Custom Labels
    // public static final String ERR01_DOCUMENTINCOMPLETE = 'Document Incomplete: Please ensure a Telegram chat document has been attached and the Document Type of the file is set to \'Telegram Chat\'' ;
    // public static final String ERR02_REVIEWSNOTAPPROVED = 'Review Process not approved: Please ensure Technical Review Status is in \'Approved For Launch\' and Legal Review status is in \'Complete\' to before advancing the opportunity to Handover status ' ;
    // public static final String ERR03_NOACCOUNTFORTHISOPPORTUNITY = 'No Account for this Opportunity. Please provide an account for this Opportunity';
    // public static final String ERR04_CANNOTCREATEMANAGEDTRIAGEWITHOUTCLOSEDWONOPP = 'Cannot create Managed Triage Opportunity without any closed won Opportunity';
    // public static final String ERR05_ACCOUNTDOESNOTHAVECLOSEDWONOPP = 'Cannot create Managed Triage Opportunity: Account does not have any closed won Opportunity';
    // public static final String ERR06_CONTACTROLESNOTCOMPLETE = 'Please add on these contact roles to proceed:';

    //Opportunity Loss reason
    public static final String LOSSREASON_OPP_CLOSUREOFBBP = 'Closure of BBP';
}