import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import {CurrentPageReference} from 'lightning/navigation';
import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";
import OPPPORTUNITY_CORE_PLAN from '@salesforce/schema/Opportunity.Core_Plan__c';
import Boost_Product_Id from '@salesforce/label/c.Boost_Product_Id';
import Elite_Product_Id from '@salesforce/label/c.Elite_Product_Id';
import Essential_Product_Id from '@salesforce/label/c.Essential_Product_Id';
import Pro_Product_Id from '@salesforce/label/c.Pro_Product_Id';
import Attackathon_Product_Id from '@salesforce/label/c.Attackathon_Product_Id';
import Run_as_Invite_Only_Program_Product_Id from '@salesforce/label/c.Run_as_Invite_Only_Program_Product_Id';
import componentInit from '@salesforce/apex/createOppLineController.componentInit';
import sumbitRecord from '@salesforce/apex/createOppLineController.sumbitRecord';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { RefreshEvent } from 'lightning/refresh';
import { updateRecord } from 'lightning/uiRecordApi';
import { getRecordNotifyChange } from "lightning/uiRecordApi";
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';


export default class MyForm extends NavigationMixin(LightningElement){
    recordId; //Opportunity Id
    subscriptionRecordTypeId;
    pbProductPricingMap;
    corePlanOptions = [];
    corePlanProducts;
    corePlanSelected;
    showCorePlan = false;
    paymentStructureOptions = [];
    paymentStructureSelected;
    addOnOptionsMap;
    addOnOptions = [];
    addOnSelected = [];
    showAddOn = false;
    oppRecTypeId;
    showPrizePool = false;
    prizePoolValue = 0;
    isLoading = false;
    formattedProductDescription = '';
    showFormattedProductDescription = false;

    @wire(CurrentPageReference)
        getStateParameters(currentPageReference) {
            if (currentPageReference) {
                this.recordId = currentPageReference.state.recordId;
            }
        }

    @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
    objectResult({ error, data }){
        if (data) {
           let objArray  = data.recordTypeInfos;
           for (let i in objArray){
             if(objArray[i].name =="Subscription") {
                this.subscriptionRecordTypeId = objArray[i].recordTypeId;
             }
           }
        } else if (error) {
          console.log('Error: ' + JSON.stringify(error));
        }
      };

    @wire(getPicklistValues, { recordTypeId:  '$subscriptionRecordTypeId', fieldApiName: OPPPORTUNITY_CORE_PLAN })
    picklistResults({ error, data }) {
        if (data) {
          this.corePlanOptions = data.values;
        } else if (error) {
          console.log('Error: ' + JSON.stringify(error));
        }
      }

    connectedCallback() {
        this.isLoading = true;
        componentInit({recordId : this.recordId})
        //componentInit({recordId : this.recordId})
            .then(result => {
                if(result.data){
                    let data = JSON.parse(result.data);
                    console.log('result.data: ' + result.data);
                    this.paymentStructureOptions = data.paymentStructureOptions;
                    this.corePlanSelected = data.oppCorePlan;
                    this.addOnOptionsMap = data.addOnOptionsMap;
                    this.paymentStructureSelected = data.oppPaymentStructure;
                    this.addOnSelected = data.oppLinesSelected;
                    this.pbProductPricingMap = data.pbProductPricingMap;
                    this.oppRecTypeId = data.oppRecTypeId;
                    this.prizePoolValue = data.oppPrizePool;
                    this.recordId = data.oppId;
                    this.corePlanProducts = data.corePlanProducts;
                    if(this.addOnOptionsMap.hasOwnProperty(this.paymentStructureSelected)){
                        this.addOnOptions = this.addOnOptionsMap[this.paymentStructureSelected];
                        this.showAddOn = true;
                    }

                    if(this.addOnSelected.includes(Boost_Product_Id) || this.addOnSelected.includes(Attackathon_Product_Id) || this.addOnSelected.includes(Run_as_Invite_Only_Program_Product_Id)){
                        this.showPrizePool = true;
                    }
                    console.log('this.addOnSelected: ' + JSON.stringify(this.addOnSelected));
                    if(data.oppRecTypeId == this.subscriptionRecordTypeId){
                        this.showCorePlan = true;
                    }

                } else {
                    console.log('Error: ' + result.error);
                }
                this.isLoading = false;
            })
            .catch(error => {
                this.isLoading = false;
                console.log('Error: ' + JSON.stringify(error));
            });
    }

    paymentStructureChanged(event) {
        this.paymentStructureSelected = event.detail.value;
        if(this.addOnOptionsMap.hasOwnProperty(event.detail.value)){
            this.addOnOptions = this.addOnOptionsMap[event.detail.value];
            this.addOnSelected = [];
            this.showAddOn = true;
        } else {
            this.addOnOptions = [];
            this.addOnSelected = [];
            this.showAddOn = false;
        }

        if(this.addOnSelected.includes(Boost_Product_Id) || this.addOnSelected.includes(Attackathon_Product_Id) || this.addOnSelected.includes(Run_as_Invite_Only_Program_Product_Id)){
            this.showPrizePool = true;
        } else {
            this.showPrizePool = false;
            this.prizePoolValue = 0;
        }
    }

    addOnChanged(event) {
        this.addOnSelected = event.detail.value;
        if(event.detail.value.includes(Boost_Product_Id) || event.detail.value.includes(Attackathon_Product_Id) || event.detail.value.includes(Run_as_Invite_Only_Program_Product_Id)){
            this.showPrizePool = true;
        } else {
            this.showPrizePool = false;
            this.prizePoolValue = 0;
        }
    }

    corePlanChanged(event) {
        this.corePlanSelected = event.detail.value;
        this.formattedProductDescription = this.corePlanProducts?.[this.corePlanSelected];
        this.showFormattedProductDescription = true;
    }

    prizePoolChanged(event) {
        this.prizePoolValue = event.detail.value;
    }

    handleCancel() {
        RefreshEvent
        this.dispatchEvent(new RefreshEvent());
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleSubmit() {
       if(this.addOnSelected.includes(Attackathon_Product_Id) && this.prizePoolValue < 500000){
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Price pool needs to be greater than $500,000 for Attackathons',
                variant: 'error',
            });
            this.dispatchEvent(event);
       } else {
        this.isLoading = true;
        let producList = [];

        console.log('1producList: ' + JSON.stringify(producList));

        if(this.corePlanSelected == 'Essential'){
            producList.push(Essential_Product_Id);
        } else if(this.corePlanSelected == 'Pro'){
            producList.push(Pro_Product_Id);
        } else if(this.corePlanSelected == 'Elite'){
            producList.push(Elite_Product_Id);
        }

        producList = producList.concat(this.addOnSelected);

        
        /*= producList.map(item => {
            // Perform operations on each element and return the modified value
            return {recordId : item}; // For example, doubling each element
        });*/

      //  console.log('176===NotifyRecordIds: ' + JSON.stringify(NotifyRecordIds));

       sumbitRecord({productIdList : producList, 
                      pbProductPriceMap : this.pbProductPricingMap[this.paymentStructureSelected], 
                      recordId : this.recordId, 
                      oppRecTypeId : this.oppRecTypeId,
                      paymentStructureSelected : this.paymentStructureSelected, 
                      corePlanSelected : this.corePlanSelected, 
                      prizePoolValue : this.prizePoolValue})
            .then(result => {
                if(result.data){
                    console.log('result.data: ' + result.data);
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity was successfully updated!',
                        variant: 'Success',
                    });

                    this.dispatchEvent(event);
                } else {
                    console.log('Error: ' + result.error);
                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: result.error,
                        variant: 'error',
                    });
                    this.dispatchEvent(event);
                }
                this.isLoading = false;
            })
            
            .then(result => {
                console.log('*** Ready close window ' );
                eval("$A.get('e.force:refreshView').fire();"); 
                this.dispatchEvent(new CloseActionScreenEvent());
                //console.log('*** Do refresh ' );
                //console.log('*** Do refresh ', this.recordId);
                 //updateRecord({ fields: { Id: this.recordId }});
                //getRecordNotifyChange([{recordId: this.recordId}]);
                //console.log('New' );
                /*updateRecord({ fields: { Id: this.recordId }});
                 this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                     attributes: {
                         recordId: this.recordId,
                         objectApiName: 'Opportunity',
                         actionName: 'view'
                     }
                 });*/


                // console.log('Working');

            }).catch(error => {
                this.isLoading = false;
                console.log('*** Error on Submit ' );
                console.log('Error: ' + JSON.stringify(error));
            }).finally(() => {
                console.log('*** On finally' );
                //this.refreshPage();
                
            });
       }
    }

    refreshPage(){
        console.log('*** Run Refresh METHOD ' );
        setTimeout(()=>{
            console.log('*** Execute refresh ' );
            eval("$A.get('e.force:refreshView').fire();"); 
            this.dispatchEvent(new CloseActionScreenEvent());
            
    
    }
    ,3000);}

    callParent(event){
        console.log('Working');
        let paramData = {Name:this.Name, City:this.City};
        let ev = new CustomEvent('childmethod', 
                                 {detail : paramData}
                                );
            this.dispatchEvent(ev);                    
    }
}