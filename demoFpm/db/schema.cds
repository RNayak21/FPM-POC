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
  //to_Task       : Association to many task on to_Task.to_Jira = $self;
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

entity task : cuid, managed {
  taskId                : String;    
  title                 : String;
  assignee              : String;
  status                : String;
  priority              : String;
  dueDate               : Date;
  tags                  : String;  
  responsibleTeam       : String;
   
}