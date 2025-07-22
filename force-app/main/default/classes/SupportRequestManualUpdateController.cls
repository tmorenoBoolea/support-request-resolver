/**
 * ----------------------------------------------------------------------------
 * Autor        : Tomás Moreno Alonso
 * Descripción  : Clase para recalcular manualmente la fecha de resolución
 *                desde un botón en la vista de la solicitud.
 * Fecha        : 18-07-2025
 * ----------------------------------------------------------------------------
 */
public with sharing class SupportRequestManualUpdateController {

    @AuraEnabled
    public static String recalculateDate(Id supportRequestId) {
        SupportRequest__c sr = [
            SELECT Id, Status__c, Priority__c, ExpectedResolutionDate__c
            FROM SupportRequest__c
            WHERE Id = :supportRequestId
            LIMIT 1
        ];

        if (sr.Status__c == 'Closed') {
            return 'No se puede actualizar la fecha porque la solicitud está Cerrada.';
        }

        Date newDate = SupportRequestTriggerHandler.calculateExpectedDate(Date.today(), sr.Priority__c);

        sr.ExpectedResolutionDate__c = newDate;
        update sr;

        return 'La Fecha de Resolución Esperada se actualizó correctamente a: ' + String.valueOf(newDate);
    }
}