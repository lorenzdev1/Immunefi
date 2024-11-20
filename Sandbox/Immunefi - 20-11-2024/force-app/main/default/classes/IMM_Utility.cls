/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 12-22-2023
 * @last modified by  : julian.yong
**/
public class IMM_Utility {
    private static Set<String> validateOppConRoleMdts;
    public static Set<String> getValidateOppConRoles(){
    if (validateOppConRoleMdts == null) {
        validateOppConRoleMdts = new Set<String>();
        List<IMM_CMT_ValidateOppConRole__mdt> expectedOppContactRolesMdt = IMM_CMT_ValidateOppConRole__mdt.getAll().values();
        for (IMM_CMT_ValidateOppConRole__mdt conRole : expectedOppContactRolesMdt) {     
            if (conRole.IMM_CB_isActive__c) {
                validateOppConRoleMdts.add(conRole.IMM_TF_OppContactRole__c);
            }  
        }
    }
    return validateOppConRoleMdts;
   }
}