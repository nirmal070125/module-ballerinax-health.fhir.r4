// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/time;

public type AuditConfig record {|
    boolean enabled = false;
    string auditServiceUrl;
|};

// Holds the information needed to form an audit event based on the FHIR AuditEvent resource
// http://hl7.org/fhir/R4/auditevent.html
public type InternalAuditEvent record {|
    // Value Set http://hl7.org/fhir/ValueSet/audit-event-type
    // FHIR AuditEvent.type.code
    string typeCode;
    // Value Set http://hl7.org/fhir/ValueSet/audit-event-sub-type
    // FHIR AuditEvent.subtype.code
    string subTypeCode;
    // Value Set http://hl7.org/fhir/ValueSet/audit-event-action
    // FHIR AuditEvent.action
    string actionCode;
    // Value Set http://hl7.org/fhir/ValueSet/audit-event-outcome
    // FHIR AuditEvent.outcome
    string outcomeCode;
    // FHIR AuditEvent.recorded
    string recordedTime;
    // actor involved in the event
    // Value Set http://hl7.org/fhir/ValueSet/participation-role-type
    // FHIR AuditEvent.agent.type.coding.code
    string agentType;
    // FHIR AuditEvent.agent.who.display
    string agentName;
    // FHIR AuditEvent.agent.requestor
    boolean agentIsRequestor;
    // source of the event
    // FHIR AuditEvent.source.observer.display
    string sourceObserverName;
    // Value Set http://hl7.org/fhir/ValueSet/audit-source-type
    // FHIR AuditEvent.source.observer.type
    string sourceObserverType;
    // Value Set http://hl7.org/fhir/ValueSet/audit-entity-type
    // FHIR AuditEvent.entity.type.coding.code
    string entityType;
    // Value Set http://hl7.org/fhir/ValueSet/object-role
    // FHIR AuditEvent.entity.role.coding.code
    string entityRole;
    // Requested relative path - eg.: "Patient/example/_history/1"
    // FHIR AuditEvent.entity.what.reference
    string entityWhatReference;

|};

// Call audit service and handle response.
// @param auditConfig configuration for audit event.
// @param fhirContext context of the request.
// @return FHIRError if audit service call fails.
public isolated function handleAuditEvent(AuditConfig auditConfig, FHIRContext fhirContext) returns FHIRError? {
    FHIRUser? user = fhirContext.getFHIRUser();
    InternalAuditEvent auditEvent = {
        typeCode: "rest",
        subTypeCode: fhirContext.getInteraction().interaction.toString(),
        actionCode: getAction(fhirContext.getInteraction().interaction),
        outcomeCode: fhirContext.isInErrorState() ? "8" : "0",
        recordedTime: time:utcToString(time:utcNow()),
        agentType: "humanuser",
        agentName: user == () ? "Unknown" : (<FHIRUser>user).userID,
        agentIsRequestor: true,
        sourceObserverName: "myfhirserver.com",
        sourceObserverType: "3",
        entityType: "2",
        entityRole: "1",
        entityWhatReference: fhirContext.getRawPath()
    };

    http:Client|http:ClientError auditClient = new (auditConfig.auditServiceUrl);
    if auditClient is http:ClientError {
        return clientErrorToFhirError(auditClient);
    } else {
        InternalAuditEvent|http:ClientError auditRes = auditClient->post("/audits", auditEvent);
        if auditRes is http:ClientError {
            return clientErrorToFhirError(auditRes);
        }
    }
}

isolated function getAction(FHIRInteractionType interaction) returns string {
    match interaction {
        READ|VREAD => {
            return "R";
        }
        CREATE => {
            return "C";
        }
        UPDATE => {
            return "U";
        }
        DELETE => {
            return "D";
        }
        _ => {
            return "E";
        }
    }
}
