using demoFpm as service from '../../srv/service';
using from '../capabilities';
using from '../../db/schema';


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
    
    Capabilities          : {
        NavigationRestrictions: {
            $Type               : 'Capabilities.NavigationRestrictionsType',
            RestrictedProperties: [{
                $Type             : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty: DraftAdministrativeData,
                FilterRestrictions: {
                    $Type     : 'Capabilities.FilterRestrictionsType',
                    Filterable: false,
                },
            }, ],
        },
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
  },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'demoFpm.EntityContainer/createIncidents',
            Label : '{i18n>CreateJiraIncident}',
            Determining : true,
        },
    ],
);

annotate service.JiraEntity with @(
    UI.SelectionFields #filterBarMacro : [
        defectID,
        functionalArea,
        defectStatus,
        priority.name,
        Type,
    ],
    UI.LineItem #tableMacro : [
        {
            $Type : 'UI.DataField',
            Value : defectID,
        },
        {
            $Type : 'UI.DataField',
            Value : priority.name,
            Label : '{i18n>Priority}',
            Criticality : priority.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : assignee,
            Label : '{i18n>Assignee}',
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
            $Type : 'UI.DataFieldForAction',
            Action : 'demoFpm.EntityContainer/createIncidents',
            Label : '{i18n>CreateJiraIncident}',
        },
         {
            $Type : 'UI.DataField',
            Value : modifiedBy,
             ![@UI.Hidden] : true
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
              ![@UI.Hidden] : true
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
              ![@UI.Hidden] : true
        },
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
              ![@UI.Hidden] : true
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt,
              ![@UI.Hidden] : true
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
                ![@UI.PartOfPreview] : false
            },
            {
                $Type : 'UI.DataField',
                Value : defectStatus,
                Label : 'Defect Status',
                ![@UI.PartOfPreview] : false
            },
            {
                $Type : 'UI.DataField',
                Value : functionalArea,
            },
            {
                $Type : 'UI.DataField',
                Value : startDate,
                Label : 'Reported At',
                ![@UI.PartOfPreview] : false
            },
            {
                $Type : 'UI.DataField',
                Value : assignee,
                Label : 'Assigned To',
                ![@UI.PartOfPreview] : false
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
                ![@UI.PartOfPreview] : false
            },
            {
                $Type : 'UI.DataField',
                Value : team,
                Label : '{i18n>Team}',
                ![@UI.PartOfPreview] : false
            },
            {
                $Type : 'UI.DataField',
                Value : comment,
                Label : 'Comment',
            },
        ],
    },

    Capabilities.FilterRestrictions:{
        FilterExpressionRestrictions:[
            {
                Property:'Type',
                AllowedExpressions:'SingleValue'
            }
        ]
    }
);

annotate service.JiraEntity with {
    defectID @(
        Common.Label : '{i18n>JiraId}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'JiraIdVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : defectID,
                    ValueListProperty : 'defectID',
                },
            ],
            Label : '{i18n>DefectId}',
        },
        Common.ValueListWithFixedValues : false,
        )
};

annotate service.JiraEntity with {
    functionalArea @(
        Common.Label : 'Functional Area',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'FunctionalAreaVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : functionalArea,
                    ValueListProperty : 'functionalArea',
                },
            ],
            Label : '{i18n>FunctionalArea}',
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
            CollectionPath : 'DefectStatusVH',
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
annotate service.TeamTaskCount with @(
    UI.Chart #defectschart : {
        $Type : 'UI.ChartDefinitionType',
        Title : '{i18n>defectschart}',
        ChartType : #Column,
        Dimensions : [
            team,
        ],
        DimensionAttributes : [
            {
                $Type : 'UI.ChartDimensionAttributeType',
                Dimension : team,
                Role : #Category,
            },
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#TaskCountsAgg',
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DynamicMeasure : '@Analytics.AggregatedProperty#TaskCountsAgg',
                Role : #Axis1,
            },
        ],
    },
);

annotate service.JiraEntity with {
    Type @(
        Common.Label : 'Type',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'TypeVH',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Type,
                    ValueListProperty : 'Type',
                },
            ],
            Label : '{i18n>Type}',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.JiraEntity with {
    priority @(
        Common.Label : '{i18n>Priority}',
        Common.Text : priority.name,
    )
};

annotate service.priority with {
    name @(
        Common.Label : '{i18n>Priority}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'priority',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
            Label : '{i18n>Priority}',
        },
        Common.ValueListWithFixedValues : true,
    )
};

