/******************************************************************************
Author: Ryan O'Sullivan

Description: Object to hold Dataset information


Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05//11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_Dataset {

    //  Specifies whether the dataset is ready to be trained.
    @AuraEnabled
    public Boolean available {get; set;}

    // Date and time that the model was created.
    @AuraEnabled
    public DateTime createdAt {get; set;}
    
    //Dataset ID.
    @AuraEnabled
    public Long id {get; set;}

    // Contains the labels array that contains all the labels for the dataset.
    @AuraEnabled
    public Einstein_LabelSummary labelSummary {get; set;}

    //Name of the dataset. The API uses the name of the file for the dataset name.
    @AuraEnabled
    public String name {get; set;}

    // Object returned; in this case, dataset.
    @AuraEnabled
    public String objectString{get;set;}

    // Specifies whether the dataset is ready to be trained.
    @AuraEnabled
    public String statusMsg {get; set;}

    // Total number of examples in the dataset.
    @AuraEnabled
    public Long totalExamples {get; set;}

    /*  Type of dataset data. Valid values are:
    text-intent
    text-sentiment*/
    @AuraEnabled
    public String typeString {get; set;}

    // Date and time that the dataset was last updated.
    @AuraEnabled
    public DateTime updatedAt {get; set;}
}