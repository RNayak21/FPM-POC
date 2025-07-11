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

  srv.on('getProcessFlowData', async () => {
    return {
      nodes: [
        {
          id: "1",
          lane: "0",
          title: "OPEN",
          titleAbbreviation: "OPEN",
          type: "Single",
          state: "Positive",
          stateText: null,
          focused: false,
          texts: [""],
          highlighted: false,
          children: [
            {
              nodeId: 14,
              connectionLabel: {
                id: "myButtonId1To14",
                text: "First stage",
                enabled: true,
                state: "Critical",
                tooltip: "This is the tooltip text for JIRA"
              }
            }
          ]
        },
        {
          id: "14",
          lane: "1",
          title: "In Progress",
          titleAbbreviation: "In Progress",
          type: "Single",
          state: "Neutral",
          children: [
            {
              nodeId: 20,
              connectionLabel: {
                id: "myButtonId14To20",
                text: "Second Stage",
                enabled: true,
                state: "Positive"
              }
            }
          ]
        },
        {
          id: "20",
          lane: "2",
          title: "Exceeded Due Date",
          titleAbbreviation: "Exceeded Due Date",
          type: "Single",
          state: "Negative",
          children: [
            {
              nodeId: 30,
              connectionLabel: {
                id: "myButtonId20To30",
                text: "Last Stage",
                enabled: true,
                state: "Positive",
                tooltip: "Final stage tooltip"
              }
            }
          ]
        },
        {
          id: "30",
          lane: "3",
          title: "Closed",
          titleAbbreviation: "Closed",
          type: "Single",
          state: "Positive",
          children: [],
          stateText: null,
          focused: true,
          texts: null,
          highlighted: false
        }
      ],
      lanes: [
        {
          id: "0",
          icon: "sap-icon://learning-assistant",
          label: "Open",
          position: 0,
          state: [{ state: "Critical", value: 10 }]
        },
        {
          id: "1",
          icon: "sap-icon://workflow-tasks",
          label: "In Progress",
          position: 1,
          state: [{ state: "Negative", value: 25 }]
        },
        {
          id: "2",
          icon: "sap-icon://status-critical",
          label: "Exceeded Due Date",
          position: 2,
          state: [{ state: "Negative", value: 25 }]
        },
        {
          id: "3",
          icon: "sap-icon://complete",
          label: "Closed",
          position: 3,
          state: [{ state: "Positive", value: 10 }]
        }
      ]
    };});

}