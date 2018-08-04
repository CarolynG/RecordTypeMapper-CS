@isTest(seeAllData=true) //seeAllData needed to see custom setting data
private class Test_FeatureService {
    
    @isTest static void testFeatureEnabledByDefault() {
        FeatureService fs = new FeatureService();
        System.assert(fs.isFeatureEnabled(), 'Feature should have been enabled by default');
    }

    @isTest static void testFeatureCanBeTurnedOff() {
        FeatureService fs = new FeatureService();
        Boolean originalValue = fs.setEnabled(false);

        System.assertEquals(true, originalValue, 'Feature should have been enabled by default');
        System.assert(!fs.isFeatureEnabled(), 'Feature was not disabled successfully');
    }
}