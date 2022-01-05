public class AccountQueueableEx implements Queueable{
    public List<Account> accList1;
    public AccountQueueableEx(List<Account> accList){
        this.accList1=accList;
    }
    public void execute(QueueableContext context)
    {
        for(Account acc: accList1)
        {
            acc.Name= acc.Name +'Aress';
            
        }
        update accList1;
    }
    

}