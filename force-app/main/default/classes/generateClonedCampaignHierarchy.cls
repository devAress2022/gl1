public class generateClonedCampaignHierarchy {
 
    @AuraEnabled
    public static void generateCampaignHierarchy(Id recordId) {
        Set<Id> campaignIds = new Set<Id>{recordId};
        // Use recursion to get the full tree of Ids of Campaigns
        campaignIds.addAll(getCampaignHierarchy(campaignIds));
 
        // Generate a list of the original campaigns we want to clone
        List<Campaign> origCampaigns = [SELECT Id, Name, ParentId FROM Campaign WHERE Id IN :campaignIds];
 
        Map<Id, Campaign> oldCampaignToNewCampaignMap = new Map<Id, Campaign>();
        for (Campaign camp : origCampaigns) {
            // Second paramter of clone to true to generate a copy of the record but not the Id
            Campaign newCamp = camp.clone(false, true, false, false);
            oldCampaignToNewCampaignMap.put(camp.Id, newCamp);
        }
 
        try {
            insert oldCampaignToNewCampaignMap.values();
        } catch (exception ex) {
            System.debug('The insert of the records has failed! Please see message for more info: '  + ex.getMessage());
        }
         
        // From the map values, loop over them and check to see if the parent Id contains the old Id stored in the map. If so, reassign the recoords parent id to its new record valuee
        List<Campaign> campaignsToUpdate = new List<Campaign>();
        for (Campaign c : oldCampaignToNewCampaignMap.values()) {
            if (oldCampaignToNewCampaignMap.get(c.ParentId) != null) {
                // Reparent the new records using the map previously created
                c.ParentId = oldCampaignToNewCampaignMap.get(c.ParentId).Id;
            }
            // Add any other changes you want to the new campaign records. Ex:
            if (c.Name.contains('Parent')) {
                c.Name = 'Other Parent';
            }
            campaignsToUpdate.add(c);
        }
 
        try {
            update campaignsToUpdate;
        } catch (exception ex) {
            System.debug('The update of the records has failed! Please see message for more info: '  + ex.getMessage());
        }
    }
 
    public static Set<Id> getCampaignHierarchy(Set<Id> campaignIds) {
         
        Set<ID> campIds = new Set<ID>();
        // Query for all of the campaigns that contain the parent ids passed in from the argument
        for (Campaign camp :[SELECT Id FROM Campaign where ParentId IN :campaignIds AND ParentId != null]) {
            campIds.add(camp.Id);
        }
 
        // if the set isnt empty after we query, re-enter the methood invocation and recursively call it until its empty
        if(!campIds.isEmpty()) {
            campIds.addAll(getCampaignHierarchy(campIds));
        }
        return campIds;
    }
}