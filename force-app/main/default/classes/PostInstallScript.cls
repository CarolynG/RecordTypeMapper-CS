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

    //For each available (non-default) record type, create custom setting records that map all the combinations
    // of Industry + Country which should use that record type
    public void createRecordTypeMapping() {
        List<RecordTypeMapping__c> records = new List<RecordTypeMapping__c>();
        
        Map<String,String> countryMap = getMapOfCountryCodeToRegion();
        for (String countryCode : countryMap.keySet()) {
            String regionCode = countryMap.get(countryCode);

            //All regions have a record type for 'Government' industry
            records.add(new RecordTypeMapping__c(Name = countryCode + 'Gov', 
                                                 CountryCode__c = countryCode, 
                                                 Industry__c = 'Government', 
                                                 RecordTypeName__c = regionCode + ' Government'));

            //North America and EMEA also have a record type for 'Not for Profit' industry
            if (regionCode == 'NA' || regionCode == 'EMEA') {
                records.add(new RecordTypeMapping__c(Name = countryCode + 'NonProf', 
                                                     CountryCode__c = countryCode, 
                                                     Industry__c = 'Not For Profit', 
                                                     RecordTypeName__c = regionCode + ' Non Profit'));
            }

            //if we had more record types, we'd need to add mappings for them here also!
        }
        insert records;
    }

    private Map<String,String> getMapOfCountryCodeToRegion() {
        Map<String,String> countryMap = new Map<String,String>();
        countryMap.put('AS', 'APAC');
        countryMap.put('AQ', 'APAC');
        countryMap.put('AU', 'APAC');
        countryMap.put('BD', 'APAC');
        countryMap.put('BT', 'APAC');
        countryMap.put('BN', 'APAC');
        countryMap.put('MM', 'APAC');
        countryMap.put('KH', 'APAC');
        countryMap.put('CN', 'APAC');
        countryMap.put('CX', 'APAC');
        countryMap.put('CC', 'APAC');
        countryMap.put('CK', 'APAC');
        countryMap.put('TL', 'APAC');
        countryMap.put('FJ', 'APAC');
        countryMap.put('PF', 'APAC');
        countryMap.put('GU', 'APAC');
        countryMap.put('HM', 'APAC');
        countryMap.put('HK', 'APAC');
        countryMap.put('IN', 'APAC');
        countryMap.put('ID', 'APAC');
        countryMap.put('JP', 'APAC');
        countryMap.put('KI', 'APAC');
        countryMap.put('KR', 'APAC');
        countryMap.put('KG', 'APAC');
        countryMap.put('LA', 'APAC');
        countryMap.put('MO', 'APAC');
        countryMap.put('MY', 'APAC');
        countryMap.put('MV', 'APAC');
        countryMap.put('MH', 'APAC');
        countryMap.put('FM', 'APAC');
        countryMap.put('MN', 'APAC');
        countryMap.put('NR', 'APAC');
        countryMap.put('NP', 'APAC');
        countryMap.put('NC', 'APAC');
        countryMap.put('NZ', 'APAC');
        countryMap.put('NU', 'APAC');
        countryMap.put('MP', 'APAC');
        countryMap.put('PK', 'APAC');
        countryMap.put('PW', 'APAC');
        countryMap.put('PG', 'APAC');
        countryMap.put('PH', 'APAC');
        countryMap.put('PN', 'APAC');
        countryMap.put('WS', 'APAC');
        countryMap.put('SG', 'APAC');
        countryMap.put('SB', 'APAC');
        countryMap.put('LK', 'APAC');
        countryMap.put('TW', 'APAC');
        countryMap.put('TJ', 'APAC');
        countryMap.put('TH', 'APAC');
        countryMap.put('TK', 'APAC');
        countryMap.put('TO', 'APAC');
        countryMap.put('TM', 'APAC');
        countryMap.put('TV', 'APAC');
        countryMap.put('UZ', 'APAC');
        countryMap.put('VU', 'APAC');
        countryMap.put('VN', 'APAC');
        countryMap.put('WF', 'APAC');
        countryMap.put('AF', 'EMEA');
        countryMap.put('AL', 'EMEA');
        countryMap.put('DZ', 'EMEA');
        countryMap.put('AD', 'EMEA');
        countryMap.put('AO', 'EMEA');
        countryMap.put('AM', 'EMEA');
        countryMap.put('AT', 'EMEA');
        countryMap.put('AZ', 'EMEA');
        countryMap.put('BH', 'EMEA');
        countryMap.put('BY', 'EMEA');
        countryMap.put('BE', 'EMEA');
        countryMap.put('BJ', 'EMEA');
        countryMap.put('BA', 'EMEA');
        countryMap.put('BW', 'EMEA');
        countryMap.put('BV', 'EMEA');
        countryMap.put('IO', 'EMEA');
        countryMap.put('BG', 'EMEA');
        countryMap.put('BF', 'EMEA');
        countryMap.put('BI', 'EMEA');
        countryMap.put('CM', 'EMEA');
        countryMap.put('CV', 'EMEA');
        countryMap.put('CF', 'EMEA');
        countryMap.put('TD', 'EMEA');
        countryMap.put('KM', 'EMEA');
        countryMap.put('CD', 'EMEA');
        countryMap.put('CG', 'EMEA');
        countryMap.put('CI', 'EMEA');
        countryMap.put('HR', 'EMEA');
        countryMap.put('CY', 'EMEA');
        countryMap.put('CZ', 'EMEA');
        countryMap.put('DK', 'EMEA');
        countryMap.put('DJ', 'EMEA');
        countryMap.put('EG', 'EMEA');
        countryMap.put('GQ', 'EMEA');
        countryMap.put('ER', 'EMEA');
        countryMap.put('EE', 'EMEA');
        countryMap.put('ET', 'EMEA');
        countryMap.put('FO', 'EMEA');
        countryMap.put('FI', 'EMEA');
        countryMap.put('FR', 'EMEA');
        countryMap.put('GF', 'EMEA');
        countryMap.put('TF', 'EMEA');
        countryMap.put('GA', 'EMEA');
        countryMap.put('GM', 'EMEA');
        countryMap.put('GE', 'EMEA');
        countryMap.put('DE', 'EMEA');
        countryMap.put('GH', 'EMEA');
        countryMap.put('GI', 'EMEA');
        countryMap.put('GR', 'EMEA');
        countryMap.put('GL', 'EMEA');
        countryMap.put('GN', 'EMEA');
        countryMap.put('GW', 'EMEA');
        countryMap.put('VA', 'EMEA');
        countryMap.put('HU', 'EMEA');
        countryMap.put('IS', 'EMEA');
        countryMap.put('IE', 'EMEA');
        countryMap.put('IL', 'EMEA');
        countryMap.put('IT', 'EMEA');
        countryMap.put('JO', 'EMEA');
        countryMap.put('KZ', 'EMEA');
        countryMap.put('KE', 'EMEA');
        countryMap.put('KW', 'EMEA');
        countryMap.put('LV', 'EMEA');
        countryMap.put('LB', 'EMEA');
        countryMap.put('LS', 'EMEA');
        countryMap.put('LR', 'EMEA');
        countryMap.put('LI', 'EMEA');
        countryMap.put('LT', 'EMEA');
        countryMap.put('LU', 'EMEA');
        countryMap.put('MK', 'EMEA');
        countryMap.put('MG', 'EMEA');
        countryMap.put('MW', 'EMEA');
        countryMap.put('ML', 'EMEA');
        countryMap.put('MT', 'EMEA');
        countryMap.put('MR', 'EMEA');
        countryMap.put('MU', 'EMEA');
        countryMap.put('YT', 'EMEA');
        countryMap.put('MD', 'EMEA');
        countryMap.put('MC', 'EMEA');
        countryMap.put('MA', 'EMEA');
        countryMap.put('MZ', 'EMEA');
        countryMap.put('NA', 'EMEA');
        countryMap.put('NL', 'EMEA');
        countryMap.put('NE', 'EMEA');
        countryMap.put('NG', 'EMEA');
        countryMap.put('NO', 'EMEA');
        countryMap.put('OM', 'EMEA');
        countryMap.put('PL', 'EMEA');
        countryMap.put('PT', 'EMEA');
        countryMap.put('QA', 'EMEA');
        countryMap.put('ME', 'EMEA');
        countryMap.put('RS', 'EMEA');
        countryMap.put('RE', 'EMEA');
        countryMap.put('RO', 'EMEA');
        countryMap.put('RU', 'EMEA');
        countryMap.put('RW', 'EMEA');
        countryMap.put('SH', 'EMEA');
        countryMap.put('PM', 'EMEA');
        countryMap.put('SM', 'EMEA');
        countryMap.put('ST', 'EMEA');
        countryMap.put('SA', 'EMEA');
        countryMap.put('SN', 'EMEA');
        countryMap.put('SC', 'EMEA');
        countryMap.put('SL', 'EMEA');
        countryMap.put('SK', 'EMEA');
        countryMap.put('SI', 'EMEA');
        countryMap.put('SO', 'EMEA');
        countryMap.put('ZA', 'EMEA');
        countryMap.put('ES', 'EMEA');
        countryMap.put('SJ', 'EMEA');
        countryMap.put('SZ', 'EMEA');
        countryMap.put('SE', 'EMEA');
        countryMap.put('CH', 'EMEA');
        countryMap.put('TZ', 'EMEA');
        countryMap.put('TG', 'EMEA');
        countryMap.put('TN', 'EMEA');
        countryMap.put('TR', 'EMEA');
        countryMap.put('UG', 'EMEA');
        countryMap.put('UA', 'EMEA');
        countryMap.put('AE', 'EMEA');
        countryMap.put('GB', 'EMEA');
        countryMap.put('EH', 'EMEA');
        countryMap.put('YE', 'EMEA');
        countryMap.put('ZM', 'EMEA');
        countryMap.put('ZW', 'EMEA');
        countryMap.put('AG', 'NA');
        countryMap.put('BS', 'NA');
        countryMap.put('BB', 'NA');
        countryMap.put('BZ', 'NA');
        countryMap.put('CA', 'NA');
        countryMap.put('CR', 'NA');
        countryMap.put('DM', 'NA');
        countryMap.put('DO', 'NA');
        countryMap.put('SV', 'NA');
        countryMap.put('GD', 'NA');
        countryMap.put('GT', 'NA');
        countryMap.put('HT', 'NA');
        countryMap.put('HN', 'NA');
        countryMap.put('JM', 'NA');
        countryMap.put('MX', 'NA');
        countryMap.put('NI', 'NA');
        countryMap.put('PA', 'NA');
        countryMap.put('KN', 'NA');
        countryMap.put('LC', 'NA');
        countryMap.put('VC', 'NA');
        countryMap.put('TT', 'NA');
        countryMap.put('US', 'NA');
        countryMap.put('AI', 'SA');
        countryMap.put('AR', 'SA');
        countryMap.put('AW', 'SA');
        countryMap.put('BM', 'SA');
        countryMap.put('BO', 'SA');
        countryMap.put('BR', 'SA');
        countryMap.put('VG', 'SA');
        countryMap.put('KY', 'SA');
        countryMap.put('CL', 'SA');
        countryMap.put('CO', 'SA');
        countryMap.put('EC', 'SA');
        countryMap.put('FK', 'SA');
        countryMap.put('GP', 'SA');
        countryMap.put('GY', 'SA');
        countryMap.put('MQ', 'SA');
        countryMap.put('MS', 'SA');
        countryMap.put('AN', 'SA');
        countryMap.put('NF', 'SA');
        countryMap.put('PY', 'SA');
        countryMap.put('PE', 'SA');
        countryMap.put('PR', 'SA');
        countryMap.put('GS', 'SA');
        countryMap.put('SR', 'SA');
        countryMap.put('TC', 'SA');
        countryMap.put('UY', 'SA');
        countryMap.put('VE', 'SA');
        countryMap.put('VI', 'SA');
        return countryMap;
    }
}
