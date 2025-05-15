package schemas
@go(layer2)

// Catalog describes a collection or catalog of technology-specific, threat-informed security controls
// that can be applied to an information system.
#Catalog: {
    metadata?: #Metadata
    // one or more ControlFamily objects
    "control-families"?: [...#ControlFamily] @go(ControlFamilies)
    // zero or more Threats that are mitigated by the controls in the ControlFamilies
    threats?: [...#Threat] @go(Threats)
    // zero or more Capabilities in use that inform the controls in the ControlFamilies
    capabilities?: [...#Capability] @go(Capabilities)
    // zero or more mapping references to controls defined in this or other Layer2 frameworks or standards
    "shared-controls"?: [...#Mapping] @go(SharedControls)
    // zero or more mapping references to threats defined in this or other Layer2 frameworks or standards
    "shared-threats"?: [...#Mapping] @go(SharedThreats)
    // zero or more mapping references to capabilities defined in this or other Layer2 frameworks or standards
    "shared-capabilities"?: [...#Mapping] @go(SharedCapabilities)
}

#Metadata: {
    // unique identifier for the Layer2 collection
    id: string
    // name for the Layer2 collection
    title: string
    // description of the Layer2 collection
    description: string
    version?: string
    // timestamp of the last modification to the Layer2 collection
    "last-modified"?: string @go(LastModified)
    // AssessmentLevels is a list of values used to categorize the AssessmentRequirements of the Controls in this Layer2 collection. For example, the NIST 800-53 controls are categorized as low, moderate, and high baselines and if this Layer2 collection contained those NIST 800-53 controls, the AssessmentLevels would be "low", "moderate", and "high".
    "assessment-levels"?: [...#AssessmentLevel] @go(AssessmentLevels)
    // List of applicable references to Layer 1 guidance, technical capabilities and threats that inform the Layer2 collection
    "mapping-references"?: [...#MappingReference] @go(MappingReferences)
}

// AssessmentLevel defines a logical grouping of controls by level.
#AssessmentLevel: {
    // unique identifier for the level
    id: string
    // name of the level
    title: string
    // description of the level
    description: string
}

// ControlFamily is a collection of security controls that are grouped together based on a common theme or purpose. Control families are used to organize and categorize security controls within a Layer2 framework or standard.
#ControlFamily: {
    // name of the control family
    title: string
    // description of the control family
    description: string
    // the Controls that are part of this ControlFamily
    controls: [...#Control]
}

// Controls are the specific guardrails that organizations put in place to protect their information systems. They are typically informed by the best practices and industry standards which are produced in Layer 1. Controls are typically developed by an organization for its own purposes, or for general use by industry groups, government agencies, or international standards bodies.
#Control: {
    // unique identifier for the control
    id: string
    // name of the control
    title: string
    // the intended outcome of applying the control
    objective: string
    // the assessment requirements that are used to determine if the control is met
    "assessment-requirements": [...#AssessmentRequirement] @go(AssessmentRequirements)
    // references to layer 1 guidance or standards that inform the control
    "guidance-mappings"?: [...#Mapping] @go(GuidanceMappings)
    // references to threats that are mitigated by the control
    "threat-mappings"?: [...#Mapping] @go(ThreatMappings)
}

// Threats are circumstances or events with the potential to adversely impact organizational operations (including mission, functions, image, or reputation), organizational assets, or individuals through an information system via unauthorized access, destruction, disclosure, modification of information, and/or denial of service. Also, the potential for a threat-source to successfully exploit a particular information system vulnerability.
#Threat: {
    // unique identifier for the threat
    id: string
    // name of the threat
    title: string
    // description of the threat
    description: string
    // references to the information system capabilities at risk from the threat
    capabilities: [...#Mapping]
    // references Layer 1 threat guidance or catalogs
    "external-mappings"?: [...#Mapping] @go(ExternalMappings)
}

// Capability is a function or feature of an information system to which Controls and Threats may apply.
#Capability: {
    // unique identifier for the capability
    id: string
    // name of the capability
    title: string
    // description of the capability
    description: string
}

// MappingReference is a detailed reference to a specific control, threat, or capability in a Layer 1 framework or standard. The MappingReference object contains the unique identifier, title, version, and optional description and URL for the reference.
#MappingReference: {
    // unique identifier for the mapping reference
    id: string
    // name of the mapping reference
    title: string
    // version of the mapping reference
    version: string
    // description of the mapping reference
    description?: string
    // url providing detailed information about the referenced control, threat, or capability
    url?: =~"^https?://[^\\s]+$"
}

// Mapping is a reference to one or more controls, threats, or capabilities within a MappingReference
#Mapping: {
    // unique identifier of the mapping reference this mapping refers to
    "reference-id": string @go(ReferenceId)
    // list of unique identifiers for the controls, threats, or capabilities in the mapping reference
    identifiers: [...string]
}

// AssessmentRequirement describes the specific requirements that must be met in order to demonstrate compliance with a control. Each AssessmentRequirement object contains a unique identifier, text description, applicability list and optional recommendation for the requirement.
#AssessmentRequirement: {
    // unique identifier for the assessment requirement
    id: string
    // text description of the assessment requirement
    text: string
    // list of ApplicabilityLevel ID values that define which assessment levels the requirement applies to
    // for example, if the requirement applies to all levels, the list would be ["low", "moderate", "high"]
    // if the requirement applies to only one level, the list would be ["high"]
    levels: [...string]
    // text providing clear guidance on how to meet the assessment requirement
    recommendation?: string
}
