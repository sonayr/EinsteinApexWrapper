/******************************************************************************
Author: Ryan O'Sullivan

Description:Class to hold model results when calling get model

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
08/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_Model {

    // Date and time that the model was created.
    @AuraEnabled
    public DateTime createdAt {get; set;}

    // ID of the dataset trained to create the model.
    @AuraEnabled
    public Long datasetId {get; set;}

    // N/A
    @AuraEnabled
    public Integer datasetVersionId {get; set;}
    
    // Number of epochs used during training.
    @AuraEnabled
    public Integer epochs {get; set;}

    // N/A for intent or sentiment models.
    @AuraEnabled
    public Double learningRate {get; set;}

    // ID of the model. Contains letters and numbers.
    @AuraEnabled
    public String modelId {get; set;}

    // Name of the model.
    @AuraEnabled
    public String name {get; set;}

    // Object returned; in this case, training.
    @AuraEnabled
    public String objectType {get; set;}
    
    // How far the training job has progressed. Values are between 0–1.
    @AuraEnabled
    public Decimal progress {get; set;}

    // Where the training job is in the queue. 
    // This field appears in the response only if the status is QUEUED.
    @AuraEnabled
    public Integer queuePosition {get; set;}

    /*
    Status of the training job. Valid values are:

    QUEUED—The training job is in the queue.
    RUNNING—The training job is running.
    SUCCEEDED—The training job succeeded, and you can use the model.
    FAILED—The training job failed.*/
    @AuraEnabled
    public String status {get; set;}

    /*
    Training parameters passed into the request.
     For example, if you sent in a split of 0.7, the response contains "trainParams": {"trainSplitRatio": 0.7}
    */
    @AuraEnabled
    public Einstein_TrainParams trainParams{get; set;}

    // Returns null when you retrain a dataset. Training statistics are returned when the status is SUCCEEDED or FAILED.
    @AuraEnabled
    public Einstein_TrainStats trainStats {get; set;}
    
    // Date and time that the model was last updated.
    @AuraEnabled
    public DateTime updatedAt {get; set;}


    @AuraEnabled
    public String failureMsg {get; set;}

}