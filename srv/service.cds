using my.bookshop as my from '../db/schema';

service demoFpm {
    entity JiraEntity as projection on my.jira;
    entity ProcessAreaEntity as projection on my.processArea;

    // type createIncident {
        // Defect_ID : String;
        // Defect_Desc : String;
    // }
    action createIncidents (Defect_ID : String,
                            Defect_Desc: String) returns String;
}
