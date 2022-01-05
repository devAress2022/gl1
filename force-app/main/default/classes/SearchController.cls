public with sharing class SearchController {
   
    @AuraEnabled
    public static List<product2>  retriveProduct(String strProdName){
        strProdName ='%'+strProdName+'%';
        List<product2> lstProd =[Select Id,Name,ProductCode From product2 Where Name LIKE :strProdName];
        return lstProd;
        
    }
}