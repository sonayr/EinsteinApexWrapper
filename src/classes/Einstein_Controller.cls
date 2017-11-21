public with sharing class Einstein_Controller {

	@auraenabled
	public static void createIntentDatasetFromUrl(String csvURL) {
		System.debug(csvURL);
		EinStein_Service service = new EinStein_Service();
		service.createIntentDataSetFromURLAsync(csvUrl);	
	}

	@AuraEnabled
	public static List<Einstein_Dataset> getDatasets() {

	    EinStein_Service service = new EinStein_Service();

	    return service.getLanguageDatasets();

	}

	@AuraEnabled
	public static Boolean deleteDataset(Long datasetId){
		EinStein_Service service = new EinStein_Service();

		return service.deleteIntentDataSet(datasetId);
	}

	@AuraEnabled
	public static Einstein_Model[] getModels(Long datasetId){
		EinStein_Service service = new EinStein_Service();
		return service.getAllLanguageModels(datasetId);
	}

	@AuraEnabled
	public static Einstein_Model trainDataset(Long datasetId){
		EinStein_Service service = new EinStein_Service();
		return service.trainLanuageDataset(datasetId, 'Language Training');
	}




}