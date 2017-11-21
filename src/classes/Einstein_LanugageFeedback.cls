/******************************************************************************
Author: Ryan O'Sullivan

Description:Response returned when sending feedback to the language API 
(Intent / Sentiment)

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
10/11/2017               Ryan O'Sullivan              Created
******************************************************************************/	
public class Einstein_LanugageFeedback {

	// Date and time that the feedback example was created.
	@AuraEnabled
	public DateTime createdAt {get;set;}

	// ID of the feedback example.
	@AuraEnabled
	public long feedbackId {get;set;}

	// Contains information about the label that the feedback example is associated with.
	@AuraEnabled
	public Einstein_Label label {get;set;}

	// Feedback text.
	@AuraEnabled
	public String location {get;set;}

	// N/A for intent and sentiment models.
	@AuraEnabled
	public string name {get;set;}

	// Object returned; in this case, example.
	@AuraEnabled
	public String objectName {get;set;}

}