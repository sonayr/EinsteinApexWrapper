/******************************************************************************
Author: Ryan O'Sullivan

Description: Object to hold a list of labels

This is a copied version of the Einstein Vision open source library:
https://github.com/muenzpraeger/salesforce-einstein-vision-apex

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05//11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public with sharing class Einstein_LabelSummary {

    @AuraEnabled
    public List<Einstein_Label> labels {get; set;}
}