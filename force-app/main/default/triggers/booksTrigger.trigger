trigger booksTrigger on DAM01__Book__c (before insert) {
    
    DAM01__Book__c[] books= Trigger.new;
    //BooksClass.applyDiscount(books);

}