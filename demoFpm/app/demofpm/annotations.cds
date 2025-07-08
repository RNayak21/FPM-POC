using demoFpm as service from '../../srv/service';
using from '../capabilities';

annotate service.ProcessAreaEntity with @(
 Capabilities :{
    DeleteRestrictions : {
        $Type : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    },
 },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : functionalArea,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

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

    UI.Chart #DefectsChart : {
    $Type:'UI.ChartDefinitionType',
    ChartType:#Column,
    Title:'Defects by Area',
    Dimensions:[ functionalArea ],
    DimensionAttributes:[
      { $Type:'UI.ChartDimensionAttributeType', Dimension:functionalArea, Role:#Category }
    ],
    // Measures:[ TotalDefectsAgg ],
    // MeasureAttributes:[
    //   { $Type:'UI.ChartMeasureAttributeType', Measure:TotalDefectsAgg, Role:#Axis1 }
    // ]
  }
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
            Label : '{i18n>Description}',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : '{i18n>Priority}',
        },
        {
            $Type : 'UI.DataField',
            Value : defectStatus,
            Label : '{i18n>Status}',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : reporter,
            Label : '{i18n>Reporter}'
        },
        {
            $Type : 'UI.DataField',
            Value : assignee,
            Label : '{i18n>Assignee}',
        },
        {
            $Type : 'UI.DataField',
            Value : functionalArea,
            Label : '{i18n>FunctionalArea}',
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
            Value : endDate,
            Label : 'Due Date'
        },
        {
            $Type : 'UI.DataField',
            Value : updatedDate,
            Label : '{i18n>UpdatedDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : completedDate,
            Label : 'Completed Date',
        },
        {
            $Type : 'UI.DataField',
            Value : team,
            Label : 'Resolving Team'
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
        }
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
        Common.Label : '{i18n>JiraId}',
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
        Common.Label : '{i18n>Status}',
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

annotate service.ProcessAreaEntity with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'DetailInformation',
            Target : '@UI.FieldGroup#DetailInformation',
        },
    ],
    UI.FieldGroup #DetailInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : functionalArea,
                Label : 'Functional Area',
            },
            {
                $Type : 'UI.DataField',
                Value : prcoessAreaManager,
                Label : 'Functional Lead',
            },
            {
                $Type : 'UI.DataField',
                Value : totalDefects,
                Label : 'Total No. of Defects',
            },
            {
                $Type : 'UI.DataField',
                Value : openCount,
                Label : 'Open Defects',
            },
            {
                $Type : 'UI.DataField',
                Value : inProgressCount,
                Label : 'In Progress Defects',
            },
            {
                $Type : 'UI.DataField',
                Value : closedCount,
                Label : 'Closed Defects',
            },
            {
                $Type : 'UI.DataField',
                Value : excededDueDate,
                Label : 'No. of Defects with Exceeded Due Date',
            },
        ],
    },
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : excededDueDate,
            Label : 'excededDueDate',
        },
        {
            $Type : 'UI.DataField',
            Value : functionalArea,
            Label : 'functionalArea',
        },
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : inProgressCount,
            Label : 'inProgressCount',
        },
        {
            $Type : 'UI.DataField',
            Value : openCount,
            Label : 'openCount',
        },
        {
            $Type : 'UI.DataField',
            Value : prcoessAreaManager,
            Label : 'prcoessAreaManager',
        },
        {
            $Type : 'UI.DataField',
            Value : totalDefects,
            Label : 'totalDefects',
        },
        {
            $Type : 'UI.DataField',
            Value : closedCount,
            Label : 'closedCount',
        },
    ],
    UI.Chart #defectschart : {
        $Type : 'UI.ChartDefinitionType',
        Title : '{i18n>defectschart}',
        ChartType : #Column,
        Dimensions : [
            functionalArea,
        ],
        DimensionAttributes : [
            {
                $Type : 'UI.ChartDimensionAttributeType',
                Dimension : functionalArea,
                Role : #Category,
            },
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#TotalDefectsAgg',
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DynamicMeasure : '@Analytics.AggregatedProperty#TotalDefectsAgg',
                Role : #Axis1,
            },
        ],
    },
    UI.LineItem #tableMacro1 : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : totalDefects,
            Label : 'totalDefects',
        },
        {
            $Type : 'UI.DataField',
            Value : functionalArea,
            Label : 'functionalArea',
        },
        {
            $Type : 'UI.DataField',
            Value : prcoessAreaManager,
            Label : 'prcoessAreaManager',
        },
        {
            $Type : 'UI.DataField',
            Value : closedCount,
            Label : 'closedCount',
        },
        {
            $Type : 'UI.DataField',
            Value : excededDueDate,
            Label : 'excededDueDate',
        },
        {
            $Type : 'UI.DataField',
            Value : inProgressCount,
            Label : 'inProgressCount',
        },
        {
            $Type : 'UI.DataField',
            Value : openCount,
            Label : 'openCount',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : totalDefects,
            Label : ' totalDefects',
        },
        {
            $Type : 'UI.DataField',
            Value : openCount,
            Label : 'openCount ',
        },
        {
            $Type : 'UI.DataField',
            Value : closedCount,
            Label : 'closedCount',
        },
        {
            $Type : 'UI.DataField',
            Value : excededDueDate,
            Label : 'excededDueDate',
        },
        {
            $Type : 'UI.DataField',
            Value : inProgressCount,
            Label : 'inProgressCount',
        },
        {
            $Type : 'UI.DataField',
            Value : functionalArea,
            Label : 'functionalArea',
        },
    ],
    // UI.Chart #totalDefects : {
    //     $Type : 'UI.ChartDefinitionType',
    //     Title : '{i18n>Defectschart}',
    //     ChartType : #Column,
    //     Dimensions : [
    //         functionalArea,
    //     ],
    //     DimensionAttributes : [
    //         {
    //             $Type : 'UI.ChartDimensionAttributeType',
    //             Dimension : functionalArea,
    //             Role : #Category,
    //         },
    //     ],
    //    Measures:[ totalDefects ],
    // MeasureAttributes:[
    //   { $Type:'UI.ChartMeasureAttributeType', Measure:totalDefects, Role:#Axis1 }
//     // ]
  


//   UI.Chart #DefectsChart: {
//     $Type: 'UI.ChartDefinitionType',
//      Title : '{i18n>Defectschart}',
//     ChartType: #Column,
//     Dimensions: [functionalArea],
//     //DynamicMeasures: [ '@Analytics.AggregatedProperty#TotalDefectsAgg' ],
//     DimensionAttributes: [
//       { $Type:'UI.ChartDimensionAttributeType', Dimension:functionalArea, Role:#Category }
//     ],
//     MeasureAttributes: [
//       {
//         $Type:'UI.ChartMeasureAttributeType',
//         Measure:totalDefects,
//         //DynamicMeasure: '@Analytics.AggregatedProperty#TotalDefectsAgg',
//         Role: #Axis1
//       }
//     ]
//   }
    
);

annotate service.ProcessAreaEntity with @(
  UI.Chart: {
    ChartType: #Column,
    Dimensions: ['functionalArea'],
    Measures: ['openCount', 'closedCount', 'inProgressCount'],
    DimensionAttributes: [
      { Dimension: 'functionalArea', Role: #Category }
    ],
    MeasureAttributes: [
      { Measure: 'openCount', Role: #Axis1 },
      { Measure: 'closedCount', Role: #Axis1 },
      { Measure: 'inProgressCount', Role: #Axis1 }
    ]
  }
);

annotate service.ProcessAreaEntity with @(Aggregation.ApplySupported  : {
    $Type : 'Aggregation.ApplySupportedType',
    Transformations: [
        'aggregate',
        'groupby',
        'filter'
    ]
});


annotate service.taskEntity with @(
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'title',
        },
        {
            $Type : 'UI.DataField',
            Value : tags,
            Label : 'Tags',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
        {
            $Type : 'UI.DataField',
            Value : responsibleTeam,
            Label : 'responsibleTeam',
        },
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : 'priority',
        },
        {
            $Type : 'UI.DataField',
            Value : assignee,
            Label : 'assignee',
        },
    ],
    UI.LineItem #tableMacro1 : [
        {
            $Type : 'UI.DataField',
            Value : taskId,
            Label : '{i18n>TaskId}',
        },
        {
            $Type : 'UI.DataField',
            Value : responsibleTeam,
            Label : 'Responsible Team',
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>TaskDescription}',
        },
        {
            $Type : 'UI.DataField',
            Value : assignee,
            Label : 'Assignee',
        },
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : 'Priority',
        },
        {
            $Type : 'UI.DataField',
            Value : tags,
            Label : 'Tags',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : dueDate,
            Label : 'DueDate',
        },
        
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : taskId,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : 'priority',
        },
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : ' title ',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
        {
            $Type : 'UI.DataField',
            Value : dueDate,
            Label : 'dueDate',
        },
        {
            $Type : 'UI.DataField',
            Value : tags,
            Label : 'tags',
        },
        {
            $Type : 'UI.DataField',
            Value : responsibleTeam,
            Label : 'responsibleTeam',
        },
    ],
);

