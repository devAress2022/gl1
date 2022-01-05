/********************************************************************************************************************************
* @Purpose: This is an CollaborationGroupMember Trigger 
* @Author: Ajinkya
* @CreatedDate: 11/17/2021
* @Related Code: CollaborationGroupHandler
* @LastModifiedDate:
* @LastModifiedBy:
***********************************************************************************************************************************/
trigger TriggerCollaborationGroup on CollaborationGroup (Before insert,After Insert) {
    
    if( trigger.isbefore && trigger.isinsert)
    {
        List<Group> lstGroup =[SELECT  Id,Name FROM Group];
        List<Group> lstNewGroup = New List<Group>();
        List<string> allGroup = New List<String>();
        for(Group objGroup :lstGroup)
        {
            if(objGroup!=Null)
            {
                allGroup.add(objGroup.Name);
            }
        }
        
        for(CollaborationGroup objCollabGroup: trigger.new)
        {
            if(!allGroup.contains(String.valueof(objCollabGroup.Name)))
            {  
                Group newGroup = New Group();
                newGroup.Name =objCollabGroup.Name;
                lstNewGroup.add(newGroup);
                
            }
            
        }
        
        Upsert lstNewGroup;
    }
    
    if( trigger.isAfter && trigger.isInsert)
    {
        Id CollaborationGroupId;
        for(CollaborationGroup objCollabGroup :Trigger.New)
        {
            CollaborationGroupId =objCollabGroup.Id;
        }
        CollaborationGroupHandler.groupMember(CollaborationGroupId);
    }
    
}