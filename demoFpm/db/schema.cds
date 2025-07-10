namespace my.bookshop;

using {
  cuid,
  managed,
  sap.common.CodeList
} from '@sap/cds/common';

entity jira : cuid, managed {
  defectID       : String;
  defectDesc     : String;
  startDate      : Timestamp;
  endDate        : Timestamp;
  functionalArea : String;
  defectStatus   : String;
  team           : String;
  assignee       : String;
  reporter       : String;
  priority       : Association to priority @readonly @Common.ValueListWithFixedValues;
  updatedDate    : Timestamp;
  completedDate  : Timestamp;
  Type           :String;
}

entity processArea : cuid, managed {
  totalDefects       : String;
  openCount          : String;
  closedCount        : String;
  excededDueDate     : String;
  inProgressCount    : String;
  functionalArea     : String;
  prcoessAreaManager : String;
  details            : Composition of many processAreaDetails
                         on details.parent = $self;
}

entity processAreaDetails : cuid, managed {
  taskId          : String;
  title           : String;
  assignee        : String;
  status          : String;
  priority        : String;
  dueDate         : Date;
  tags            : String;
  responsibleTeam : String;
  parent          : Association to processArea;
}

entity task : cuid, managed {
  taskId          : String;
  title           : String;
  assignee        : String;
  status          : String;
  priority        : String;
  dueDate         : Date;
  tags            : String;
  responsibleTeam : String;
  
}

entity priority : CodeList {
        key code        : String enum {
                High = 'H';

                Low = 'L';
                Medium = 'M'
            } default 'H'; //> will be used for foreign keys as well
            criticality : Integer; //  2: yellow colour,  3: green colour, 0: unknown

    }
