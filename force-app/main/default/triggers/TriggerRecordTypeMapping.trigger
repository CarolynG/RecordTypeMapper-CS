trigger TriggerRecordTypeMapping on Lead (before insert, before update) {
    
    FeatureService fs = new FeatureService();
    MappingService ms = new MappingService();
    
    Boolean featureEnabled = this.fs.isFeatureEnabled();
        
    if (featureEnabled) {
        Schema.DescribeSObjectResult leadDescribe = Lead.getSObjectType().getDescribe();
        Map<String,Schema.RecordTypeInfo> leadRecordTypesByName = leadDescribe.getRecordTypeInfosByName();
        
        for (Lead l : Trigger.New) {
            String newRecordTypeName = this.ms.getRecordTypeName(l.CountryCode, l.Industry);
            String newRecordTypeId = leadRecordTypesByName.get(newRecordTypeName).getRecordTypeId();

            l.RecordTypeId = newRecordTypeId;
        }
    }
}