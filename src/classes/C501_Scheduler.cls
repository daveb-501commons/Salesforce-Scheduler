global class C501_Scheduler implements Schedulable {

    global void execute(SchedulableContext SC) {

        List<C501_ScheduledFlow__c> scheduledFlows = [SELECT Id, Name FROM C501_ScheduledFlow__c];
    
        for (C501_ScheduledFlow__c flow : scheduledFlows) {
            flow.FireFlow__c = true;
        }

        update scheduledFlows;
   }
}