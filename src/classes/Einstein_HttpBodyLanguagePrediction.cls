/******************************************************************************
Author: Ryan O'Sullivan

Description:Http body class for language predictions. Formats the body of the
http request for Prediction api call outs

Test Class:EinStein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_HttpBodyLanguagePrediction extends Einstein_HttpBodyPart{

	// Text for which you want to return an intent prediction.
	private String document;

    /*ID of the model that makes the prediction. 
	The model must have been created from a dataset with a type of text-intent.*/
	private String modelId;

	/*Number of probabilities to return. Optional. If passed, 
	must be a number greater than zero. The response is sorted
	by probability in descending order. For example,
	if you pass in 3, only the top three label
 	and probability values are returned.*/
	private Integer numResults;

	/*String that you can pass in to tag the prediction. 
	Optional. Can be any value, and is returned in the response.*/
	private String sampleId;

	private boolean hasSampleId;
	private boolean hasNumResults;

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Constructor for Language prediction http body class. 
	Sets document,modelid and checks if numResults or sampleid is given.
	
	Return: Instance of HttpBodyLanguagePrediction
	******************************************************************************/
	public Einstein_HttpBodyLanguagePrediction(String document, String modelId, Integer numResults, String sampleId){

		// Check for numResults
		if(numResults == null || numResults == 0){
			hasNumResults = false;
		} else {
			hasNumResults = true;
			this.numResults = numResults;
		}

		// Check for sampleId
		if(sampleId == null || sampleId.equals('')){
			hasSampleId = false;
		} else {
			hasSampleId = true;
			this.sampleId = sampleId;
		}

		this.document = document;
		this.modelId = modelId;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Build function for Language Prediction API call. 
	Puts together the multiForm-part body
	
	Return: blob
	******************************************************************************/
	public blob build(){
		String body = '';
		body += WriteBoundary();
		body += WriteBodyParameter('modelId', this.modelId);	
		body += WriteBoundary();
		body += WriteBodyParameter('document', this.document);
		if(hasNumResults){
			body += WriteBoundary();
			body += WriteBodyParameter('numResults', String.valueof(this.numResults));
		}
		if(hasSampleId){
			body += WriteBoundary();
			body += WriteBodyParameter('sampleId', this.sampleId);
		}
		body += WriteBoundary(EndingType.CrLf);
		Blob bodyBlob = EncodingUtil.base64Decode(body);
		return bodyBlob;
	}
}