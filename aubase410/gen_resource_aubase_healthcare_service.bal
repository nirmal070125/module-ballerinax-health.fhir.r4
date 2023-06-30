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

// AUTO-GENERATED FILE.
// This file is auto-generated by Ballerina.

import ballerinax/health.fhir.r4;

public const string PROFILE_BASE_AUBASEHEALTHCARESERVICE = "http://hl7.org.au/fhir/StructureDefinition/au-healthcareservice";
public const RESOURCE_NAME_AUBASEHEALTHCARESERVICE = "HealthcareService";

# FHIR AUBaseHealthcareService resource record.
#
# + resourceType - The type of the resource describes
# + serviceProvisionCode - The code(s) that detail the conditions under which the healthcare service is available/offered.
# + extension - May be used to represent additional information that is not part of the basic definition of the resource. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.
# + specialty - Collection of specialties handled by the service site. This is more of a medical term.
# + modifierExtension - May be used to represent additional information that is not part of the basic definition of the resource and that modifies the understanding of the element that contains it and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer is allowed to define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).
# + eligibility - Does this service have specific eligibility requirements that need to be met in order to use the service?
# + language - The base language in which the resource is written.
# + program - Programs that this service is applicable to.
# + 'type - The specific type of service that may be delivered or performed.
# + characteristic - Collection of characteristics (attributes).
# + notAvailable - The HealthcareService is not available during this period of time due to the provided reason.
# + availableTime - A collection of times that the Service Site is available.
# + endpoint - Technical endpoints providing access to services operated for the specific healthcare services defined at this resource.
# + telecom - List of contacts related to this specific healthcare service.
# + id - The logical id of the resource, as used in the URL for the resource. Once assigned, this value never changes.
# + text - A human-readable narrative that contains a summary of the resource and can be used to represent the content of the resource to a human. The narrative need not encode all the structured data, but is required to contain sufficient detail to make it 'clinically safe' for a human to just read the narrative. Resource definitions may define what content should be represented in the narrative to ensure clinical safety.
# + communication - Some services are specifically made available in multiple languages, this property permits a directory to declare the languages this is offered in. Typically this is only provided where a service operates in communities with mixed languages used.
# + referralMethod - Ways that the service accepts referrals, if this is not provided then it is implied that no referral is required.
# + providedBy - The organization that provides this healthcare service.
# + identifier - External identifiers for this item.
# + appointmentRequired - Indicates whether or not a prospective consumer will require an appointment for a particular service at a site to be provided by the Organization. Indicates if an appointment is required for access to this service.
# + active - This flag is used to mark the record to not be used. This is not used when a center is closed for maintenance, or for holidays, the notAvailable period is to be used for this.
# + photo - If there is a photo/symbol associated with this HealthcareService, it may be included here to facilitate quick identification of the service in a list.
# + contained - These resources do not have an independent existence apart from the resource that contains them - they cannot be identified independently, and nor can they have their own independent transaction scope.
# + meta - The metadata about the resource. This is content that is maintained by the infrastructure. Changes to the content might not always be associated with version changes to the resource.
# + name - Further description of the service as it would be presented to a consumer while searching.
# + implicitRules - A reference to a set of rules that were followed when the resource was constructed, and which must be understood when processing the content. Often, this is a reference to an implementation guide that defines the special rules along with other profiles etc.
# + comment - Any additional description of the service and/or any specific issues not covered by the other attributes, which can be displayed as further detail under the serviceName.
# + location - The location(s) where this healthcare service may be provided.
# + category - Identifies the broad category of service being performed or delivered.
# + extraDetails - Extra details about the service that can't be placed in the other fields.
# + availabilityExceptions - A description of site availability exceptions, e.g. public holiday availability. Succinctly describing all possible exceptions to normal site availability as details in the available Times and not available Times.
# + coverageArea - The location(s) that this service is available to (not where the service is provided).
@r4:ResourceDefinition {
    resourceType: "HealthcareService",
    baseType: r4:DomainResource,
    profile: "http://hl7.org.au/fhir/StructureDefinition/au-healthcareservice",
    elements: {
        "serviceProvisionCode" : {
            name: "serviceProvisionCode",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.serviceProvisionCode",
            valueSet: "http://terminology.hl7.org.au/ValueSet/service-provision-conditions"
        },
        "extension" : {
            name: "extension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.extension"
        },
        "specialty" : {
            name: "specialty",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.specialty",
            valueSet: "https://healthterminologies.gov.au/fhir/ValueSet/clinical-specialty-1"
        },
        "modifierExtension" : {
            name: "modifierExtension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.modifierExtension"
        },
        "eligibility" : {
            name: "eligibility",
            dataType: HealthcareServiceEligibility,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.eligibility"
        },
        "language" : {
            name: "language",
            dataType: r4:code,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.language",
            valueSet: "http://hl7.org/fhir/ValueSet/languages"
        },
        "program" : {
            name: "program",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.program",
            valueSet: "http://hl7.org/fhir/ValueSet/program"
        },
        "type" : {
            name: "type",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.type",
            valueSet: "https://healthterminologies.gov.au/fhir/ValueSet/service-type-1"
        },
        "characteristic" : {
            name: "characteristic",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.characteristic"
        },
        "notAvailable" : {
            name: "notAvailable",
            dataType: HealthcareServiceNotAvailable,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.notAvailable"
        },
        "availableTime" : {
            name: "availableTime",
            dataType: HealthcareServiceAvailableTime,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.availableTime"
        },
        "endpoint" : {
            name: "endpoint",
            dataType: r4:Reference,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.endpoint"
        },
        "telecom" : {
            name: "telecom",
            dataType: r4:ContactPoint,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.telecom"
        },
        "id" : {
            name: "id",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.id"
        },
        "text" : {
            name: "text",
            dataType: r4:Narrative,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.text"
        },
        "communication" : {
            name: "communication",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.communication",
            valueSet: "http://hl7.org/fhir/ValueSet/languages"
        },
        "referralMethod" : {
            name: "referralMethod",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.referralMethod",
            valueSet: "http://hl7.org/fhir/ValueSet/service-referral-method"
        },
        "providedBy" : {
            name: "providedBy",
            dataType: r4:Reference,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.providedBy"
        },
        "identifier" : {
            name: "identifier",
            dataType: r4:Identifier,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.identifier"
        },
        "appointmentRequired" : {
            name: "appointmentRequired",
            dataType: boolean,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.appointmentRequired"
        },
        "active" : {
            name: "active",
            dataType: boolean,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.active"
        },
        "photo" : {
            name: "photo",
            dataType: r4:Attachment,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.photo"
        },
        "contained" : {
            name: "contained",
            dataType: r4:Resource,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.contained"
        },
        "meta" : {
            name: "meta",
            dataType: r4:Meta,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.meta"
        },
        "name" : {
            name: "name",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.name"
        },
        "implicitRules" : {
            name: "implicitRules",
            dataType: r4:uri,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.implicitRules"
        },
        "comment" : {
            name: "comment",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.comment"
        },
        "location" : {
            name: "location",
            dataType: r4:Reference,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.location"
        },
        "category" : {
            name: "category",
            dataType: r4:CodeableConcept,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.category",
            valueSet: "http://hl7.org/fhir/ValueSet/service-category"
        },
        "extraDetails" : {
            name: "extraDetails",
            dataType: r4:markdown,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.extraDetails"
        },
        "availabilityExceptions" : {
            name: "availabilityExceptions",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            path: "HealthcareService.availabilityExceptions"
        },
        "coverageArea" : {
            name: "coverageArea",
            dataType: r4:Reference,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            path: "HealthcareService.coverageArea"
        }
    },
    serializers: {
        'xml: r4:fhirResourceXMLSerializer,
        'json: r4:fhirResourceJsonSerializer
    }
}
public type AUBaseHealthcareService record {|
    *r4:DomainResource;

    RESOURCE_NAME_AUBASEHEALTHCARESERVICE resourceType = RESOURCE_NAME_AUBASEHEALTHCARESERVICE;

    BaseAUBaseHealthcareServiceMeta meta = {
        profile : [PROFILE_BASE_AUBASEHEALTHCARESERVICE]
    };
    r4:CodeableConcept[] serviceProvisionCode?;
    r4:Extension[] extension?;
    r4:CodeableConcept[] specialty?;
    r4:Extension[] modifierExtension?;
    HealthcareServiceEligibility[] eligibility?;
    r4:code language?;
    r4:CodeableConcept[] program?;
    r4:CodeableConcept[] 'type?;
    r4:CodeableConcept[] characteristic?;
    HealthcareServiceNotAvailable[] notAvailable?;
    HealthcareServiceAvailableTime[] availableTime?;
    r4:Reference[] endpoint?;
    r4:ContactPoint[] telecom?;
    string id?;
    r4:Narrative text?;
    r4:CodeableConcept[] communication?;
    r4:CodeableConcept[] referralMethod?;
    r4:Reference providedBy?;
    r4:Identifier[] identifier?;
    boolean appointmentRequired?;
    boolean active?;
    r4:Attachment photo?;
    r4:Resource[] contained?;
    string name?;
    r4:uri implicitRules?;
    string comment?;
    r4:Reference[] location?;
    r4:CodeableConcept[] category?;
    r4:markdown extraDetails?;
    string availabilityExceptions?;
    r4:Reference[] coverageArea?;
    never...;
|};

@r4:DataTypeDefinition {
    name: "BaseHealthcareServiceMeta",
    baseType: r4:Meta,
    elements: {},
    serializers: {
        'xml: r4:complexDataTypeXMLSerializer,
        'json: r4:complexDataTypeJsonSerializer
    }
}
public type BaseAUBaseHealthcareServiceMeta record {|
    *r4:Meta;

    //Inherited child element from "Element" (Redefining to maintain order when serialize) (START)
    string id?;
    r4:Extension[] extension?;
    //Inherited child element from "Element" (Redefining to maintain order when serialize) (END)

    r4:id versionId?;
    r4:instant lastUpdated?;
    r4:uri 'source?;
    r4:canonical[] profile = ["http://hl7.org.au/fhir/StructureDefinition/au-healthcareservice"];
    r4:Coding[] security?;
    r4:Coding[] tag?;
|};

# FHIR HealthcareServiceEligibility datatype record.
#
# + extension - May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.
# + code - Coded value for the eligibility.
# + modifierExtension - May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).
# + comment - Describes the eligibility conditions for the service.
# + id - Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.
@r4:DataTypeDefinition {
    name: "HealthcareServiceEligibility",
    baseType: (),
    elements: {
        "extension": {
            name: "extension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
            path: "HealthcareService.eligibility.extension"
        },
        "code": {
            name: "code",
            dataType: r4:CodeableConcept,
            min: 0,
            max: 1,
            isArray: false,
            description: "Coded value for the eligibility.",
            path: "HealthcareService.eligibility.code"
        },
        "modifierExtension": {
            name: "modifierExtension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).",
            path: "HealthcareService.eligibility.modifierExtension"
        },
        "comment": {
            name: "comment",
            dataType: r4:markdown,
            min: 0,
            max: 1,
            isArray: false,
            description: "Describes the eligibility conditions for the service.",
            path: "HealthcareService.eligibility.comment"
        },
        "id": {
            name: "id",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            description: "Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.",
            path: "HealthcareService.eligibility.id"
        }
    },
    serializers: {
        'xml: r4:complexDataTypeXMLSerializer,
        'json: r4:complexDataTypeJsonSerializer
    }
}
public type HealthcareServiceEligibility record {|
    r4:Extension[] extension?;
    r4:CodeableConcept code?;
    r4:Extension[] modifierExtension?;
    r4:markdown comment?;
    string id?;
|};

# HealthcareServiceAvailableTimeDaysOfWeek enum
public enum HealthcareServiceAvailableTimeDaysOfWeek {
   CODE_DAYSOFWEEK_THU = "thu",
   CODE_DAYSOFWEEK_TUE = "tue",
   CODE_DAYSOFWEEK_WED = "wed",
   CODE_DAYSOFWEEK_SAT = "sat",
   CODE_DAYSOFWEEK_FRI = "fri",
   CODE_DAYSOFWEEK_MON = "mon",
   CODE_DAYSOFWEEK_SUN = "sun"
}

# FHIR HealthcareServiceAvailableTime datatype record.
#
# + allDay - Is this always available? (hence times are irrelevant) e.g. 24 hour service.
# + extension - May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.
# + modifierExtension - May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).
# + availableEndTime - The closing time of day. Note: If the AllDay flag is set, then this time is ignored.
# + id - Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.
# + daysOfWeek - Indicates which days of the week are available between the start and end Times.
# + availableStartTime - The opening time of day. Note: If the AllDay flag is set, then this time is ignored.
@r4:DataTypeDefinition {
    name: "HealthcareServiceAvailableTime",
    baseType: (),
    elements: {
        "allDay": {
            name: "allDay",
            dataType: boolean,
            min: 0,
            max: 1,
            isArray: false,
            description: "Is this always available? (hence times are irrelevant) e.g. 24 hour service.",
            path: "HealthcareService.availableTime.allDay"
        },
        "extension": {
            name: "extension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
            path: "HealthcareService.availableTime.extension"
        },
        "modifierExtension": {
            name: "modifierExtension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).",
            path: "HealthcareService.availableTime.modifierExtension"
        },
        "availableEndTime": {
            name: "availableEndTime",
            dataType: r4:time,
            min: 0,
            max: 1,
            isArray: false,
            description: "The closing time of day. Note: If the AllDay flag is set, then this time is ignored.",
            path: "HealthcareService.availableTime.availableEndTime"
        },
        "id": {
            name: "id",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            description: "Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.",
            path: "HealthcareService.availableTime.id"
        },
        "daysOfWeek": {
            name: "daysOfWeek",
            dataType: HealthcareServiceAvailableTimeDaysOfWeek,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "Indicates which days of the week are available between the start and end Times.",
            path: "HealthcareService.availableTime.daysOfWeek"
        },
        "availableStartTime": {
            name: "availableStartTime",
            dataType: r4:time,
            min: 0,
            max: 1,
            isArray: false,
            description: "The opening time of day. Note: If the AllDay flag is set, then this time is ignored.",
            path: "HealthcareService.availableTime.availableStartTime"
        }
    },
    serializers: {
        'xml: r4:complexDataTypeXMLSerializer,
        'json: r4:complexDataTypeJsonSerializer
    }
}
public type HealthcareServiceAvailableTime record {|
    boolean allDay?;
    r4:Extension[] extension?;
    r4:Extension[] modifierExtension?;
    r4:time availableEndTime?;
    string id?;
    HealthcareServiceAvailableTimeDaysOfWeek[] daysOfWeek?;
    r4:time availableStartTime?;
|};

# FHIR HealthcareServiceNotAvailable datatype record.
#
# + extension - May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.
# + modifierExtension - May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).
# + description - The reason that can be presented to the user as to why this time is not available.
# + during - Service is not available (seasonally or for a public holiday) from this date.
# + id - Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.
@r4:DataTypeDefinition {
    name: "HealthcareServiceNotAvailable",
    baseType: (),
    elements: {
        "extension": {
            name: "extension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension.",
            path: "HealthcareService.notAvailable.extension"
        },
        "modifierExtension": {
            name: "modifierExtension",
            dataType: r4:Extension,
            min: 0,
            max: int:MAX_VALUE,
            isArray: true,
            description: "May be used to represent additional information that is not part of the basic definition of the element and that modifies the understanding of the element in which it is contained and/or the understanding of the containing element's descendants. Usually modifier elements provide negation or qualification. To make the use of extensions safe and manageable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension. Applications processing a resource are required to check for modifier extensions. Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource (including cannot change the meaning of modifierExtension itself).",
            path: "HealthcareService.notAvailable.modifierExtension"
        },
        "description": {
            name: "description",
            dataType: string,
            min: 1,
            max: 1,
            isArray: false,
            description: "The reason that can be presented to the user as to why this time is not available.",
            path: "HealthcareService.notAvailable.description"
        },
        "during": {
            name: "during",
            dataType: r4:Period,
            min: 0,
            max: 1,
            isArray: false,
            description: "Service is not available (seasonally or for a public holiday) from this date.",
            path: "HealthcareService.notAvailable.during"
        },
        "id": {
            name: "id",
            dataType: string,
            min: 0,
            max: 1,
            isArray: false,
            description: "Unique id for the element within a resource (for internal references). This may be any string value that does not contain spaces.",
            path: "HealthcareService.notAvailable.id"
        }
    },
    serializers: {
        'xml: r4:complexDataTypeXMLSerializer,
        'json: r4:complexDataTypeJsonSerializer
    }
}
public type HealthcareServiceNotAvailable record {|
    r4:Extension[] extension?;
    r4:Extension[] modifierExtension?;
    string description;
    r4:Period during?;
    string id?;
|};

