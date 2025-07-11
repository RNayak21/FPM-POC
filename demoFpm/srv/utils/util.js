async function getPriority(prioriy) {
    if (prioriy == 'High') {
        oPrioirty = {
          code: 'H',
          name: prioriy,
          criticality: 1
        };
      } else if (prioriy == 'Low') {
        oPrioirty = {
          code: 'L',
          name: prioriy,
          criticality: 3
        };
      } else if (prioriy == 'Medium') {
        oPrioirty = {
          code: 'M',
          name: prioriy,
          criticality: 2
        };
      }
}
 
module.exports = { getPriority }