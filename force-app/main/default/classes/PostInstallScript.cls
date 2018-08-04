global class PostInstallScript implements InstallHandler {
    
    //Custom settings are data, so we have to create the defaults we want after this app is added to an org
    global void onInstall(InstallContext context) {
        enableRecordTypeMappingFeature();
        createRecordTypeMapping();
    }

    //Create the custom setting that enables the RecordTypeMapping feature for the org
    public void enableRecordTypeMappingFeature() {
        FeatureSettings__c orgLevelRecord = new FeatureSettings__c();
        orgLevelRecord.FeatureEnabled__c = true;
        orgLevelRecord.SetupOwnerId = UserInfo.getOrganizationId();
        insert orgLevelRecord;
    }

    //Create all the mappings of Industry + Country to Record Type that we'll use in the app
    public void createRecordTypeMapping() {
        List<RecordTypeMapping__c> records = new List<RecordTypeMapping__c>();
        records.add(new RecordTypeMapping__c(Name='CAGov', CountryCode__c='CA', Industry__c='Government', RecordTypeName__c='NA Government'));
        records.add(new RecordTypeMapping__c(Name='USGov', CountryCode__c='US', Industry__c='Government', RecordTypeName__c='NA Government'));
        records.add(new RecordTypeMapping__c(Name='MXGov', CountryCode__c='MX', Industry__c='Government', RecordTypeName__c='NA Government'));

        records.add(new RecordTypeMapping__c(Name='ALGov', CountryCode__c='AL', Industry__c='Government', RecordTypeName__c='EMEA Government'));
        records.add(new RecordTypeMapping__c(Name='DZGov', CountryCode__c='DZ', Industry__c='Government', RecordTypeName__c='EMEA Government'));
        records.add(new RecordTypeMapping__c(Name='ADGov', CountryCode__c='AD', Industry__c='Government', RecordTypeName__c='EMEA Government'));
        records.add(new RecordTypeMapping__c(Name='AOGov', CountryCode__c='AO', Industry__c='Government', RecordTypeName__c='EMEA Government'));
        records.add(new RecordTypeMapping__c(Name='ATGov', CountryCode__c='AT', Industry__c='Government', RecordTypeName__c='EMEA Government'));

        insert records;
    }
}
