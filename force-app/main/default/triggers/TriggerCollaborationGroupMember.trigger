/********************************************************************************************************************************
* @Purpose: This is an CollaborationGroupMember Trigger 
* @Author: Ajinkya
* @CreatedDate: 11/17/2021
* @Related Code: CollaborationGroupHandler
* @LastModifiedDate:
* @LastModifiedBy:
***********************************************************************************************************************************/

trigger TriggerCollaborationGroupMember on CollaborationGroupMember (after Insert,after update,before delete,before Insert) {
  
    if( trigger.isAfter && trigger.isInsert)
    {
        Set<Id> CGM = New Set<Id>();
        for(CollaborationGroupMember obj:Trigger.new){
            CGM.add(obj.Id);
        }
        CollaborationGroupHandler.groupMember(CGM);
    } 
      //
    if( trigger.isBefore && trigger.isDelete)
    {
       // Id deleteMemberId;
      //  Id collaborationGroupMemberId;
        Set<Id> deleteMemberId = NEW Set<Id>();
         Set<Id> collaborationGroupMemberId = NEW Set<Id>();
        
        for(CollaborationGroupMember objcgm : Trigger.old)
        {
            collaborationGroupMemberId.add(objcgm.CollaborationGroupId);
            deleteMemberId.add(objcgm.MemberId);
        }
        CollaborationGroupHandler.deleteGroupMember(collaborationGroupMemberId,deleteMemberId);
    }
}