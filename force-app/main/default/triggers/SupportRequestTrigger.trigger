/**
 * ----------------------------------------------------------------------------
 * Autor        : Tomás Moreno Alonso
 * Descripción  : Trigger sobre SupportRequest__c que actualiza la fecha de 
 *                resolución esperada al crear o cambiar estado.
 * Fecha        : 18-07-2025
 * ----------------------------------------------------------------------------
 */
trigger SupportRequestTrigger on SupportRequest__c (before insert, before update) {
    if (Trigger.isBefore) {
        SupportRequestTriggerHandler.handleBefore(Trigger.new, Trigger.oldMap);
    }
}