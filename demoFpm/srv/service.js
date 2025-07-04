const cds = require('@sap/cds');


module.exports = async (srv) => {
  const { jira } = cds.entities;
  srv.on("createIncidents", async (req) => {
    try {
      let data = req.data;
      let obj = {
        defectID: data.Defect_ID,
        defectDesc: data.Defect_Desc,
        startDate: new Date(),
        endDate: data.Due_Date,
        functionalArea: data.Functional_Area,
        defectStatus: "Open",
        team: data.Resolving_Team,
        assignee: data.Assign_To,
        reporter: "XYZ"
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