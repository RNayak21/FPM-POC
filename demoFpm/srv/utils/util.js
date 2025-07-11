async function getPriority(prioriy) {
    if (prioriy == 'High') {
      return  oPrioirty = {
          code: 'H',
          name: prioriy,
          criticality: 1
        };
      } else if (prioriy == 'Low') {
        return oPrioirty = {
          code: 'L',
          name: prioriy,
          criticality: 3
        };
      } else if (prioriy == 'Medium') {
        return  oPrioirty = {
          code: 'M',
          name: prioriy,
          criticality: 2
        };
      }
}
 
module.exports = { getPriority }