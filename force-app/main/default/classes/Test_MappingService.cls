@isTest(seeAllData=true) //seeAllData needed to see custom setting data
private class Test_MappingService {
    
    @isTest static void testGetRecordTypeName() {
        MappingService ms = new MappingService();

        System.assertEquals('NA Government', ms.getRecordTypeName('US', 'Government'), 
                'Failed to get record type name for existing mapping');

        System.assertEquals('Default Lead', ms.getRecordTypeName('UK', 'Agriculture'),
                'Failed to get record type name when mapping does not exist');
    }
}