/******************************************************************************
Author: Ryan O'Sullivan

Description:Class to hold TrainStats response body for Einstein API

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
11/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_TrainStats {

	// Time it took to load the dataset to be trained.
	@AuraEnabled
	public String datasetLoadTime {get;set;}

	// Total number of examples in the dataset from which the model was created.
	@AuraEnabled
	public Integer examples {get;set;}


	// Total number of labels in the dataset from which the model was created.
	@AuraEnabled
	public Integer labels {get;set;}

	// Number of the last training iteration that completed.
	@AuraEnabled
	public Integer lastEpochDone {get;set;}


	// Time it took to save the model.
	@AuraEnabled
	public String modelSaveTime {get;set;}


	// Number of examples (from the dataset total number of examples) used to test the model. testSplitSize + trainSplitSize is equal to examples.
	@AuraEnabled
	public Integer testSplitSize {get;set;}


	// Total training time: datasetLoadTime + trainingTime + modelSaveTime
	@AuraEnabled
	public String totalTime {get;set;}


	// Time it took to train the dataset to create the model.
	@AuraEnabled
	public String trainingTime {get;set;}

	// Number of examples (from the dataset total number of examples) used to train the model. trainSplitSize + testSplitSize is equal to examples.
	@AuraEnabled
	public String traingSplitSize {get;set;}
}