import ballerina/http;
import health.fhir.r4;
import ballerinax/health.fhir.r4.parser as fhirParser;

isolated ExternalTerminology? finder = ();

final http:Client terminologyServer = check new("https://tx.fhir.org/r4");

public isolated readonly class ExternalTerminology{
    *Finder;
    
    public isolated function addCodeSystems(r4:CodeSystem[] codeSystems) returns r4:FHIRError[]?{
        r4:FHIRError error_ = r4:createFHIRError(
            string `Adding code systems is not supported in the external terminology server`,
            r4:ERROR,
            r4:PROCESSING_NOT_SUPPORTED,
            errorType = r4:PROCESSING_ERROR,
            httpStatusCode = http:STATUS_NOT_IMPLEMENTED
        );
        return [error_];
    }

    public isolated function findCodeSystem(r4:uri? system = (), string? id = (), string? version = ()) returns r4:CodeSystem|r4:FHIRError{
        r4:uri code_system_url = id == () ? string `/CodeSystem` : string `/CodeSystem/${id}`;
        if (version != ()) {
            code_system_url += string `?version=${version}`;
        }
        if (system != ()) {
            if (code_system_url.includes("?")){
                code_system_url += string `&system=${system}`;
            }
            else{
                code_system_url += string `?system=${system}`;
            }
        }

        if (code_system_url.includes("?")) {
            code_system_url += "&_format=json";
        } else {
            code_system_url += "?_format=json";
        }

        lock{
            http:Response|http:ClientError response = terminologyServer->get(code_system_url);
            if (response is http:Response) {
                json|http:ClientError result = response.getJsonPayload();
                if (result is json) {
                    r4:CodeSystem|error parsedResponse = fhirParser:parse(result).ensureType();
                    if (parsedResponse is r4:CodeSystem){
                        return parsedResponse.clone();
                    }
                    return r4:createFHIRError(
                        string `Error while parsing the response to a FHIR CodeSystem resource`,
                        r4:ERROR,
                        r4:PROCESSING_NOT_SUPPORTED,
                        errorType = r4:PROCESSING_ERROR,
                        httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                    );
                }
                return r4:createFHIRError(
                    string `Error while fetching the response to a JSON payload`,
                    r4:ERROR,
                    r4:PROCESSING_NOT_SUPPORTED,
                    errorType = r4:PROCESSING_ERROR,
                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                );
            }
            return r4:createFHIRError(
                string `Error in the response from the terminology server`,
                r4:ERROR,
                r4:PROCESSING_NOT_SUPPORTED,
                errorType = r4:PROCESSING_ERROR,
                httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
            );
        }
    }

    public isolated function searchCodeSystem(map<r4:RequestSearchParameter[]> params, int? offset = (), int? count = ()) returns r4:CodeSystem[]|r4:FHIRError{
        string queryParams = "?";
        if params.keys().length() > 0 {
            string? id = ();
            string? name = ();
            string? title = ();
            string? url = ();
            string? 'version = ();
            string? status = ();
            string? description = ();
            string? publisher = ();

            foreach var item in params.keys() {
                match (item) {
                    "_id" => {
                        id = (<r4:RequestSearchParameter[]>params[item])[0].value;
                        queryParams += string `_id=${<string>id}&`;
                    }

                    "name" => {
                        name = (<r4:RequestSearchParameter[]>params[item])[0].value;
                        queryParams += string `name=${<string>name}&`;
                    }

                    "title" => {
                        title = (<r4:RequestSearchParameter[]>params[item])[0].value;
                        queryParams += string `title=${<string>title}&`;
                    }

                    "url" => {
                        url = (<r4:RequestSearchParameter[]>params[item])[0].value;
                        queryParams += string `url=${<string>url}&`;
                    }

                    "version" => {
                        foreach var p in (<r4:RequestSearchParameter[]>params[item]) {
                            'version = string `${'version ?: ""},${p.value}`;
                        }
                        queryParams += string `version=${<string>'version}&`;
                    }

                    "status" => {
                        foreach var p in (<r4:RequestSearchParameter[]>params[item]) {
                            status = string `${status ?: ""},${p.value}`;
                        }
                        queryParams += string `status=${<string>status}&`;
                    }

                    "description" => {
                        // MySQL like operation will be executed with this value.
                        description = string `%${(<r4:RequestSearchParameter[]>params[item])[0].value.trim().toLowerAscii()}%`;
                        queryParams += string `description=${<string>description}&`;
                    }

                    "publisher" => {
                        // MySQL like operation will be executed with this value.
                        publisher = string `%${(<r4:RequestSearchParameter[]>params[item])[0].value.trim().toLowerAscii()}%`;
                        queryParams += string `publisher=${<string>publisher}&`;
                    }
                }
            }
        } 

        if (queryParams == "?") {
            queryParams = "&_format=json";
        } else {
            queryParams += "_format=json";
        }

        lock{
            http:Response|http:ClientError response = terminologyServer->get(string `/CodeSystem${queryParams}`);
            if (response is http:Response){
                json|http:ClientError payload = response.getJsonPayload();
                if (payload is json){
                    r4:Bundle|error bundle = fhirParser:parse(payload).ensureType();
                    if (bundle is r4:Bundle){
                        r4:CodeSystem[] codeSystems = [];
                        r4:BundleEntry[] entries = <r4:BundleEntry[]>bundle.entry;
                        int cur_cnt = 0;
                        int cur_offset = 0;
                        int counter = 0;
                        if (offset is int){
                            cur_offset = <int>offset;
                        }
                        if (count is int){
                            cur_cnt = <int>count;
                        }
                        foreach r4:BundleEntry entry in entries{
                            r4:DomainResource|error domainResource = entry?.'resource.cloneWithType(r4:DomainResource);
                            if (domainResource is error){
                                return r4:createFHIRError(
                                    string `Error while parsing the response to a FHIR DomainResource`,
                                    r4:ERROR,
                                    r4:PROCESSING_NOT_SUPPORTED,
                                    errorType = r4:PROCESSING_ERROR,
                                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                                );
                            }

                            if (domainResource.resourceType == "CodeSystem" ){
                                counter += 1;
                                if (cur_offset < counter && cur_cnt > 0){
                                    codeSystems.push(<r4:CodeSystem>domainResource);
                                    cur_cnt -= 1;
                                } else if (cur_cnt == 0){
                                    break;
                                }
                            }
                        }
                        return codeSystems.clone();
                    } else{
                        return r4:createFHIRError(
                            string `Error while parsing the response to a FHIR Bundle resource`,
                            r4:ERROR,
                            r4:PROCESSING_NOT_SUPPORTED,
                            errorType = r4:PROCESSING_ERROR,
                            httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                        );
                    }
                } else{
                    return r4:createFHIRError(
                        string `Error while fetching the response to a JSON payload`,
                        r4:ERROR,
                        r4:PROCESSING_NOT_SUPPORTED,
                        errorType = r4:PROCESSING_ERROR,
                        httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                    );
                }
            } else {
                return r4:createFHIRError(
                    string `Error in the response from the terminology server`,
                    r4:ERROR,
                    r4:PROCESSING_NOT_SUPPORTED,
                    errorType = r4:PROCESSING_ERROR,
                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                );
            
            }
        }
    }

    public isolated function addConcepts(r4:uri system, r4:CodeSystemConcept[] concepts, string? version = ()) returns r4:FHIRError[]?{
        r4:FHIRError error_ = r4:createFHIRError(
            string `Adding concepts is not supported in the external terminology server`,
            r4:ERROR,
            r4:PROCESSING_NOT_SUPPORTED,
            errorType = r4:PROCESSING_ERROR,
            httpStatusCode = http:STATUS_NOT_IMPLEMENTED
        );
        return [error_];
    }

    public isolated function findConcept(r4:uri system, r4:code code, string? version = ()) returns r4:CodeSystemConcept|r4:FHIRError{
        r4:CodeSystem|r4:FHIRError code_system = self.findCodeSystem(system, version);
        if (code_system is r4:CodeSystem){
            foreach var concept in <r4:CodeSystemConcept[]>code_system.concept {
                if (concept.code == code) {
                    return concept.clone();
                }
            }
            return r4:createFHIRError(
                string `The concept with the code ${code} is not found in the code system ${system}`,
                r4:ERROR,
                r4:PROCESSING_NOT_FOUND,
                errorType = r4:PROCESSING_ERROR,
                httpStatusCode = http:STATUS_NOT_FOUND
            );
        } else{
            return code_system;
        }
    }

    public isolated function addValueSets(r4:ValueSet[] valueSets) returns r4:FHIRError[]?{
        r4:FHIRError error_ = r4:createFHIRError(
            string `Adding value sets is not supported in the external terminology server`,
            r4:ERROR,
            r4:PROCESSING_NOT_SUPPORTED,
            errorType = r4:PROCESSING_ERROR,
            httpStatusCode = http:STATUS_NOT_IMPLEMENTED
        );
        return [error_];
    }

    public isolated function findValueSet(r4:uri? system = (), string? id = (), string? version = ()) returns r4:ValueSet|r4:FHIRError{
        r4:uri value_set_url = id == () ? string `/ValueSet` : string `/ValueSet/${id}`;
        if (version != ()) {
            value_set_url += string `?version=${version}`;
        }
        if (system != ()) {
            if (value_set_url.includes("?")){
                value_set_url += string `&system=${system}`;
            }
            else{
                value_set_url += string `?system=${system}`;
            }
        }

        if (value_set_url.includes("?")) {
            value_set_url += "&_format=json";
        } else {
            value_set_url += "?_format=json";
        }

        lock{
            http:Response|http:ClientError response = terminologyServer->get(value_set_url);
            if (response is http:Response) {
                json|http:ClientError result = response.getJsonPayload();
                if (result is json) {
                    r4:ValueSet|error parsedResponse = fhirParser:parse(result, targetProfile = "http://hl7.org/fhir/StructureDefinition/ValueSet").ensureType();
                    if (parsedResponse is r4:ValueSet){
                        return parsedResponse.clone();
                    }
                    return r4:createFHIRError(
                        string `Error while parsing the response to a FHIR ValueSet resource`,
                        r4:ERROR,
                        r4:PROCESSING_NOT_SUPPORTED,
                        errorType = r4:PROCESSING_ERROR,
                        httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                    );
                }
                return r4:createFHIRError(
                    string `Error while fetching the response to a JSON payload`,
                    r4:ERROR,
                    r4:PROCESSING_NOT_SUPPORTED,
                    errorType = r4:PROCESSING_ERROR,
                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                );
            }
            return r4:createFHIRError(
                string `Error in the response from the terminology server`,
                r4:ERROR,
                r4:PROCESSING_NOT_SUPPORTED,
                errorType = r4:PROCESSING_ERROR,
                httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
            );
        }
    }

    public isolated function searchValueSet(map<r4:RequestSearchParameter[]> params, int? offset = (), int? count = ()) returns r4:ValueSet[]|r4:FHIRError{
        string queryParams = "?";
        if params.keys().length() > 0 {
            string? id = ();
            string? name = ();
            string? title = ();
            string? url = ();
            string? 'version = ();
            string? status = ();
            string? description = ();
            string? publisher = ();

            foreach var item in params.keys() {
                match (item) {
                    "_id" => {
                        id = (<r4:RequestSearchParameter[]>params[item])[0].value.trim();
                        queryParams += string `_id=${<string>id}&`;
                    }

                    "name" => {
                        name = (<r4:RequestSearchParameter[]>params[item])[0].value.trim();
                        queryParams += string `name=${<string>name}&`;
                    }

                    "title" => {
                        title = (<r4:RequestSearchParameter[]>params[item])[0].value.trim();
                        queryParams += string `title=${<string>title}&`;
                    }

                    "url" => {
                        url = (<r4:RequestSearchParameter[]>params[item])[0].value.trim();
                        queryParams += string `url=${<string>url}&`;
                    }

                    "version" => {
                        foreach var p in (<r4:RequestSearchParameter[]>params[item]) {
                            'version = string `${'version ?: ""},${p.value.trim()}`;
                        }
                        'version = (<string>'version).substring(1);
                        queryParams += string `version=${<string>'version}&`;
                    }

                    "status" => {
                        foreach var p in (<r4:RequestSearchParameter[]>params[item]) {
                            status = string `${status ?: ""},${p.value.trim()}`;
                        }
                        status = (<string>status).substring(1);
                        queryParams += string `status=${<string>status}&`;
                    }

                    "description" => {
                        // MySQL like operation will be executed with this value.
                        description = string `%${(<r4:RequestSearchParameter[]>params[item])[0].value.trim().toLowerAscii()}%`;
                        queryParams += string `description=${<string>description}&`;
                    }

                    "publisher" => {
                        // MySQL like operation will be executed with this value.
                        publisher = string `%${(<r4:RequestSearchParameter[]>params[item])[0].value.trim().toLowerAscii()}%`;
                        queryParams += string `publisher=${<string>publisher}&`;
                    }
                }
            }
        } 

        if (queryParams == "?") {
            queryParams = "?_format=json";
        } else {
            queryParams += "_format=json";
        }

        lock{
            http:Response|http:ClientError response = terminologyServer->get(string `/ValueSet${queryParams}`);
            if (response is http:Response){
                json|http:ClientError payload = response.getJsonPayload();
                if (payload is json){
                    r4:Bundle|error bundle = fhirParser:parse(payload).ensureType();
                    if (bundle is r4:Bundle){
                        r4:ValueSet[] valueSets = [];
                        r4:BundleEntry[] entries = <r4:BundleEntry[]>bundle.entry;
                        int cur_cnt = 0;
                        int cur_offset = 0;
                        int counter = 0;
                        if (offset is int){
                            cur_offset = <int>offset;
                        }
                        if (count is int){
                            cur_cnt = <int>count;
                        }
                        foreach var entry in entries{
                            r4:DomainResource|error domainResource = entry?.'resource.cloneWithType(r4:DomainResource);
                            if (domainResource is error){
                                return r4:createFHIRError(
                                    string `Error while parsing the response to a FHIR DomainResource`,
                                    r4:ERROR,
                                    r4:PROCESSING_NOT_SUPPORTED,
                                    errorType = r4:PROCESSING_ERROR,
                                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                                );
                            }

                            if (domainResource.resourceType == "ValueSet" ){
                                counter += 1;
                                if (cur_offset < counter && cur_cnt > 0){
                                    valueSets.push(<r4:ValueSet>domainResource);
                                    cur_cnt -= 1;
                                } else if (cur_cnt == 0){
                                    break;
                                }
                            }
                        }
                        return valueSets.clone();
                    } else{
                        return r4:createFHIRError(
                            string `Error while parsing the response to a FHIR Bundle resource`,
                            r4:ERROR,
                            r4:PROCESSING_NOT_SUPPORTED,
                            errorType = r4:PROCESSING_ERROR,
                            httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                        );
                    }
                } else{
                    return r4:createFHIRError(
                        string `Error while fetching the response to a JSON payload`,
                        r4:ERROR,
                        r4:PROCESSING_NOT_SUPPORTED,
                        errorType = r4:PROCESSING_ERROR,
                        httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                    );
                }
            } else {
                return r4:createFHIRError(
                    string `Error in the response from the terminology server`,
                    r4:ERROR,
                    r4:PROCESSING_NOT_SUPPORTED,
                    errorType = r4:PROCESSING_ERROR,
                    httpStatusCode = http:STATUS_INTERNAL_SERVER_ERROR
                );
            
            }
        }
    }

}