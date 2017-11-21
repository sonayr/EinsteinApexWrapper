/******************************************************************************
Author: Ryan O'Sullivan

Description:Extension of HttpBodyPart used for Creating Intent Datasets

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public with sharing class Enistein_HttpBodyIntentDataSet extends Einstein_HttpBodyPart{

	private String url;
	Final private String INTENT = 'text-intent';

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Constructor which uses a URL entry
	
	Return: Instance of Enistein_HttpBodyIntentDataSet
	******************************************************************************/
	public Enistein_HttpBodyIntentDataSet(String url) {
		this.setUrl(url);
	}


	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:URL getter
	
	Return: String value of URL
	******************************************************************************/
	public String getUrl(){
		return url;
	}

	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:URL Setter, throws error if url is null/empty
	
	Return: null
	******************************************************************************/
	public void setUrl(String url){
		if(url == null || url.equals(' ')){
			throw new Einstein_Exceptions.ParameterIsEmptyException('Url cannot be null');
		}
		this.url = url;
	}


	/*****************************METHOD DESCRIPTION*******************************
	Author:Ryan O'Sullivan
	Date:05/11/2017
	
	Description:Build the multiform part body with the needed components for an
	intent message
	
	Return: Blob of the body for httpclient to send
	******************************************************************************/
	public Blob build() {
		String body = '';
		body += WriteBoundary();
		body += WriteBodyParameter('path',this.url);
		body += WriteBoundary();
		body += WriteBodyParameter('type',INTENT);
		body += WriteBoundary(EndingType.CrLf);
		Blob bodyBlob = EncodingUtil.base64Decode(body);
		return bodyBlob;
	}
}