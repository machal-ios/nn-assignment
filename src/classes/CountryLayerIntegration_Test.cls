/**
 * Created by petrroubal on 11.06.2023.
 */

@IsTest
private class CountryLayerIntegration_Test {

    public class MockSuccess implements HttpCalloutMock {

        public HTTPResponse respond(HTTPRequest req) {

            HTTPResponse res = new HTTPResponse();
            res.setBody(CountryLayer2Apex_Test.JSON_RESPONSE);
            res.setStatusCode(200);
            return res;

        }
    }

    @IsTest
    private static void testIntegrationSuccess() {

        Test.setMock(HttpCalloutMock.class, new MockSuccess());
        Test.startTest();
        Boolean error = false;
            try {
                CountryLayerBatch clb = new CountryLayerBatch();
                database.executeBatch(clb);
            } catch (Exception ex){
                error = true;
            }
        Test.stopTest();
        System.assertEquals(false, error);
        List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];
        System.assertEquals(1, countryLayers.size(), 'There should be 1 CountryLayer!');
    }

    @IsTest
    private static void testIntegrationSuccessWithData() {

        CountryLayer__c countryLayer = new CountryLayer__c(
        Alpha2Code__c = 'DE',
        Alpha3Code__c = 'DEU',
        CapitalCity__c = 'Berlin',
        CountryName__c = 'Germany',
        Region__c = 'Europe',
        RegionalBlocs_Acronyms__c = '');

        Insert countryLayer;


        Test.setMock(HttpCalloutMock.class, new MockSuccess());
        Test.startTest();
        Boolean error = false;
        try {
            CountryLayerBatch clb = new CountryLayerBatch();
            database.executeBatch(clb);
        } catch (Exception ex){
            error = true;
        }
        Test.stopTest();
        System.assertEquals(false, error);
        List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];
        System.assertEquals(1, countryLayers.size(), 'There should be 1 CountryLayer!');
        System.assertEquals('EU', countryLayers[0].RegionalBlocs_Acronyms__c, 'There should be propagated RegionalBlocs_Acronyms__c!');
    }
}