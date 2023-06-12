/**
 * Created by petrroubal on 11.06.2023.
 */

public with sharing class LeadTriggerHelper {

    private Map<String, CountryLayer__c> countryLayerMap{
        get {
            if(countryLayerMap == null){
                countryLayerMap = getAllCountryLayers();
            }
            return countryLayerMap;
        }
        set{
            countryLayerMap = value;
        }
    }

    public void populateCountryInformation(List<Lead> oldLeads, List<Lead> newLeads, Map<ID, Lead> oldALeadMap, Map<ID, Lead> newLeadMap){
        if(oldLeads == null){
            for(Lead lead : newLeads) {
                assignCountryInformation(lead);
            }
        }else{
            for(Lead lead : newLeads) {
                if (lead.Country != oldALeadMap.get(lead.Id).Country) {
                    assignCountryInformation(lead);
                }
            }
        }
    }

    private Map<String, CountryLayer__c> getAllCountryLayers(){
        Map<String, CountryLayer__c> clMap = new Map<String, CountryLayer__c>();
        List<CountryLayer__c> countryLayers = [SELECT Id, Alpha2Code__c, Alpha3Code__c, CapitalCity__c, CountryName__c, Region__c, RegionalBlocs_Acronyms__c FROM CountryLayer__c];
        for(CountryLayer__c cl : countryLayers){
            clMap.put(cl.CountryName__c, cl);
        }
        return clMap;
    }

    private void assignCountryInformation(Lead lead){
        Map<String, CountryLayer__c>mapCL = countryLayerMap;
        if(mapCL.get(lead.Country) !=null){
            lead.Alpha2Code__c = mapCL.get(lead.Country).Alpha2Code__c;
            lead.Alpha3Code__c = mapCL.get(lead.Country).Alpha3Code__c;
            lead.CapitalCity__c = mapCL.get(lead.Country).CapitalCity__c;
            lead.Region__c = mapCL.get(lead.Country).Region__c;
        }else {
            lead.Alpha2Code__c = '';
            lead.Alpha3Code__c = '';
            lead.CapitalCity__c = '';
            lead.Region__c = '';
        }
    }

}