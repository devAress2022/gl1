/********************************************************************************************************************************
* @Purpose: This is an CollaborationGroupMember Trigger 
* @Author: Ajinkya
* @CreatedDate: 11/17/2021
* @Related Code: CollaborationGroupHandler
* @LastModifiedDate:
* @LastModifiedBy:
***********************************************************************************************************************************/

public class CollaborationGroupHandler {
   /* @future(callout=true)
    public static void groupMember(Set<Id> Ids)
    {
        System.debug('Ids-'+Ids);
        List<CollaborationGroupMember> lstCollaborationGroup =[SELECT Id, CollaborationGroup.Name, MemberId 
                                                               FROM CollaborationGroupMember
                                                               WHERE ID IN: Ids];
                System.debug('lstCollaborationGroup-'+lstCollaborationGroup);

        Set<String> groupNames =New Set<String>();
        List<GroupMember> addGroupMember = new List<GroupMember>();
         Set<Id> groupMemberIds =New Set<Id>();
        Set<Id> existmembers = New Set<Id>();
        Map<String,Id> mapa = New Map<String,Id>();
        for(CollaborationGroupMember objCGM : lstCollaborationGroup)
        {
            groupNames.add(objCGM.CollaborationGroup.Name);
            groupMemberIds.add(objCGM.MemberId);
        }
        List<Group> lstGroup =[Select Id,Name From Group Where Name IN: groupNames];
        map<Id,Group> mapGroup = new map<Id,Group>(lstGroup);
        for(Group objgruop:lstGroup){
            
            mapa.put(objgruop.Name,objgruop.Id);
        }
        for(CollaborationGroupMember objCGM :lstCollaborationGroup){
            
            GroupMember newGroupMember = new GroupMember();
            newGroupMember.GroupId =mapa.get(objCGM.CollaborationGroup.Name) ;
            newGroupMember.UserOrGroupId = objCGM.MemberId;
            addGroupMember.add(newGroupMember);    
            
            
        }
        if(addGroupMember.size()>0){
            insert addGroupMember;
        }
     }
    
    @future(callout=true)
    Public static void deleteGroupMember(Set<Id> Ids,Set<Id> Ids1)
    {
        List<GroupMember> lstGroupMember = new List<GroupMember>();
        
        List<CollaborationGroup> objCollabGroup  =New  List<CollaborationGroup>();       
        if(Ids!= Null)
        {
            objCollabGroup =[Select Id,Name FROM CollaborationGroup WHERE Id IN: Ids];
            
        }
        
        List<CollaborationGroupMember> lstCollabGroupMember = [SELECT CollaborationGroupId, Id, MemberId, CollaborationRole 
                                                               FROM CollaborationGroupMember                                                               where CollaborationGroupId IN:Ids];
        if(Ids != Null)
        {
            objCollabGroup =[Select Id,Name FROM CollaborationGroup WHERE Id IN:Ids];
            
        }
        
        Group objGroup =New Group();
        if(objCollabGroup != Null)
        {
            objGroup = [Select Id,Name From Group Where Name=:objCollabGroup[0].Name];
        }
        List<GroupMember> deleteGroupMemberList=new List<GroupMember>();
        GroupMember deleteGroupMember = [SELECT Id, GroupId, UserOrGroupId FROM GroupMember WHERE GroupId=: objGroup.Id AND UserOrGroupId IN:Ids1];
       // System.debug('deleteGroupMember=='+);
        deleteGroupMemberList.add(deleteGroupMember);
        delete deleteGroupMemberList;
        
    }
    */
}