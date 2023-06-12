/**
 * Created by petrroubal on 11.06.2023.
 */

@IsTest
private class CountryLayerScheduler_Test {
    @IsTest
    static void testSchedule() {

        Test.setMock(HttpCalloutMock.class, new MockSuccess());
        Test.startTest();
        String sch = '0 0 0 3 9 ?';
        String jobId = System.schedule('CountryLayerSchedulerTest', sch, new CountryLayerScheduler());
        Test.stopTest();

        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

        System.assertEquals(sch, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals(9, ct.NextFireTime.month());
    }

    public class MockSuccess implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {

            HTTPResponse res = new HTTPResponse();
            res.setBody(CountryLayer2Apex_Test.JSON_RESPONSE);
            res.setStatusCode(200);
            return res;

        }
    }
}