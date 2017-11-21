/******************************************************************************
Author: Ryan O'Sullivan

Description:Http Body for Training the Intent Datasets and creating Intent
Models

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/	
public class Einstein_HttpBodyIntentModel extends Einstein_HttpBodyPart {	

	private Long datasetId; //ID of the dataset to train.

	/*	Number of training iterations for the neural network. Optional. 
	If not specified, the default is calculated based on the dataset size. 
	The larger the number, the longer the training takes to complete.
	The training process stops before the specified number of epochs if 
	the model has reached the optimal accuracy. When you get the training staus, 
	the earlyStopping field specifies whether the training stopped early,
	 and the lastEpochDone value specifies the last training iteration.*/
	private Integer epochs;


	private Decimal learningRate; //N/A for intent or sentiment models.
	private String name; //Name of the model. Maximum length is 180 characters.

	/*JSON that contains parameters that specify how the model is created. 
	Optional. Valid values: 
	{"trainSplitRatio": 0.n}—Lets you specify 
	the ratio of data used to train the dataset and the
	data used to test the model. The default split ratio is 0.8; 80% of the
	 data is used to train 
	the dataset and create the model and 20% of the data is used to test the model. If you pass in
	 a split ratio of 0.6, then 60% of the data is used to train the dataset and create the model and 40% of the data is used to test the model.
	{"withFeedback": true}—Lets you specify that feedback examples are included in the data to be trained to create the model. If you omit this parameter, feedback examples aren't used in training.
	{"withGlobalDatasetId": <DATASET_ID>}—Lets you specify that a global dataset is used in addition to the specified dataset to create the model.*/
	private String trainParams;

	private boolean hasEpochs;
	private boolean hasTrainParams;



	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Constructor for Einstein_HttpBodyIntentModel
	
	Return: Instance of Einstein_HttpBodyIntentModel
	******************************************************************************/
	public Einstein_HttpBodyIntentModel(Long datasetId, String name, Integer epochs,  String trainParams) {
	    if (datasetId == null) {
	        throw new Einstein_Exceptions.ParameterIsEmptyException('datasetId is null');
	    }
	    if (name==null || name.equals('')) {
	        throw new Einstein_Exceptions.ParameterIsEmptyException('name is null or empty');
	    }
	    if (name.length()>180) {
	        throw new Einstein_Exceptions.StringLengthException('name can only be 180 characters');
	    }
	    if (epochs ==null || epochs == 0 ) {
	        hasEpochs = false;
	    }

	    if(trainParams == null || trainParams.equals('')){
	    	hasTrainParams = false; 
	    } else {
	    	hasTrainParams = true;
	    }

	    this.datasetId = datasetId;
	    this.name = name;
	    this.epochs = epochs;
	    this.trainParams = trainParams;
	}

	public blob build(){
		String body = '';
		body += WriteBoundary();
		body += WriteBodyParameter('name', this.name);	
		body += WriteBoundary();
		body += WriteBodyParameter('datasetId', '' + this.datasetId);	// fix for bug with String.valueof(Long)
		if(hasEpochs){
			body += WriteBoundary();
			body += WriteBodyParameter('epochs', String.valueof(this.epochs));	
		}
		if(hasTrainParams){
			body += WriteBoundary();
			body += WriteBodyParameter('trainParams', this.trainParams);	
		}
		body += WriteBoundary(EndingType.CrLf);
		Blob bodyBlob = EncodingUtil.base64Decode(body);
		return bodyBlob;
	}



}