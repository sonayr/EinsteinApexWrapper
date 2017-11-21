/******************************************************************************
Author: Ryan O'Sullivan

Description:Builds the body for the langauge retrain request to the Einstein
Language API

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
11/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_HttpBodyLanguageRetrain extends Einstein_HttpBodyPart{

	/*Number of training iterations for the neural network. Optional. If not specified, 
	the default is calculated based on the dataset size. The larger the number,
	 the longer the training takes to complete.

	The training process stops before the specified number of epochs if the model has reached
	the optimal accuracy. When you get the training staus, the earlyStopping field specifies
	whether the training stopped early, and the lastEpochDone value specifies
    the last training iteration.*/
	private Integer epochs;

	// ID of the model to be updated from the training.
	private String modelId;

	/*
	JSON that contains parameters that specify how the model is created. Optional. Valid values:

	{"trainSplitRatio": 0.n}—Lets you specify the ratio of data used to train the dataset and 
	the data used to test the model. The default split ratio is 0.8; 80% of the data is used 
	to train the dataset and create the model and 20% of the data is used to test the model. 
	If you pass in a split ratio of 0.6, then 60% of the data is used to train the dataset
	 and create the model and 40% of the data is used to test the model.

	{"withFeedback": true}—Lets you specify that feedback examples are included in the data 
	to be trained to create the model. If you omit this parameter, feedback examples 
	aren't used in training.

	{"withGlobalDatasetId": <DATASET_ID>}—Lets you specify that a global dataset is 
	used in addition to the specified dataset to create the model.*/
	private String trainParams;

	private Boolean hasEpochs;
	private Boolean hasTrainParams;

	public Einstein_HttpBodyLanguageRetrain(Integer epochs, String modelId, String trainParams){
		if(modelId == null || modelId.equals('')){
			throw new Einstein_Exceptions.ParameterIsEmptyException('ModelId cannont be null');
		}
		if(epochs != null){
			if (epochs <= 0)
				throw new Einstein_Exceptions.NumberLengthException('epochs cannont be less than or equal to 0');
			hasEpochs = true;
		} else {
			hasEpochs = false;
		} 

		if(trainParams == null || trainParams.equals('')){
			this.hasTrainParams = false;
		} else {
			this.hasTrainParams = true;
		}

		this.modelId = modelId;
		this.epochs = epochs;
		this.trainParams = trainParams;
	}


	public blob build(){
		String body = '';
		body += WriteBoundary();
		body += WriteBodyParameter('modelId', this.modelId);
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