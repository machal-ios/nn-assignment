/**
* @Author       Petr Roubal
* @Company:
* @Description: Trigger for the standard object Lead
* @Date:        11/06/2023
* @TestClass:   LeadTriggerHelper_Test
* History
* <Date>      <Authors Name>     <Brief Description of Change>
*------------------------------------------------------------*/

trigger Lead on Lead (before insert, before update) {

    LeadTriggerHandler handler = new LeadTriggerHandler(Trigger.isExecuting, Trigger.size);
    switch on Trigger.operationType {

        when Before_INSERT {
            handler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            handler.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
    }

}