// Top level schema //
#FrameworkEvaluation: {
    // name of the framework being evaluated
    name: string
    // ID of the framework being evaluated
    frameworkID: string
    // one or more evaluations of the framework controls
    evaluations: [#ControlEvaluation, ...]
}

// Types

#URL: =~"^https?://[^\\s]+$"

#ControlEvaluation: {
    // name of the control being evaluated
    name: string
    // ID of the control being evaluated
    controlID: string
    // one or more assessments of the control requirements
    assessments: [#Assessment, ...]
}

#Assessment: {
    // ID of the requirement being evaluated
    requirementID: string
    // the methods used to assess the requirement
    methods: [#AssessmentMethod, ...]
}

#AssessmentMethod: {
    // the method used to assess the requirement
    name: string
    // detailed explanation of the method
    description: string
    // did it run?
    run: bool
    // the result of the assessment, only present when run is true
    //  * passed when all evidence suggests the control is met
    //  * failed when some evidence suggests the control is not met
    //  * needs_review when evidence was gathered but cannot be reliably interpreted to reach a decision. A human should review the evidence gathered
    //  * error when the method/strategy failed to execute
    result?: "passed" | "failed" | "needs_review | error"
    remediation_guide?: #URL
}
