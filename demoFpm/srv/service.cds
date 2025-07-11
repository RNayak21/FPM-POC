using my.bookshop as my from '../db/schema';


service demoFpm {
    @odata.draft.enabled
    entity JiraEntity        as projection on my.jira;

    entity taskEntity        as projection on my.task;

     entity ProcessAreaEntity        as projection on my.processArea;
    entity ProcessAreaDetailsEntity as projection on my.processAreaDetails;

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

    @cds.persistence.skip
    @odata.singleton
    entity JiraExcelUpload {
        @Core.MediaType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        excel : LargeBinary;
    };

    
  
 

    action createIncidents(Defect_ID : String  @mandatory  @Common: {Label: 'Defect ID'},
                           Defect_Desc : String  @mandatory  @Common: {Label: 'Defect Description'},
                           Functional_Area : String  @mandatory  @Common: {Label: 'Functional Area'},
                           Due_Date : Timestamp  @mandatory  @Common: {Label: 'Due Date'},
                           Assign_To : String  @mandatory  @Common: {Label: 'Assign To'},
                           Resolving_Team : String  @mandatory  @Common: {Label: 'Resolving Team'},
                           priority : String  @mandatory  @Common: {Label: 'Priority'}  ) returns String;

    function getProcessFlowData() returns ProcessFlowData;
 
   
    type ConnectionLabel {
        id      : String;
        text    : String;
        enabled : Boolean;
        state   : String;
        tooltip : String;
    }
 
    type Child {
        nodeId          : Integer;
        connectionLabel : ConnectionLabel;
    }
 
    type Node {
        id                : String;
        lane              : String;
        title             : String;
        titleAbbreviation : String;
        type              : String;
        state             : String;
        stateText         : String;
        focused           : Boolean;
        texts             : many String;
        highlighted       : Boolean;
        children          : many Child;
    }
 
    type StateInfo {
        state : String;
        value : Integer;
    }
 
    type Lane {
        id       : String;
        icon     : String;
        label    : String;
        position : Integer;
        state    : many StateInfo;
    }
 
    type ProcessFlowData {
        nodes : many Node;
        lanes : many Lane;
    }
}
