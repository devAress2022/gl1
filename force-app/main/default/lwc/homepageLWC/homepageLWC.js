import { LightningElement,wire,track,api } from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';

export default class HomepageLWC extends LightningElement {

    @track error;
    @track accList ;
    @wire(getAccountList)
    wiredAccounts({
        error,
        data
    }) {
        if (data) {
            this.accList = data;
        } else if (error) {
            this.error = error;
        }
    }
    @track columns1 = [{
        label: 'Account name',
        fieldName: 'Name',
        type: 'text'
       
    }
];

}