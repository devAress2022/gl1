trigger case_email on Case (before insert) {
    
    for(case c:Trigger.new)
    {
       if(c.Subject=='test'||c.Subject=='free'||c.Subject=='offer'||c.Subject=='test2'||c.Subject=='test3'||c.Subject=='test4') 
       {
           c.Subject.addError('Spam');
       }
        else{
            
            
        }
    }
    
    

}