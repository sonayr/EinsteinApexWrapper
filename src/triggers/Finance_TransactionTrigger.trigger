/******************************************************************************
Author: Ryan O'Sullivan

Description:Trigger for all events for the Finance_Transaction Object

Test Class:Finance_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
06/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
trigger Finance_TransactionTrigger on Finance_Transaction__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
	
	Finance_TriggerHandler handler = new Finance_TriggerHandler();
	handler.bind(Finance_TriggerHandler.Evt.afterinsert, new Finance_TransactionAfterInsert());
	handler.manage();
}