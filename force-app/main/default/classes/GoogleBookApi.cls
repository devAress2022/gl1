public class GoogleBookApi {
    public string BookName { get; set;}
    public List<String>book { get; set;}
    public Integer count{ get; set;}
    public Integer totleCount{ get; set;}
    public  void testinput(){
        BookName = apexpages.currentPage().getParameters().get('inpval');
        System.debug('val==='+BookName);
        count=0;  totleCount=0;
        getBooks(BookName) ;
    }
    public  void getBooks(String BookName){
        book=new List<String>();
        List<DAM01__Book__c> addBook = New List<DAM01__Book__c>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.googleapis.com/books/v1/volumes?q='+BookName);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            JSONParser parser1 = JSON.createParser(response.getBody());
            while (parser1.nextToken() != null) 
            {
                DAM01__Book__c bk =New DAM01__Book__c();
                if ((parser1.getCurrentToken() == JSONToken.FIELD_NAME) ) 
                {
                    String text = parser1.getText();
                    if (text == 'totalItems') 
                    {
                        parser1.nextToken();
                        totleCount=  Integer.valueOf(parser1.getText());   
                        system.debug('totleCount'+totleCount);
                    }
                    if (text == 'Title') 
                    {
                        parser1.nextToken();
                        book.add(parser1.getText()); 
                        count++;
                        bk.Name=parser1.getText();
                        addBook.add(bk);
                    }
                }
            }
            
            
        }
        System.debug('book'+book);
        if(addBook.size()>0){
            Insert addBook;
        }
    }
}