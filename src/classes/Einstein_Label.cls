/******************************************************************************
Author: Ryan O'Sullivan

Description: Object to hold Label information

This is a copied version of the Einstein Vision open source library:
https://github.com/muenzpraeger/salesforce-einstein-vision-apex

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05//11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public with sharing class Einstein_Label {
    @AuraEnabled
    public Integer id {get; set;}
    @AuraEnabled
    public Integer datasetId {get; set;}
    @AuraEnabled 
    public String name {get; set;}
    @AuraEnabled
    public Integer numExamples {get; set;}
}