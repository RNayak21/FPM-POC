namespace my.bookshop;
using {
  cuid,
  managed
} from '@sap/cds/common';

entity jira : cuid , managed{
  defectID              : String;
  defectDesc            : String;
  startDate             : Timestamp;
  endDate               : Timestamp;
  functionalArea        : String;
  defectStatus          : String;
  team                  : String;    
  assignee              : String;    
  reporter              : String;
}

entity processArea : cuid , managed{
  totalDefects          : String;
  openCount             : String;
  closedCount           : String;
  excededDueDate        : String;    
  inProgressCount       : String;
  functionalArea        : String;
  prcoessAreaManager    : String;
}
