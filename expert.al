codeunit 50109 JsonTable
{

    procedure Refresh();
 
    var
        // ALIssue: Record ALIssue;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        i: Integer;

    begin
        // ALIssue.DeleteAll;

        //web service call
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        if not HttpClient.Get('https://api.github.com/repos/Microsoft/AL/issues',
        ResponseMessage)
        then
            Error('Call service failed');

        if not ResponseMessage.IsSuccessStatusCode then
            error('Web service returned an error:\\' + 'Status code: %1\' + 'Description: %2',
            ResponseMessage.HttpStatusCode,
            ResponseMessage.ReasonPhrase);

        ResponseMessage.Content.ReadAs(JsonText);

        // process JSON response
        if not JsonArray.ReadFrom(JsonText) then
            Error('Invalid response, expected an JSON array as root object');
        for i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            JsonObject := JsonToken.AsObject;

            // ALIssue.init;
            // if not JsonObject.Get('id',JsonToken) then
            // Error('could not find token with key %1');

            // ALIssue.id := JsonToken.AsValue.AsInteger;

            // ALIssue.number := GetJsonToken(JsonObject,'number').AsValue.AsInteger;
            // ALIssue.title := GetJsonToken(JsonObject,'title').AsValue.AsText;
            // ALIssue.user := SelectJsonToken(JsonObject, '$.user.login').Asvalue.AsText;
            // ALIssue.state := GetJsonToken(JsonObject,'state').AsValue.AsText;
            // ALIssue.html_url := GetJsonToken(JsonObject,'html_url').AsValue.AsText;
            // ALIssue.Insert;

        end;

    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('could not find token with path %1', Path);
    end;
}
