const cds = require('@sap/cds');
const { v4: uuidv4 } = require('uuid');
const util = require('../utils/util');

const { jira } = cds.entities;

async function insertExcelJiratoDB(jiraRecords) {
    try {
        let insertRecords = [];
        let data = jiraRecords.Item;
        data.forEach(record => {
            let oPrioirty = util.getPriority(record['Priority']);
            const oPayload = {
                ID : uuidv4(),
                defectID: record['JIRA ID'],
                defectDesc: record['Description'],
                startDate: new Date(),
                endDate: record['Due Date'],
                functionalArea: record['Functional Area'],
                defectStatus: 'Open',
                team: record['Resolving Team'],
                assignee: record['Assignee'],
                reporter: record['Reporter'],
                priority: oPrioirty
            };
            insertRecords.push(oPayload);
        });
        await cds.run(INSERT.into(jira).entries(insertRecords));

    }
    catch (error) {
        return req.reject(500, error.message);;
    }
}

module.exports = { insertExcelJiratoDB }