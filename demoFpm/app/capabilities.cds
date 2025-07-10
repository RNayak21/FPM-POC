// In db/schema.cds

using {demoFpm} from '../srv/service';

  annotate demoFpm.TeamTaskCount with @(
  Aggregation.ApplySupported: {
    Transformations: ['aggregate','groupby'],
    GroupableProperties: [team],
    AggregatableProperties: [
      { $Type:'Aggregation.AggregatablePropertyType', Property: taskCount }
    ]
  },
  Analytics.AggregatedProperty #TaskCountsAgg: {
    $Type: 'Analytics.AggregatedPropertyType',
    Name: 'TaskCountsAgg',
    AggregationMethod: 'sum',  // or 'count' based on your data
    AggregatableProperty: taskCount,
    ![@Common.Label]: 'Total Defects'
  },
  
);









