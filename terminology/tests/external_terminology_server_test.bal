import ballerina/test;
// import ballerina/log;
import ballerinax/health.fhir.r4;

@test:BeforeGroups {
    value: ["public_server"]
}
function initializePublicServer(){
    lock{
        finder = new;
        terminologyProcessor.setFinder(<Finder>finder);
    }
}

@test:Config {
    groups: ["findCodeSystem", "public_server", "successful_scenario"]
}
function findCodeSystemPublicServerTest1(){
    lock{
        if (finder == ()) {
            test:assertFail("Error occurred while getting finder from public server terminology processor");
        } else{
            ExternalTerminology cur_finder = <ExternalTerminology>finder;
            r4:CodeSystem|r4:FHIRError response = cur_finder.findCodeSystem(id="encounter-status");
            if (response is r4:FHIRError) {
                test:assertFail("Error occurred while finding code system from public server");
            }
        }
    }
}

@test:Config {
    groups: ["searchCodeSystem", "public_server", "successful_scenario"]
}
function searchCodeSystemPublicServerTest1(){
    // put the damn map here and pass it as a parameter
    lock{
        if (finder == ()) {
            test:assertFail("Error occurred while getting finder from public server terminology processor");
        }
        map<string[]> params = {"_id": ["snomedct"]};
        map<r4:RequestSearchParameter[]> searchParams = prepareRequestSearchParameter(params);
        ExternalTerminology cur_finder = <ExternalTerminology>finder;
        r4:CodeSystem[]|r4:FHIRError response = cur_finder.searchCodeSystem(searchParams);
        if (response is r4:FHIRError) {
            test:assertFail("Error occurred while searching code system from public server");
        }
    }
}

@test:Config {
    groups: ["findConcept", "public_server", "successful_scenario"]
}
function findConceptPublicServerTest1(){
    lock{
        if (finder == ()) {
            test:assertFail("Error occurred while getting finder from public server terminology processor");
        } else{
            ExternalTerminology cur_finder = <ExternalTerminology>finder;
            r4:CodeSystemConcept|r4:FHIRError response = cur_finder.findConcept(system="http://snomed.info/sct", code="expression");
            if (response is r4:CodeSystemConcept) {
                test:assertFail("Error occurred while finding code system from public server");
            }
        }
    }
}

@test:Config {
    groups: ["findValueSet", "public_server", "successful_scenario"]
}
function findValueSetPublicServerTest1(){
    lock{
        if (finder == ()) {
            test:assertFail("Error occurred while getting finder from public server terminology processor");
        } else{
            ExternalTerminology cur_finder = <ExternalTerminology>finder;
            r4:ValueSet|r4:FHIRError response = cur_finder.findValueSet(id="adjudication");
            if (response is r4:FHIRError) {
                test:assertFail("Error occurred while finding code system from public server");
            }
        }
    }
}

@test:Config {
    groups: ["searchValueSet", "public_server", "successful_scenario"]
}
function searchValueSetPublicServerTest1(){
    lock{
        if (finder == ()) {
            test:assertFail("Error occurred while getting finder from public server terminology processor");
        }
        map<string[]> params = {"_id": ["account-aggregate"]};
        map<r4:RequestSearchParameter[]> searchParams = prepareRequestSearchParameter(params);
        ExternalTerminology cur_finder = <ExternalTerminology>finder;
        r4:ValueSet[]|r4:FHIRError response = cur_finder.searchValueSet(searchParams);
        if (response is r4:FHIRError) {
            test:assertFail("Error occurred while searching code system from public server");
        }
    }
}


isolated function prepareRequestSearchParameter(map<string[]> params) returns map<r4:RequestSearchParameter[]> {
    map<r4:RequestSearchParameter[]> searchParams = {};
    foreach var 'key in params.keys() {
        match 'key {
            "_id" => {
                searchParams["_id"] = [createRequestSearchParameter("_id", params.get("_id")[0])];
            }

            "name" => {
                searchParams["name"] = [createRequestSearchParameter("name", params.get("name")[0])];
            }

            "title" => {
                searchParams["title"] = [createRequestSearchParameter("title", params.get("title")[0])];
            }

            "url" => {
                searchParams["url"] = [createRequestSearchParameter("url", params.get("url")[0])];
            }

            "version" => {
                r4:RequestSearchParameter[] tempList = [];
                foreach var value in params.get("version") {
                    tempList.push(createRequestSearchParameter("version", value, 'type = r4:STRING));
                }
                searchParams["version"] = tempList;
            }

            "description" => {
                searchParams["description"] = [createRequestSearchParameter("description", params.get("description")[0])];
            }

            "publisher" => {
                searchParams["publisher"] = [createRequestSearchParameter("publisher", params.get("publisher")[0])];
            }

            "status" => {
                r4:RequestSearchParameter[] tempList = [];
                foreach var value in params.get("status") {
                    tempList.push(createRequestSearchParameter("status", value, 'type = r4:REFERENCE));
                }
                searchParams["status"] = tempList;
            }

            "valueSetVersion" => {
                searchParams["valueSetVersion"] = [createRequestSearchParameter("valueSetVersion", params.get("valueSetVersion")[0])];
            }

            "filter" => {
                searchParams["filter"] = [createRequestSearchParameter("filter", params.get("filter")[0])];
            }

            "_count" => {
                searchParams["_count"] = [createRequestSearchParameter("_count", params.get("_count")[0], 'type = r4:NUMBER)];
            }

            "_offset" => {
                searchParams["_offset"] = [createRequestSearchParameter("_offset", params.get("_offset")[0], 'type = r4:NUMBER)];
            }
        }
    }
    return searchParams;
}

isolated function createRequestSearchParameter(string name, string value, r4:FHIRSearchParameterType? 'type = r4:STRING, r4:FHIRSearchParameterModifier? modifier = r4:MODIFIER_EXACT) returns r4:RequestSearchParameter {
    return {name: name, value: value, 'type: r4:STRING, typedValue: {modifier: modifier}};
}