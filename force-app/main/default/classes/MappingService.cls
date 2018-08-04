public with sharing class MappingService {
    
    CustomSettingsService customSettings;

    public MappingService() {
        this.customSettings = new CustomSettingsService();
    }

    public String getRecordTypeName(String countryCode, String industry) {
        RecordTypeMapping__c mapping = this.customSettings.getRecordTypeMappingping(countryCode, industry);
        if (mapping != null) {
            return mapping.RecordTypeName__c;
        } else {
            return 'Default Lead';
        }
    }
}
