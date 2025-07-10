const cds = require('@sap/cds');


module.exports = async (srv) => {
  const { jira } = cds.entities;
  srv.on("createIncidents", async (req) => {
    try {
      let data = req.data;
      let oPrioirty;
      if (data.priority == 'High') {
        oPrioirty = {
          code: 'H',
          name: data.priority,
          criticality: 1
        };
      } else if (data.priority == 'Low') {
        oPrioirty = {
          code: 'L',
          name: data.priority,
          criticality: 3
        };
      } else if (data.priority == 'Medium') {
        oPrioirty = {
          code: 'M',
          name: data.priority,
          criticality: 2
        };
      }
      let obj = {
        defectID: data.Defect_ID,
        defectDesc: data.Defect_Desc,
        startDate: new Date(),
        endDate: data.Due_Date,
        functionalArea: data.Functional_Area,
        defectStatus: "Open",
        team: data.Resolving_Team,
        assignee: data.Assign_To,
        reporter: "XYZ",
        priority: oPrioirty
      }
      await cds.run(INSERT.into(jira).entries(obj));
      return {
        status: 201,
        message: "Incident created successfully"
      };
    } catch (error) {
      return req.reject(500, error.message);
    }
  });

}