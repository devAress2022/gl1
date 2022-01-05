import { LightningElement ,api, wire, track} from 'lwc';
import getAccountList from '@salesforce/apex/AccountHelper.getAccountList';
import getContactList from '@salesforce/apex/AccountHelper.getContactList';
import { createRecord } from 'lightning/uiRecordApi';
export default class LightningDatatableLWCExample extends LightningElement {
    strName;
    strAccountNumber;
    strPhone;
    //contact
    stcConrName;
    strConAccountNumber;
    strConPhone;
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
    @wire(getContactList)
    wiredContacts({
        error,
        data
    }) {
        if (data) {
            this.conList = data;
        } else if (error) {
            this.error = error;
        }
    }
    // Change Handlers.
    nameChangedHandler(event){
        this.strName = event.target.value;
    }
    numberChangedHandler(event){
        this.strAccountNumber = event.target.value;
    }
    phoneChangedHandler(event){
        this.strPhone = event.target.value;
    }

    // Insert record.
    createAccount(){

        // Creating mapping of fields of Account with values
        var fields = {'Name' : this.strName, 'AccountNumber' : this.strAccountNumber, 'Phone' : this.strPhone};

        // Record details to pass to create method with api name of Object.
        var objRecordInput = {'apiName' : 'Account', fields};

        // LDS method to create record.
        createRecord(objRecordInput).then(response => {
            alert('Account created with Id: ' +response.id);
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
        
       
        
        
    
    }
    //CreateContact 
     // Change Handlers.
     contactnameChangedHandler(event){
        this.strName = event.target.value;
    }
    contactnumberChangedHandler(event){
        this.strAccountNumber = event.target.value;
    }
    contactphoneChangedHandler(event){
        this.strPhone = event.target.value;
    }

    // Insert record.
    createContact(){

        // Creating mapping of fields of Account with values
        var fields = {'Name' : this.strName, 'AccountNumber' : this.strAccountNumber, 'Phone' : this.strPhone};

        // Record details to pass to create method with api name of Object.
        var objRecordInput = {'apiName' : 'Account', fields};

        // LDS method to create record.
        createRecord(objRecordInput).then(response => {
            alert('Account created with Id: ' +response.id);
        }).catch(error => {
            alert('Error: ' +JSON.stringify(error));
        });
        
       
        
        
    
    }
    @track columns = [{
            label: 'Account name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Type',
            fieldName: 'Type',
            type: 'text',
            sortable: true
        },
        {
            label: 'Annual Revenue',
            fieldName: 'AnnualRevenue',
            type: 'Currency',
            sortable: true
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone',
            sortable: true
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'url',
            sortable: true
        },
        {
            label: 'Rating',
            fieldName: 'Rating',
            type: 'test',
            sortable: true
        }
    ];

    @track columnscon = [{
        label: 'Contact name',
        fieldName: 'Name',
        type: 'text',
        sortable: true
    },
    {
        label: 'Account Name',
        fieldName: 'Type',
        type: 'text',
        sortable: true
    },
    {
        label: 'Title',
        fieldName: 'AnnualRevenue',
        type: 'Currency',
        sortable: true
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        sortable: true
    },
    {
        label: 'Email',
        fieldName: 'Website',
        type: 'url',
        sortable: true
    }
];
@track isModalOpen = false;
openModal() {
    // to open modal set isModalOpen tarck value as true
    this.isModalOpen = true;
}
closeModal() {
    // to close modal set isModalOpen tarck value as false
    this.isModalOpen = false;
}
submitDetails() {
    // to close modal set isModalOpen tarck value as false
    //Add your code to call apex method or do some processing
    this.isModalOpen = false;
}

@track isContact = false;
openContactModal() {
    
    this.isContact = true;
}
closeContactModal() {
    
    this.isContact = false;
}
submitContactDetails() {
    
    this.isContact = false;
}
   
}