/******************************************************************************
Author: Ryan O'Sullivan

Description:Class used to hold all custom exceptions used in Einstein API

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/	
public class Einstein_Exceptions {

	// Errors around the custom settings
	public class EinsteinSettingsException extends Exception {} 

	// Errors around invaild parameters
	public class ParameterIsEmptyException extends Exception {}

	//Error around String length
	public class StringLengthException extends Exception {}

	//Error around Number length
	public class NumberLengthException extends Exception {}


}