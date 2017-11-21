/******************************************************************************
Author: Ryan O'Sullivan

Description:http body class for language feedback submissions. Formats the body of the
http request for Feedback api call outs up update the dataset

Test Class:Einstein_UnitTest	

History:
Date(DD/MM/YYYY)         Developer                    Log
08/11/2017              Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_HttpBodyLanguageFeedback  extends Einstein_HttpBodyPart{
	// Intent or sentiment string to add to the dataset.
	private String document;

	// Correct label for the example. Must be a label that exists in the dataset.
	private String expectedLabel;

	// ID of the model that misclassified the image. The feedback example is added to the dataset associated with this model.
	private String modelId;

	// N/A for intent and sentiment models.
	private String name;


	public Einstein_HttpBodyLanguageFeedback(String document, String expectedLabel, String modelId){
		if(document == null || document.equals('')){
			throw new Einstein_Exceptions.ParameterIsEmptyException('document cannont be null');
		}
		if(expectedLabel == null || document.equals('')){
			throw new Einstein_Exceptions.ParameterIsEmptyException('Expected Label cannont be null');
		}
		if(modelId == null || modelId.equals('')){
			throw new Einstein_Exceptions.ParameterIsEmptyException('Model Id cannont be null');
		}

		this.document = document;
	}

	public blob build(){
		String body = '';
		body += WriteBoundary();
		body += WriteBodyParameter('document', this.document);	
		body += WriteBoundary();
		body += WriteBodyParameter('modelId', this.modelId);
		body += WriteBoundary();
		body += WriteBodyParameter('expectedLabel', this.expectedLabel);	
		body += WriteBoundary(EndingType.CrLf);

		Blob bodyBlob = EncodingUtil.base64Decode(body);
		return bodyBlob;
	}
}