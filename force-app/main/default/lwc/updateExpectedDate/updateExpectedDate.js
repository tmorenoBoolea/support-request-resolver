import { LightningElement, api } from 'lwc';
import recalculateDate from '@salesforce/apex/SupportRequestManualUpdateController.recalculateDate';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpdateExpectedDate extends LightningElement {
    @api recordId;

    connectedCallback() {
        // Ejecutar automáticamente al cargar el componente
        if (this.recordId) {
            recalculateDate({ supportRequestId: this.recordId })
                .then(result => {
                    this.showToast('Resultado', result, 'success');
                })
                .catch(error => {
                    this.showToast('Error', error?.body?.message || 'Error inesperado', 'error');
                });
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}