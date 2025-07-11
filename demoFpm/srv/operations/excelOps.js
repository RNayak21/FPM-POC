// const constants = require('../config/constants');
const XLSX = require('xlsx');
const { PassThrough } = require('stream');
// const constants = require('../config/constants');
 
/** 
* handle excel sheet
* @name getExcel
* @public
* @param {array} req 
* @returns output array of object
*/
 
async function getExcel(req) {
 
  let sheetHeader;
  let sheetData;
  let sheetItemData = [];
  const stream = new PassThrough();
  let buffers = [];
  try {
    if (req.data.excel) {
      req.data.excel.pipe(stream);
      let resultData = await new Promise((resolve, reject) => {
        stream.on('data', dataChunk => {
          buffers.push(dataChunk);
        });
        stream.on('end', async () => {
          const buffer = Buffer.concat(buffers);
          const workBook = XLSX.read(buffer, { type: 'buffer', cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', cellNF: true, rawNumbers: false });
          const sheets = workBook.SheetNames
          for (let i = 0; i < sheets.length; i++) {
            const headerRegex = new RegExp('^([A-Za-z]+)1=\'(.*)$');
            const cells = XLSX.utils.sheet_to_formulae(workBook.Sheets[workBook.SheetNames[i]], { cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', rawNumbers: false });
            sheetHeader = cells.filter((item) => headerRegex.test(item)).map((item) => item.split('=\'')[1]);
            const sheetItems = XLSX.utils.sheet_to_json(
              workBook.Sheets[workBook.SheetNames[i]], { cellText: true, cellDates: true, dateNF: 'dd"."mm"."yyyy', rawNumbers: false, defval: '' });
            sheetItems.forEach((res) => {
              sheetItemData.push(JSON.parse(JSON.stringify(res)))
            })
            sheetData = {
              Header: sheetHeader,
              Item: sheetItemData,
            };
          }
          if (sheetData) {
            resolve(sheetData);
          }
        });
      });
      return resultData;
    } else {
      return false;
    }
  }
  catch (ex) {
    return ex;
  }
}
 
module.exports = { getExcel }