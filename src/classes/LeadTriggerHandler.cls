/**
* @Author       Petr Roubal
* @Company:
* @Description: TriggerHandler for the standard object Lead
* @Date:        11/06/2023
* @TestClass:   LeadTriggerHelper_Test
* History
* <Date>      <Authors Name>     <Brief Description of Change>
*------------------------------------------------------------*/

public with sharing class LeadTriggerHandler {

    private boolean triggerIsExecuting;
    private integer triggerSize;
    public LeadTriggerHelper helper;

    public LeadTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new LeadTriggerHelper();
    }

    public void beforeInsert(List<Lead> newLeads) {
        helper.populateCountryInformation(null, newLeads, null, null);
    }
    public void beforeUpdate(List<Lead> oldLeads, List<Lead> newLeads, Map<ID, Lead> oldALeadMap, Map<ID, Lead> newLeadMap) {
        helper.populateCountryInformation(oldLeads, newLeads, oldALeadMap, newLeadMap);
    }


}