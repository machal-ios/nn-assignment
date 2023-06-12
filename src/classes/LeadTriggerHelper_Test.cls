/**
 * Created by petrroubal on 11.06.2023.
 */

@IsTest
private with sharing class LeadTriggerHelper_Test {

    @TestSetup
    private static void prepareCountryLayerData(){
        CountryLayer__c countryLayer = new CountryLayer__c(
            Alpha2Code__c = 'CZ',
            Alpha3Code__c = 'CZE',
            CapitalCity__c = 'Prague',
            CountryName__c = 'Czech Republic',
            Region__c = 'Europe',
            RegionalBlocs_Acronyms__c = '');

        Insert countryLayer;
    }


    /**
     * @description bulk test for inserting 200 Leads
     */
    @IsTest
    private static void bulkTestInsertingLeads() {

        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Name ' + i, LastName = 'LastName ' + i, Company = 'Company ' + i, Country = 'Czech Republic'));
        }

        insert leads;

        List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];
        System.assertEquals(1, countryLayers.size(), 'There should be 1 CountryLayer!');

        Map<Id, Lead> leadsByIds = new Map<Id, Lead>(leads);
        List<Lead> leads2 = [SELECT Id, Name, Country, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, Region__c FROM Lead WHERE Id IN :leadsByIds.keySet()];
        System.assertEquals(200, leads2.size(), 'There should be 200 leads after the creation of 200 new leads!');
        for(Lead l : leads2){
            System.assertEquals(countryLayers[0].Alpha2Code__c, l.Alpha2Code__c, 'There should be propagated Alpha2Code__c!');
            System.assertEquals(countryLayers[0].Alpha3Code__c, l.Alpha3Code__c, 'There should be propagated Alpha3Code__c!');
            System.assertEquals(countryLayers[0].CapitalCity__c, l.CapitalCity__c, 'There should be propagated CapitalCity__c!');
            System.assertEquals(countryLayers[0].Region__c, l.Region__c, 'There should be propagated Region__c!');
        }
    }

    /**
 * @description bulk test for updating 200 Leads without children
 */
    @IsTest
    static void bulkTestUpdatingLeads() {

        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Name ' + i, LastName = 'LastName ' + i, Company = 'Company ' + i, Country = ''));
        }

        insert leads;

        Map<Id, Lead> leadsByIds = new Map<Id, Lead>(leads);
        List<Lead> leads2 = [SELECT Id, Name, Country, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, Region__c FROM Lead WHERE Id IN :leadsByIds.keySet()];
        System.assertEquals(200, leads.size(), 'There should be 200 child accounts after the creation of 200 new leads!');


        for(Integer i = 0; i < leads.size(); i++) {
            leads[i].Country = 'Czech Republic';
        }

        update leads;

        List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];
        System.assertEquals(1, countryLayers.size(), 'There should be 1 CountryLayer!');

        leadsByIds = new Map<Id, Lead>(leads);
        leads2 = [SELECT Id, Name, Country, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, Region__c FROM Lead WHERE Id IN :leadsByIds.keySet()];
        System.assertEquals(200, leads2.size(), 'There should be 200 leads after the updating of 200 leads!');
        for(Lead l : leads2){
            System.assertEquals(countryLayers[0].Alpha2Code__c, l.Alpha2Code__c, 'There should be propagated Alpha2Code__c!');
            System.assertEquals(countryLayers[0].Alpha3Code__c, l.Alpha3Code__c, 'There should be propagated Alpha3Code__c!');
            System.assertEquals(countryLayers[0].CapitalCity__c, l.CapitalCity__c, 'There should be propagated CapitalCity__c!');
            System.assertEquals(countryLayers[0].Region__c, l.Region__c, 'There should be propagated Region__c!');
        }
    }
}