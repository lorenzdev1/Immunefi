/**
 * @description       : 
 * @author            : julian.yong
 * @group             : 
 * @last modified on  : 01-05-2024
 * @last modified by  : julian.yong
**/
trigger LeadTrigger on Lead (before insert,
after insert,
before update,
after update,
before delete,
after delete,
after undelete) {
    new MetadataTriggerHandler().run();
}