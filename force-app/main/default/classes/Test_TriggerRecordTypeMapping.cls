@isTest(seeAllData=true) //seeAllData needed to see custom setting data
private class Test_TriggerRecordTypeMapping {

    @isTest static void testInsertLeadWithMapping() {
        insertLead('US', 'Government', 'NA Government');
    }

    @isTest static void testInsertLeadWithoutMapping() {
        insertLead('US', 'Chemicals', 'Default Lead');
    }

    @isTest static void testInsertLeadFeatureDisabled() {
        //disable the feature
        new FeatureService().setEnabled(false);

        //insert a lead
        insertLead('US', 'Government', 'Lead Intake');
    }

    // Insert a lead with the given field values and verify that 
    // the inserted record has the expected record type
    static void insertLead(String countryCode, String industry, String expectedRecordTypeName) {
        //insert a new lead
        Lead l = new Lead(LastName = 'Benioff', Company = 'Salesforce', CountryCode = countryCode, Industry = industry);
        insert l;

        //retrieve the new lead and verify its record type value
        List<Lead> leads = [SELECT Id, RecordTypeId FROM Lead WHERE LastName = 'Benioff'];
        System.assertEquals(1, leads.size(), 'Found the wrong number of leads');
        
        Lead retrievedLead = leads.get(0);
        System.assertNotEquals(null, retrievedLead.RecordTypeId, 'Found null record type on new lead');

        Schema.DescribeSObjectResult leadDescribe = Lead.getSObjectType().getDescribe();
        Map<Id,Schema.RecordTypeInfo> leadRecordTypesById = leadDescribe.getRecordTypeInfosById();
        
        RecordTypeInfo leadRecordTypeInfo = leadRecordTypesById.get(retrievedLead.RecordTypeId);
        System.assertEquals(expectedRecordTypeName, leadRecordTypeInfo.getName(), 
                'Found the wrong record type on inserted lead');
    }

}
