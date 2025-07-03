// // const cds = require("@sap/cds")

// // class demofpm{
// //     this.on("READ", "BookedFlights", async (context, next) => {
// //         var bookedFlights = await next()
// //         if (context.query.SELECT.columns && context.query.SELECT.columns.find(c => c.as === 'CountFlights')) {
// //           return [...new Set(await (await _readBookedFlightsAllAirlines(bookedFlights.filter(obj => obj.to_Customer_CustomerID != null && obj.AirlineID != null), context)))]       
// //         }
// //         return bookedFlights
// //       })    
  
// //       const _readBookedFlightsAllAirlines = async (bookedFlights, context) => {
// //         var flightsPerCustomer = []
// //         for (const each of bookedFlights) {
// //           if(each.to_Customer_CustomerID === null) {continue}
// //           await _readBookings(context, each)
// //             .then((result) => {
// //               var bookings = result[0]
// //               var airlines = result[1]
// //               for (const flightsPerAirline of bookings) {
// //                   var record = {}
// //                   record.CountFlights = flightsPerAirline.BookedFlights                
// //                   record.AirlineID = flightsPerAirline.AirlineID
// //                   record.to_Customer_CustomerID = each.
// //                   to_Customer_CustomerID
// //                   record.LastName = each.LastName
// //                   record.Name = airlines.find(obj => obj.AirlineID === flightsPerAirline.AirlineID).Name
// //                   flightsPerCustomer.push(record)
// //               }
// //             })
// //         }
// //   return flightsPerCustomer
// //       }    
// // }

// const cds = require("@sap/cds");

// class DemoFPMService extends cds.ApplicationService {
//   init() {
//     this.on("READ", "BookedFlights", async (context, next) => {
//       const bookedFlights = await next();

//       const countRequested = context.query.SELECT?.columns?.some(c => c.as === 'CountFlights');
//       if (countRequested) {
//         const enriched = await _readBookedFlightsAllDefects(
//           bookedFlights.filter(obj => obj.to_User_UserID && obj.DefectID),
//           context
//         );

//         return [...new Set(enriched)];
//       }

//       return bookedFlights;
//     });

//     return super.init();
//   }
// }

// // 🔹 Private helper function to enrich with count
// async function _readBookedFlightsAllDefects(bookedFlights, context) {
//   const defectsPerUser = [];

//   for (const each of bookedFlights) {
//     if (!each.to_User_UserID) continue;

//     try {
//       const [bookings, defects] = await _readBookings(context, each);

//       for (const flightsPerDefect of bookings) {
//         const record = {
//           CountFlights: flightsPerDefect.BookedFlights,
//           DefectID: flightsPerDefect.DefectID,
//           to_User_UserID: each.to_User_UserID,
//           LastName: each.LastName,
//           Name: defects.find(d => d.DefectID === flightsPerDefect.DefectID)?.Name || ""
//         };

//         flightsPerUser.push(record);
//       }
//     } catch (err) {
//       console.error(`Error processing user ${each.to_User_UserID}:`, err);
//     }
//   }

//   return flightsPerUser;
// }

// // 🔹 Dummy implementation for testing (replace with actual query/service)
// async function _readBookings(context, user) {
//   const bookings = [
//     { BookedFlights: 3, DefectID: "D1001" },
//     { BookedFlights: 2, DefectID: "D2001" }
//   ];

//   const defects = [
//     { DefectID: "D1001", Name: "UI Bug" },
//     { DefectID: "D2001", Name: "Backend Failure" }
//   ];

//   return [bookings, defects];
// }

// module.exports = { DemoFPMService };
