/******************************************************************************
Author: Ryan O'Sullivan

Description:Prediction object to hold Einstien Predictions

Test Class:Einstien_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_Prediction {
	// Array of probabilities for the prediction.
	@AuraEnabled
	public Einstein_Probability[] probabilities {get;set;}

	// Value passed in when the prediction call was made. Returned only if the sampleId request parameter is provided.
	@AuraEnabled
	public String sampleId {get;set;}
}