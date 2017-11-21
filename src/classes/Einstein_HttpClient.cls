/******************************************************************************
Author: Ryan O'Sullivan


Description: Client that does http communication to Einstein API.
Headers are set in this class

This class is copied from the Einstein Vision open source library:
https://github.com/muenzpraeger/salesforce-einstein-vision-apex

Test Class:Einstein_UnitTest

History:
Date(DD/MM/YYYY)         Developer                    Log
05/11/2017               Ryan O'Sullivan              Created
******************************************************************************/
public class Einstein_HttpClient {

    public static final Integer NO_CONTENT = 204;

    private String url;
    private Boolean isDelete = false;
    private Boolean isPost = false;
    private Boolean isPut = false;
    private Einstein_Service einsteinService;
    private JSONParser parser;
    private Blob body;

    // Values for HTTP response
    private String errorMessage;
    private Integer statusCode;
    private String statusMessage;





    public Einstein_HttpClient(Einstein_Service einsteinService, String url) {
        this.einsteinService = einsteinService;
        this.url = url;
    }

    public Einstein_HttpClient(Einstein_Service einsteinService, String url, Blob body) {
        this.einsteinService = einsteinService;
        this.url = url;
        this.body = body;
        isPost(true);
    }

    public boolean isDelete() {
        return isDelete;
    }

    public void isDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public boolean isPost() {
        return isPost;
    }

    public void isPost(boolean isPost) {
        this.isPost = isPost;
    }
    
    public boolean isPut() {
        return isPut;
    }

    public void isPut(boolean isPut) {
        this.isPut = isPut;
    }

    public void execute() {
        if (url!=null) {
            
            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + this.einsteinService.getBearerToken());
            request.setHeader('Cache-Control', 'no-cache');
            
            request.setMethod('GET');

            if (isDelete()) {
                request.setMethod('DELETE');
            } else if (isPost() || isPut()) {
                request.setHeader('Content-Type', Einstein_HttpBodyPart.GetContentType());
                request.setBodyAsblob(body);
                if (isPut()) {
                    request.setMethod('PUT');
                } else {
                    request.setMethod('POST');
                }
            }

            request.setEndpoint(url);

             Http http = new Http();
             HTTPResponse response = http.send(request);

            einsteinService.isExecuting(true);
            
            updateResponseValues(response);
        }
    }

    public Boolean isError() {
        return (getStatusCode()!=200 && getStatusCode()!=204);
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public String getResponseError() {
        return errorMessage;
    }

    private void updateResponseValues(HTTPResponse response) {
        statusCode = response.getStatusCode();
        statusMessage = response.getStatus();
        if (getStatusCode()==400 || getStatusCode()==200) {
            try {
                parser = JSON.createParser(response.getBody());
            } catch (Exception e) {
                errorMessage = 'Could not read JSON data';
                return;
            }
            if (getStatusCode()==200) {
                Boolean hasDataToken = false;
                while (parser.nextToken()!=null) {
                    if (parser.getCurrentToken()==JSONToken.FIELD_NAME) {
                        String currentProperty = parser.getText();
                        if (currentProperty=='data' || currentProperty=='metricsData') {
                            parser.nextToken();
                            hasDataToken = true;
                            break;
                        }
                    }
                }
                if (!hasDataToken) {
                    parser = JSON.createParser(response.getBody());
                }
            } else {
                while (parser.nextToken()!=null) {
                    if (parser.getCurrentToken()==JSONToken.FIELD_NAME) {
                        String currentProperty = parser.getText();
                        if (currentProperty=='message') {
                            parser.nextToken();
                            errorMessage = parser.getText();
                            break;
                        }
                    }
                }
            }
        }
        einsteinService.isExecuting(false);
    }

    public String getUrl() {
        return url;
    }

    public JSONParser getParser() {
        return parser;
    }

}