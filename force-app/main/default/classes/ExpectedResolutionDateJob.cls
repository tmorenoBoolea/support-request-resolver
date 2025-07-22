/**
 * ----------------------------------------------------------------------------
 * Autor        : Tomás Moreno Alonso
 * Descripción  : Clase Scheduled Apex que recalcula la fecha de resolución
 *                esperada para registros SupportRequest__c activos (no cerrados).
 *                Se ejecuta diariamente para mantener actualizadas las fechas.
 * Fecha        : 18-07-2025
 * ----------------------------------------------------------------------------
 */
global class ExpectedResolutionDateJob implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<SupportRequest__c> toUpdate = [
            SELECT Id, Priority__c, Status__c
            FROM SupportRequest__c
            WHERE Status__c IN ('PendingInternal', 'PendingCustomer')
        ];

        Date today = Date.today();

        for (SupportRequest__c sr : toUpdate) {
            sr.ExpectedResolutionDate__c = SupportRequestTriggerHandler.calculateExpectedDate(today, sr.Priority__c);
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}