/**
 * ----------------------------------------------------------------------------
 * Autor        : Tomás Moreno Alonso
 * Descripción  : Clase de pruebas unitarias que valida el comportamiento del
 *                trigger y la lógica de cálculo de ExpectedResolutionDate__c.
 *                Cubre los casos de inserción, cambio de estado y ejecución del job programado.
 * Fecha        : 18-07-2025
 * ----------------------------------------------------------------------------
 */
@isTest
private class SupportRequestTriggerHandlerTest {
    @isTest
    static void testInsertHighPriority() {
        SupportRequest__c sr = new SupportRequest__c(
            Priority__c = 'High',
            Status__c = 'ToManage'
        );
        insert sr;

        SupportRequest__c inserted = [SELECT ExpectedResolutionDate__c FROM SupportRequest__c WHERE Id = :sr.Id];
        System.assertEquals(
            SupportRequestTriggerHandler.calculateExpectedDate(Date.today(), 'High'),
            inserted.ExpectedResolutionDate__c
        );
    }

    @isTest
    static void testChangeToToManage() {
        SupportRequest__c sr = new SupportRequest__c(Priority__c = 'Medium', Status__c = 'InProcess');
        insert sr;

        sr.Status__c = 'ToManage';
        update sr;

        sr = [SELECT ExpectedResolutionDate__c FROM SupportRequest__c WHERE Id = :sr.Id];
        System.assertEquals(
            SupportRequestTriggerHandler.calculateExpectedDate(Date.today(), 'Medium'),
            sr.ExpectedResolutionDate__c
        );
    }

    @isTest
    static void testScheduledJob() {
        List<SupportRequest__c> listSR = new List<SupportRequest__c>();
        for (Integer i = 0; i < 3; i++) {
            listSR.add(new SupportRequest__c(Priority__c = 'Medium', Status__c = 'InProcess'));
        }
        insert listSR;

        Test.startTest();
        ExpectedResolutionDateJob job = new ExpectedResolutionDateJob();
        job.execute(null);
        Test.stopTest();

        for (SupportRequest__c sr : [SELECT ExpectedResolutionDate__c FROM SupportRequest__c]) {
            System.assertEquals(
                SupportRequestTriggerHandler.calculateExpectedDate(Date.today(), 'Medium'),
                sr.ExpectedResolutionDate__c
            );
        }
    }
}