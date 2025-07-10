sap.ui.define(["sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
],
    function (Filter, FilterOperator) {
        "use strict";
        return {


            //Used to map header material
            onChangeAuthority: function (sValue) {
                switch (sValue) {
                    case UIConstants.StringZero:
                        return new Filter({ path: UIConstants.HeaderMaterial, operator: FilterOperator.EQ, value1: UIConstants.AlaphabetY });
                    case UIConstants.StringOne:
                        return new Filter({ path: UIConstants.HeaderMaterial, operator: FilterOperator.EQ, value1: UIConstants.AlaphabetN });
                }
            },

            onStatusCodeChange: async function (oEvent) {
                let filter = oEvent.mParameters.selectedItem.mProperties.key;
                const that = this;
                let oTable = that.getView().byId("Table");
                if (filter === '0' && filter !== "undefined") {
                    await oTable.hideColumns(['defectDesc', 'functionalArea', 'startDate', 'completedDate', 'reporter', 'team','defectStatus']);
                } else {
                    await oTable.showColumns(['defectDesc', 'functionalArea', 'startDate', 'completedDate', 'reporter', 'team','defectStatus']);
                }

            }

        };
    });