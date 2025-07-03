using demoFpm as service from '../../srv/service';

annotate service.JiraEntity with @(
    Capabilities : {
        SearchRestrictions : {
            $Type : 'Capabilities.SearchRestrictionsType',
            Searchable: false
        },
        DeleteRestrictions : {
            $Type : 'Capabilities.DeleteRestrictionsType',
            Deletable: true
        },
        InsertRestrictions : {
            $Type : 'Capabilities.InsertRestrictionsType',
            Insertable: true
        },
        UpdateRestrictions : {
            $Type : 'Capabilities.UpdateRestrictionsType',
            Updatable: true
        },
    },
    // UI.Chart #TotalDefectsperUser : {
    //     $Type : 'UI.ChartDefinitionType',
    //     Title : 'DefectsFlow',
    //     ChartType : #Column,
    //     Dimensions : [
    //         defectID,
    //         userId,
    //     ],
    //     DimensionAttributes : [
    //         {
    //             $Type : 'UI.ChartDimensionAttributeType',
    //             Dimension : defectID,
    //             Role : #Category,
    //         },
    //         {
    //             $Type : 'UI.ChartDimensionAttributeType',
    //             Dimension : userId,
    //             Role : #Series,
    //         },
    //     ],
    //     // DynamicMeasures : [
    //     //     '',
    //     // ],
    //     // MeasureAttributes : [
    //     //     {
    //     //         $Type : 'UI.ChartMeasureAttributeType',
    //     //         DynamicMeasure : '',
    //     //         Role : #Axis1,
    //     //     },
    //     // ],

    //      Measures : [
    //         defectID,
    //     ],
    //     MeasureAttributes : [
    //         {
    //             $Type : 'UI.ChartMeasureAttributeType',
    //             Measure : defectID,
    //             Role : #Axis1,
    //         },
    //     ],
    // },
);

annotate service.JiraEntity with @(
    UI.SelectionFields #filterBarMacro : [
        defectID,
        userId,
        functionalArea,
        defectStatus,
    ],
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : defectID,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : defectDesc,
            Label : 'Defect Desc',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : userId,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : defectStatus,
            Label : 'Defect Status',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : functionalArea,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
            Label : 'Start Date',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : assignee,
            Label : 'assignee'
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
            Label : 'endDate'
        },
        {
            $Type : 'UI.DataField',
            Value : reporter,
            Label : 'reporter'
        },
        {
            $Type : 'UI.DataField',
            Value : team,
            Label : 'team'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'demoFpm.EntityContainer/createIncidents',
            Label : 'Create Incident',
        },
    ],
    UI.SelectionPresentationVariant #table : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type : 'UI.PresentationVariantType'
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
                {
                    $Type : 'UI.SelectOptionType',
                    PropertyName : defectID,
                    Ranges : [
                        {
                            Sign : #I,
                            Option : #NE,
                            Low : ' ',
                        },
                    ],
                },
            ],
        },
    },
    UI.HeaderInfo : {
        TypeName : 'Issue',
        TypeNamePlural : 'All Issues',
        Title : {
            $Type : 'UI.DataField',
            Value : defectID,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : defectDesc,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Information',
            ID : 'Information',
            Target : '@UI.FieldGroup#Information',
        },
    ],
    UI.FieldGroup #Information : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : defectDesc,
                Label : 'Defect Description',
            },
            {
                $Type : 'UI.DataField',
                Value : defectID,
            },
            {
                $Type : 'UI.DataField',
                Value : defectStatus,
                Label : 'Defect Status',
            },
            {
                $Type : 'UI.DataField',
                Value : functionalArea,
            },
            {
                $Type : 'UI.DataField',
                Value : userId,
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : 'Reported At',
            },
            {
                $Type : 'UI.DataField',
                Value : assignee,
                Label : 'Assigned To',
            },
            {
                $Type : 'UI.DataField',
                Value : endDate,
                Label : 'Due Date',
            },
            {
                $Type : 'UI.DataField',
                Value : reporter,
                Label : 'Reported By',
            },
            {
                $Type : 'UI.DataField',
                Value : team,
                Label : 'team',
            },
        ],
    },
);

annotate service.JiraEntity with {
    defectID @(
        Common.Label : 'Defect ID',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JiraEntity',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : defectID,
                    ValueListProperty : 'defectID',
                },
            ],
            Label : 'Defect ID',
        },
        Common.ValueListWithFixedValues : false,
        Common.Text : defectStatus,
    )
};

annotate service.JiraEntity with {
    userId @(
        Common.Label : 'User ID',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JiraEntity',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : userId,
                    ValueListProperty : 'userId',
                },
            ],
            Label : 'User ID',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.JiraEntity with {
    functionalArea @(
        Common.Label : 'Functional Area',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JiraEntity',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : functionalArea,
                    ValueListProperty : 'functionalArea',
                },
            ],
            Label : 'Functional Area',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.JiraEntity with {
    assignee @(
        UI.MultiLineText : true,
        Common.FieldControl : #Mandatory,
    )
};

annotate service.JiraEntity with {
    defectStatus @(
        Common.Label : 'DefectStatus',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JiraEntity',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : defectStatus,
                    ValueListProperty : 'defectStatus',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

