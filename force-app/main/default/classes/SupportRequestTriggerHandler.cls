/**
 * ----------------------------------------------------------------------------
 * Autor        : Tomás Moreno Alonso
 * Descripción  : Clase handler que gestiona la lógica de cálculo de 
 *                ExpectedResolutionDate__c en función de la prioridad y del estado.
 *                Se utiliza desde triggers y procesos automáticos.
 * Fecha        : 18-07-2025
 * ----------------------------------------------------------------------------
 */
public class SupportRequestTriggerHandler {

    public static void handleBefore(List<SupportRequest__c> newList, Map<Id, SupportRequest__c> oldMap) {
        Date today = Date.today();
        for (SupportRequest__c sr : newList) {
            Boolean isInsert = true;
            if (oldMap != null) {
                isInsert = false;
            }
            SupportRequest__c oldSR = isInsert ? null : oldMap.get(sr.Id);

            Boolean setByInsert = isInsert;
            Boolean changedToManage = !isInsert && sr.Status__c == 'ToManage' && oldSR.Status__c != 'ToManage';

            if (setByInsert || changedToManage) {
                sr.ExpectedResolutionDate__c = calculateExpectedDate(Date.today(), sr.Priority__c);
            }
        }
    }

    public static Date calculateExpectedDate(Date start, String priority) {
        Integer daysToAdd;
        if (priority == 'High') {
            daysToAdd = 1;
        } else if (priority == 'Medium') {
            daysToAdd = 3;
        } else {
            daysToAdd = 5;
        }
        return addBusinessDays(start, daysToAdd);
    }

    private static Date addBusinessDays(Date startDate, Integer businessDays) {
        Integer addedDays = 0;
        Date resultDate = startDate;
        while (addedDays < businessDays) {
            resultDate = resultDate.addDays(1);
            if (resultDate.toStartOfWeek().addDays(5) > resultDate) {
                addedDays++;
            }
        }
        return resultDate;
    }
}