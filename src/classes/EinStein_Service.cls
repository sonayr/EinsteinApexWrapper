/******************************************************************************
Author: Ryan O'Sullivan

Description:Service class for all EinStien API calls (Vision, Intent,Sentiment)

This is an inspired version of the Einstein Vision open source library:
https://github.com/muenzpraeger/salesforce-einstein-vision-apex

Reworked to incorporate Intent and Senitment API

Test Class:EinStein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
04/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class EinStein_Service {

	// Base URL for the PredictionService
	private static String BASE_URL = 'https://api.einstein.ai/v2';
	
	private String LANGUAGE_DATASETS = BASE_URL + '/language/datasets';
	private String LANGUAGE_TRAIN = BASE_URL + '/language/train';
	private String LANGUAGE_RETRAIN = BASE_URL + '/language/retrain';
	private String LANGUAGE_MODELS = '/language/models';
	private String LANGUAGE_FEEDBACK = '/language/feedback';
	private String LANGUAGE_INTENT_PREDICT = BASE_URL + '/language/intent';
	private String LANGUAGE_SENTIMENT_PREDICT = BASE_URL + '/language/sentiment';
	private String LABELS = '/labels';
	private String EXAMPLES = '/examples';
	private String VISION_DATASETS = BASE_URL + '/vision/datasets';
	private String VISION_TRAIN = BASE_URL + '/vision/train';
	private String VISION_MODELS = '/vision/models';
	private String VISION_PREDICT = BASE_URL + '/vision/predict';
	private String API_USAGE = BASE_URL + '/apiusage';
	private static String OAUTH2 = BASE_URL + '/oauth2/token';
	
	private boolean isExecuting = false;
	private String bearerToken = '';
	public Integer httpStatusCode = 0;

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Constructor with no bearer token defined
	
	Return: Instance of Einstein_Service
	******************************************************************************/
	public EinStein_Service(){
		this.bearerToken = getToken();
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Constructor with a bearer token defined
	
	Return: Instance of Einstein_Service
	******************************************************************************/
	public EinStein_Service(String bearerToken){
		this.bearerToken = bearerToken;
	}


	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Creates a Enstein Intent Dataset using a url to a CSV file formated
	as such:

	|Text|Label|

	Note this call is Asyncronous so the Dataset returned is incompelete

	Return: Einstein_Dataset 
	******************************************************************************/
	public Einstein_Dataset createIntentDataSetFromURLAsync(String csvUrl){
		System.debug(csvUrl);
		Enistein_HttpBodyIntentDataSet body = new Enistein_HttpBodyIntentDataSet(csvUrl);
		Einstein_HttpClient client = new Einstein_HttpClient(this, LANGUAGE_DATASETS + '/upload' ,body.build());


		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Dataset dataset = (Einstein_Dataset)parser.readValueAs(Einstein_Dataset.class);
			System.debug('New Dataset with Id:' + dataset.id +' has been created');
			return dataset;
		}

		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Creates a Enstein Intent Dataset using a url to a CSV file formated
	as such:

	|Text|Label|

	Note this call is Synchronous so it takes longer but returns a completed dataset

	Return: Einstein_Dataset 
	******************************************************************************/
	public Einstein_Dataset createIntentDataSetFromURLSync(String csvUrl){
		Enistein_HttpBodyIntentDataSet body = new Enistein_HttpBodyIntentDataSet(csvUrl);
		Einstein_HttpClient client = new Einstein_HttpClient(this, LANGUAGE_DATASETS + '/upload/sync' ,body.build());


		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Dataset dataset = (Einstein_Dataset)parser.readValueAs(Einstein_Dataset.class);
			System.debug('New Dataset with Id:' + dataset.id +' has been created');
			return dataset;
		}

		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Delete the given Intent Dataset
	
	Return: boolean, true for success, false for fail
	******************************************************************************/
	public boolean deleteIntentDataSet(Long id){
		Einstein_HttpClient client = new Einstein_HttpClient(this, LANGUAGE_DATASETS +'/' + id);
		client.isDelete(true);
		executionSequence(client);
		if(httpStatusCode == Einstein_HttpClient.NO_CONTENT){
			// Delete request doesn't return json, no content is a success
			System.debug('Successfully deleted Dataset:' + id);
			return true;
		} else {
			return false;
		}
	}


	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description: Grabs all the datasets for Langauge assoicated(Intent/Sentiment) 
	to this org 
	
	Return: List of Language Datasets
	******************************************************************************/
	public Einstein_Dataset[] getLanguageDatasets(){
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_DATASETS);
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Dataset[] datasets = (Einstein_Dataset[])parser.readValueAs(Einstein_Dataset[].class);
			return datasets;
		}
		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description: Grabs a specified dataset (using an id) for the Language API 
	(Intent/Sentiment)	
	
	Return: A single Language Dataset
	******************************************************************************/
	public Einstein_Dataset getLanguageDatasets(Long id){
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_DATASETS +'/' + id);
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Dataset datasets = (Einstein_Dataset)parser.readValueAs(Einstein_Dataset.class);
			return datasets;
		}
		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Train a language dataset to create a model used for predictions.
	Train params and epochs are optional parameters

	Note model takes a while to generate so use get training status method to watch
	progress.
	
	Return: Einstein_Model
	******************************************************************************/
	public Einstein_Model trainLanuageDataset(Long datasetId, String name, Integer epochs, String trainParams){
		Einstein_HttpBodyIntentModel body = new Einstein_HttpBodyIntentModel(datasetId,name,epochs,trainParams);
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_TRAIN,body.build());
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Model model = (Einstein_Model)parser.readValueAs(Einstein_Model.class);
			return model;
		}
		return null;
	}
	public Einstein_Model trainLanuageDataset(Long datasetId, String name, Integer epochs){
		return trainLanuageDataset(datasetId,name,epochs,null);
	}
	public Einstein_Model trainLanuageDataset(Long datasetId, String name, String trainParams){
		return trainLanuageDataset(datasetId,name,null,trainParams);
	}
	public Einstein_Model trainLanuageDataset(Long datasetId, String name){
		return trainLanuageDataset(datasetId,name,null,null);
	}


	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Get information on a particual model created from a dataset.

	
	Return: Einstein_Model
	******************************************************************************/
	public Einstein_Model getLanguageModel(Long modelId){
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_TRAIN + '/' + modelId);
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Model model = (Einstein_Model)parser.readValueAs(Einstein_Model.class);
			return model;
		}
		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Get all models relating to a single dataset
	
	Return: List of Einstein_Models
	******************************************************************************/
	public Einstein_Model[] getAllLanguageModels(Long datasetId){
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_DATASETS + '/' + datasetId + '/models');
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Model[] models = (Einstein_Model[])parser.readValueAs(Einstein_Model[].class);
			return models;
		}
		return null;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description: Make an Intent prediction utalizing a string (Document) for a given
	model. 
	Can control the number of results returned via numResults.
	Can give a name to the prediction via sampleId
	
	Return: Einstein_Prediction
	******************************************************************************/
	public Einstein_Prediction getIntentPrediction(String document, String modelId, Integer numResults, String sampleId){
		Einstein_HttpBodyLanguagePrediction body = new Einstein_HttpBodyLanguagePrediction(document,modelId,numResults,sampleId);
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_INTENT_PREDICT,body.build());
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_Prediction prediction = (Einstein_Prediction)parser.readValueAs(Einstein_Prediction.class);
			return prediction;
		}
		return null;
	}
	public Einstein_Prediction getIntentPrediction(String document, String modelId, Integer numResults){
		return getIntentPrediction( document,  modelId,  numResults, null);
	}
	public Einstein_Prediction getIntentPrediction(String document, String modelId, String sampleId){
		return getIntentPrediction( document,  modelId, null, sampleId);
	}
	public Einstein_Prediction getIntentPrediction(String document, String modelId){
		return getIntentPrediction( document,  modelId, null, null);
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:09/11/2017
	
	Description:Send feedback back to the dataset. It's important to realize
	you input the model id assoicated to the dataset but the model does not get
	instantly trained with the feedback.
	
	Return: Feedback
	******************************************************************************/
	public Einstein_LanugageFeedback postLanguageFeedBack(String document, String expectedLabel, String modelId){
		Einstein_HttpBodyLanguageFeedback body = new Einstein_HttpBodyLanguageFeedback(document,expectedLabel,modelId);
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_FEEDBACK,body.build());
		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_LanugageFeedback feedback = (Einstein_LanugageFeedback)parser.readValueAs(Einstein_LanugageFeedback.class);
			return feedback;
		}
		return null;	
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:11/11/2017
	
	Description:Send request to retrain a given model. Useful when the dataset 
	changes via feedback and you want those results refelected in your predictions
	
	Return: Einstein_LanguageRetrain
	******************************************************************************/
	public Einstein_LanguageRetrain retrainLanguageDataset (Integer epochs, String modelId, String trainParams){
		Einstein_HttpBodyLanguageRetrain body = new Einstein_HttpBodyLanguageRetrain(epochs,modelId,trainParams);
		Einstein_HttpClient client = new Einstein_HttpClient(this,LANGUAGE_RETRAIN,body.build());

		JSONParser parser = executionSequence(client);

		if(parser != null){
			Einstein_LanguageRetrain response = (Einstein_LanguageRetrain)parser.readValueAs(Einstein_LanguageRetrain.class);
			return response;
		}

		return null;
	}
	public Einstein_LanguageRetrain retrainLanguageDataset (String modelId, String trainParams){
		return retrainLanguageDataset(null,modelId,trainParams);
	}
	public Einstein_LanguageRetrain retrainLanguageDataset (Integer epochs, String modelId){
		return retrainLanguageDataset(epochs,modelId,null);
	}
	public Einstein_LanguageRetrain retrainLanguageDataset (String modelId){
		return retrainLanguageDataset(null,modelId,null);
	}




	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Getter for bearerToken
	
	Return: String of active bearerToken
	******************************************************************************/
	public String getBearerToken(){
		return bearerToken;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Getter for isExecuting
	
	Return: Boolean of isExecuting
	******************************************************************************/
    public boolean isExecuting() {
        return isExecuting;
    }
    
    /*****************************METHOD DESCRIPTION*******************************
    Author:Ryan O'Sullivan
    Date:05/11/2017
    
    Description:Setter for isExecuting
    
    Return: Null
    ******************************************************************************/
    public void isExecuting(boolean isExecuting) {
        this.isExecuting = isExecuting;
    }

    /*****************************METHOD DESCRIPTION*******************************
    Author:Ryan O'Sullivan
    Date:05/11/2017
    
    Description:Error Handler for HTTP errors. Prints to debug and sets global value
    
    Return: null
    ******************************************************************************/
    private void handleError(Integer statusCode, String message) {
        httpStatusCode = statusCode;
        System.debug(LoggingLevel.Error, 'Response finished with Error: ' + message);
    }

    /*****************************METHOD DESCRIPTION*******************************
    Author:Ryan O'Sullivan
    Date:05/11/2017
    
    Description:Execution Loop when sending HTTP requests
    
    Return: JSONParser of results, or null if failed
    ******************************************************************************/
    private JSONParser executionSequence(Einstein_HttpClient client){
    	System.debug('About to start execution');
    	client.execute();
    	while(isExecuting()){

    	}
    	System.debug('Finished executing');
    	if(client.isError()){
    		// Call failed
    		handleError(client.getStatusCode(), client.getResponseError());
    	} else {
    		// Call worked
    		httpStatusCode = client.getStatusCode();
    		return client.getParser();
    	}
    	return null;
    }
	    
	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Reach into the Einstein saved file and obtain the bearer token
	needed for communication to the Einstein API.
	
	Return: String value of the bearer token, or null if error occured
	******************************************************************************/
	public static String getToken (){
		Einstein_Connection_Settings__c settings = Einstein_Connection_Settings__c.getOrgDefaults();

		if(settings == new Einstein_Connection_Settings__c()){
			// getOrgDefaults returned and empty object, therefore settings are not set
			throw new Einstein_Exceptions.EinsteinSettingsException('No Org default settings set');
		}
		Einstein_JWT jwt = new Einstein_JWT(Einstein_JWT.RS256); // Set to RS256 Auth Algorithim

		if(!settings.Using_JWT_Certificate__c){
			// This org is not using a JWT Certifcate, look for the latest file instead
			ContentVersion[] einStein_key_file_query = [SELECT VersionData FROM ContentVersion where Title =: settings.FileName__c  ORDER BY CreatedDate DESC LIMIT 1];
			if(einStein_key_file_query.isEmpty()){
				// Query failed for find a file
				System.debug('Failed to find a file with the name:' + settings.FileName__c);
				throw new Einstein_Exceptions.EinsteinSettingsException('No File uploaded with Einstein Key or no fileName specified in settings. If you are using a JWT certificate please check so in settings');
			}

			// Format key out of given file
			String keyContents = einStein_key_file_query[0].VersionData.tostring();
			keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
			keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
			keyContents = keyContents.replace('\n', '');

			jwt.pkcs8 = keyContents; // Set key in jwt
		}

		jwt.iss = settings.Organization_Type__c; // Set Issuer URL
		jwt.sub = settings.Email__c; // Set subject email of user
		jwt.aud = OAUTH2; // Set audience url for Einstein 
		jwt.exp = String.valueOf(settings.Token_Expiry__c); // Set length of life for ticket (default 1 hour)

		String bearerToken = '';

		if(!Test.isRunningTest()){
			// Won't work in UnitTest
			bearerToken = Einstein_JWTBearerFlow.getAccessToken(OAUTH2, jwt);
		}

		return bearerToken;


	}
}