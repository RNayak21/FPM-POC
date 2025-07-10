using my.bookshop as my from '../db/schema';

service demoFpm {
    @odata.draft.enabled
    entity JiraEntity        as projection on my.jira;

    entity taskEntity        as projection on my.task;

    entity ProcessAreaEntity as
        projection on my.processArea {
            key ID                 : String,
                totalDefects       : String,
                openCount          : String,
                closedCount        : String,
                excededDueDate     : String,
                inProgressCount    : String,
                functionalArea     : String,
                prcoessAreaManager : String
        };

    entity JiraIdVH          as
        projection on JiraEntity {
            key defectID
        }

    view FunctionalAreaVH as
        select from JiraEntity distinct {
            key functionalArea
        }

    

    view TeamTaskCount as
        select from taskEntity {
            key responsibleTeam as team,
                count( * )      as taskCount : String
        }
        group by
            responsibleTeam;

    view DefectStatusVH as
        select from JiraEntity distinct {
            key defectStatus
        }

    view TypeVH as
        select from JiraEntity distinct {
            key Type
        }

    action createIncidents(Defect_ID : String  @mandatory  @Common: {Label: 'Defect ID'},
                           Defect_Desc : String  @mandatory  @Common: {Label: 'Defect Description'},
                           Functional_Area : String  @mandatory  @Common: {Label: 'Functional Area'},
                           Due_Date : Timestamp  @mandatory  @Common: {Label: 'Due Date'},
                           Assign_To : String  @mandatory  @Common: {Label: 'Assign To'},
                           Resolving_Team : String  @mandatory  @Common: {Label: 'Resolving Team'},
                           priority : String  @mandatory  @Common: {Label: 'Priority'}  ) returns String;
}
