public with sharing class FeatureService {

    CustomSettingsService customSettings;

    public FeatureService() {
        this.customSettings = new CustomSettingsService();
    }

    public boolean isFeatureEnabled() {
        return this.customSettings.getMapperEnablementRecord().FeatureEnabled__c;
    }

    public boolean setEnabled(Boolean newValue) {
        return this.customSettings.updateMapperEnablementRecord(newValue);
    }
}
