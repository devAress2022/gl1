public class BooksClass {
    public static void applyDiscount(DAM01__Book__c[] books){
        for(DAM01__Book__c b :books){
            b.DAM01__Price__c *=0.9;
        }
        
    }

}