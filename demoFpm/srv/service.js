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
        reporter: "XYZ",
        priority: data.priority
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

  // srv.on('READ',"JiraEntity", async(req)=>{
  //   const columnsToRemove = ['completedDate', 'defectDesc'];
  //   console.log("Before JiraEntitycolumns---->",req.query.columns().SELECT.columns);

  //   req.query.SELECT.columns = req.query.SELECT.columns.filter(col => {
  //     return !(col.ref && columnsToRemove.includes(col.ref[0]));
  //   });
  //   let response = await cds.run(req.query);

  //   console.log("After JiraEntitycolumns---->",req.query.columns().SELECT.columns);

  //   // console.log("JiraEntity---->",req.query);
  //   // console.log("JiraEntitycolumns---->",req.query.columns().SELECT.columns);
  //   // console.log("JiraEntityrows---->",req.query.rows);
  //   //console.log("JiraEntity Response---->",response)
  //   return response;
  // });
  


}