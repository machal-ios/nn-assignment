/**
 * Created by petrroubal on 11.06.2023.
 */

public with sharing class CountryLayerScheduler implements Schedulable {

    public void execute(SchedulableContext sc){
        CountryLayerBatch clb = new CountryLayerBatch();
        database.executeBatch(clb);
    }

}