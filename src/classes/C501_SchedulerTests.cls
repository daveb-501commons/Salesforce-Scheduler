@istest
class C501_SchedulerTests {

    public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    static testmethod void C501_SchedulerTest_Schedule() {

        Test.startTest();

        Campaign campaign = new Campaign();
        campaign.name = 'C501_Scheduler_Campaign';
        insert campaign;

        C501_ScheduledFlow__c flow = new C501_ScheduledFlow__c();
        flow.Name = 'C501_Scheduler_Flow';
        flow.Campaign__c = campaign.Id;
        insert flow;

        // Schedule the test job
        String jobId = System.schedule('testBasicScheduledApex',
        C501_SchedulerTests.CRON_EXP, 
            new C501_Scheduler());

        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
            NextFireTime
            FROM CronTrigger WHERE id = :jobId];

        // Verify the expressions are the same
        System.assertEquals(C501_SchedulerTests.CRON_EXP, 
            ct.CronExpression);

        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);

        // Verify the next time the job will run
        System.assertEquals('2022-09-03 00:00:00', 
            String.valueOf(ct.NextFireTime));

        System.assert(
            ![SELECT Id, FireFlow__c FROM C501_ScheduledFlow__c WHERE Id = :flow.Id].FireFlow__c);

        Test.stopTest();

        System.assert(
            [SELECT Id, FireFlow__c FROM C501_ScheduledFlow__c WHERE Id = :flow.Id].FireFlow__c);
   }
}