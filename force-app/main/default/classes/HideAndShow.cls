public class HideAndShow
{
    public Boolean abool {get;set;}
    public Boolean bbool {get;set;}
   
    public Boolean sabool {get;set;}
    public Boolean sbbool {get;set;}
    public Boolean habool {get;set;}
    public Boolean hbbool {get;set;}
    public Boolean sabbool {get;set;}
    public Boolean habbool {get;set;}
   
    public HideAndShow()
    {
        sabool = true;
        sbbool = true;
        sabbool = true;
        abool = false;
        bbool = false;
    }
   
    public void showA()
    {
        abool = true;
        check();
    }
   
    public void showB()
    {
        bbool = true;
        check();
    }  
    
    public void hideA()
    {
        abool = false;
        check();
    }
   
    public void hideB()
    {
        bbool = false;
        check();
    }  
   
    public void showAB()
    {
        abool = true;
        bbool = true;
        check();
    }  
   
    public void hideAB()
    {
        abool = false;
        bbool = false;
        check();
    }   
   
    public void check()
    {
        if(abool == true && bbool == false)
        {
            sabool = false;
            sbbool = true;
            habool = true;
            hbbool = false;
            sabbool = true;
            habbool = false;
        }
        else if(abool == false && bbool == true)
        {
            sabool = true;
            sbbool = false;
            habool = false;
            hbbool = true;
            sabbool = true;
            habbool = false;
        }
        else if(abool == true && bbool == true)
        {
            sabool = false;
            sbbool = false;
            habool = true;
            hbbool = true;
            habbool = true;
            sabbool = false;

        }
        else
        {
            sabool = true;
            sbbool = true;
            habool = false;
            hbbool = false;
            sabbool = true;
            habbool = false;
        }
    }   
}