/******************************************************************************
Author: Ryan O'Sullivan

Description:JWT Bearer class to generate a auth token for the Einstein API

Credit to: This is a copied version of the flow taken from 
https://github.com/salesforceidentity/jwt

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_JWTBearerFlow {
	public static String getAccessToken(String tokenEndpoint, Einstein_JWT jwt) {
	
	    String access_token = null;
	    String body = 'grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=' + jwt.issue();
	    HttpRequest req = new HttpRequest();                            
	    req.setMethod('POST');
	    req.setEndpoint(tokenEndpoint);
	    req.setHeader('Content-type', 'application/x-www-form-urlencoded');
	    req.setBody(body);
	    Http http = new Http();               
	    HTTPResponse res = http.send(req);
	    
	    if ( res.getStatusCode() == 200 ) {
	        System.JSONParser parser = System.JSON.createParser(res.getBody());
	        while (parser.nextToken() != null) {
	            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
	                parser.nextToken();
	                access_token = parser.getText();
	                break;
	            }
	        }
	    }
	    return access_token;
	    
	}
}