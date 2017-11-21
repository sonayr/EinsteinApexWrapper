/******************************************************************************
Author: Ryan O'Sullivan

Description:Class to hold TrainParams response body from Einstein API
	
Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
11/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_TrainParams {

	/*Lets you specify the ratio of data used to train the dataset and the data used to test the model. The default split ratio is 0.8;
	 80% of the data is used to train the dataset and create the model and 20% of the data is used to test the model. 
	 If you pass in a split ratio of 0.6, then 60% of the data is used to train the dataset and 
	 create the model and 40% of the data is used to test the model.*/
	@Auraenabled
	public String trainSplitRatio {get;set;}

	/*Lets you specify that feedback examples are included in the data to be trained to create the model. 
	If you omit this parameter, feedback examples aren't used in training.*/
	@Auraenabled
	public String withFeedback {get;set;}

	/*Lets you specify that a global dataset is used in addition to the specified dataset to create the model.*/
	@Auraenabled
	public String withGlobalDatasetId {get;set;}

}