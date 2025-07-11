const cds = require('@sap/cds');
const { v4: uuidv4 } = require('uuid');
const dbOps = require('./operations/dbOps')
const excelOps = require('./operations/excelOps')
const util = require('./utils/util')


module.exports = async (srv) => {
  const { jira } = cds.entities;
  srv.on("createIncidents", async (req) => {
    try {
      let data = req.data;
      let oPrioirty = util.getPriority(data.priority);
      let obj = {
        ID : uuidv4(),
        defectID: data.Defect_ID,
        defectDesc: data.Defect_Desc,
        startDate: new Date(),
        endDate: data.Due_Date,
        functionalArea: data.Functional_Area,
        defectStatus: "Open",
        team: data.Resolving_Team,
        assignee: data.Assign_To,
        reporter: "Carla Mathew",
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

  srv.on('PUT', 'JiraExcelUpload', async (req) => {
    let sheetData = await excelOps.getExcel(req);
    let DBInsert = await dbOps.insertExcelJiratoDB(sheetData);
    // logger.info(constants.BTPLogging + "Excel SuccessFully Fetched" + JSON.stringify(sheetData.Item));
    return sheetData;
  });

}