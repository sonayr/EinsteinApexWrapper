/******************************************************************************
Author: Ryan O'Sullivan

Description:Object to hold Probability information from predictions

Test Class:Einstien_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/	
public class Einstein_Probability {
	// Probability label for the input.
	@AuraEnabled
	public String label {get;set;}

	// Probability value for the input. Values are between 0–1.
	@AuraEnabled
	public Decimal probability {get;set;}
}