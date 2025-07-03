using my.bookshop as my from '../db/schema';

service demoFpm {
    entity JiraEntity        as projection on my.jira;
    entity ProcessAreaEntity as
        projection on my.processArea {
            Key ID : String,
            totalDefects : String,
            openCount : String,
            closedCount : String,
            excededDueDate : String,
            inProgressCount : String,
            functionalArea : String,
            prcoessAreaManager : String
        };
    action createIncidents(Defect_ID : String  @mandatory  @Common: {Label: 'Defect ID'},
                           Defect_Desc : String  @mandatory  @Common: {Label: 'Defect Description'},
                           Functional_Area : String  @mandatory  @Common: {Label: 'Functional Area'},
                           Due_Date : Timestamp  @mandatory  @Common: {Label: 'Due Date'},
                           Assign_To : String  @mandatory  @Common: {Label: 'Assign To'},
                           Resolving_Team : String  @mandatory  @Common: {Label: 'Resolving Team'}  ) returns String;
}
