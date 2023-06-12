/**
 * Created by petrroubal on 11.06.2023.
 */

public with sharing class CountryLayerIntegration {
    private static  final string METHOD_GET = 'GET';
    private static  final string CONTENT_TYPE = 'Content-Type';
    private static  final string APPLICATION_JSON = 'application/json';
    private static  final string URL = 'http://api.countrylayer.com/v2/all?access_key=';
    private static  final string ACCESS_TOKEN = 'be59098f1b4542543675317a5fb4a79c';


    public String sendRequest(){

        String result = '';

        HttpRequest request = new HttpRequest();
        request.setMethod(METHOD_GET);
        request.setHeader(CONTENT_TYPE, APPLICATION_JSON);
        request.setEndpoint(URL + ACCESS_TOKEN);

        Http http = new Http();

        try {
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200 ){
                result = response.getBody();
            }else{
                System.debug('The server is not available, the response code ' + response.getStatusCode() + ' and the response ' + response.getBody());
            }
        }catch(Exception e){
            System.debug('Fatal error within the integration ' + e.getMessage());
        }

        return result;
    }

}