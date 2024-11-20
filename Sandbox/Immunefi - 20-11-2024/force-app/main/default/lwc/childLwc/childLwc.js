import { LightningElement, api } from 'lwc';
export default class ChildLwc extends LightningElement {
    Name;
    City;
 
    handleName(event){
        this.Name = event.detail.value;
    }
 
    handleCity(event){
        this.City = event.detail.value;
    }
 
    callParent(event){
        let paramData = {Name:this.Name, City:this.City};//JSON.parse({Name:this.Name, City:this.City});
        let ev = new CustomEvent('childmethod', 
                                 {detail : paramData}
                                );
            this.dispatchEvent(ev);                    
    }
}