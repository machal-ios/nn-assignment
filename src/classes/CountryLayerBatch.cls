/**
 * Created by petrroubal on 11.06.2023.
 */

public with sharing class CountryLayerBatch implements Database.Batchable<String>, Database.AllowsCallouts {


    public Iterable<String> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        String json = new CountryLayerIntegration().sendRequest();
        List<String> jsonList = new List<String>();
        jsonList.add(json);
        return jsonList;
    }
    public void execute(Database.BatchableContext bc, List<String> jsonList){
        // process each batch of records
        List<CountryLayer__c> newCountryLayers = new List<CountryLayer__c>();
        if(!jsonList.isEmpty()){
            List<CountryLayer2Apex> records = CountryLayer2Apex.parse(jsonList[0]);
            Map<String, CountryLayer2Apex> cl2aMap = new Map<String, CountryLayer2Apex>();
            for(CountryLayer2Apex record : records){
                cl2aMap.put(record.name, record);
            }
            List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];

            if(countryLayers.isEmpty()){
                // when the list is empty then it's an initialization load
                for(CountryLayer2Apex record : records){
                    newCountryLayers.add(converRecordToContryLayer(record));
                }
            }else{
                Map<String, CountryLayer__c> clMap = new Map<String, CountryLayer__c>();
                for(CountryLayer__c countryLayer : countryLayers){
                    clMap.put(countryLayer.CountryName__c, countryLayer);
                }
                for(CountryLayer2Apex record : records){
                    if(!clMap.containsKey(record.name)){
                        newCountryLayers.add(converRecordToContryLayer(record));
                    }else{
                        if(!compare(record, clMap.get(record.name))){
                            CountryLayer__c newCL = converRecordToContryLayer(record);
                            newCL.Id = clMap.get(record.name).Id;
                            newCountryLayers.add(newCL);
                        }
                    }
                }
            }
            upsert newCountryLayers;
        }
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('Done');
    }

    private CountryLayer__c converRecordToContryLayer(CountryLayer2Apex record){

        return new CountryLayer__c(
            Alpha2Code__c = record.alpha2Code,
            Alpha3Code__c = record.alpha3Code,
            CapitalCity__c = record.capital,
            CountryName__c = record.name,
            Region__c = record.region,
            RegionalBlocs_Acronyms__c = record.regionalBlocs == null || record.regionalBlocs.isEmpty() ? null :  record.regionalBlocs[0].acronym
        );
    }

    private Boolean compare(CountryLayer2Apex cl2a, CountryLayer__c cl){
        CountryLayer__c newCL = converRecordToContryLayer(cl2a);
        newCL.Id = cl.Id;
        System.debug('!!! newCL ' + newCL);
        System.debug('!!! cl ' + cl);
        Boolean retValue = newCL.Alpha2Code__c.equals(cl.Alpha2Code__c) &&
               newCL.Alpha3Code__c.equals(cl.Alpha3Code__c) &&
               newCL.CapitalCity__c.equals(cl.CapitalCity__c) &&
               newCL.Region__c.equals(cl.Region__c);
        if (newCL.RegionalBlocs_Acronyms__c != null)
            retValue = newCL.RegionalBlocs_Acronyms__c.equals(cl.RegionalBlocs_Acronyms__c);
        return retValue;
    }
}