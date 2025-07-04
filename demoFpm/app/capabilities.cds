// In db/schema.cds

using {demoFpm} from '../srv/service';

  annotate my.bookshop.processArea with @(
  Aggregation.ApplySupported: {
    Transformations: ['aggregate','groupby'],
    GroupableProperties: [functionalArea],
    AggregatableProperties: [
      { $Type:'Aggregation.AggregatablePropertyType', Property: totalDefects }
    ]
  },
  Analytics.AggregatedProperty #TotalDefectsAgg: {
    $Type: 'Analytics.AggregatedPropertyType',
    Name: 'TotalDefectsAgg',
    AggregationMethod: 'sum',  // or 'count' based on your data
    AggregatableProperty: totalDefects,
    ![@Common.Label]: 'Total Defects'
  },
  
);









