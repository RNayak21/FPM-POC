sap.ui.define(
    [
        'sap/fe/core/PageController'
    ],
    function(PageController) {
        'use strict';

        return PageController.extend('demo.com.demofpm.ext.main.Main', {
            /**
             * Called when a controller is instantiated and its View controls (if available) are already created.
             * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
             * @memberOf demo.com.demofpm.ext.main.Main
             */
            //  onInit: function () {
            //      PageController.prototype.onInit.apply(this, arguments); // needs to be called to properly initialize the page controller
            //  },

            /**
             * Similar to onAfterRendering, but this hook is invoked before the controller's View is re-rendered
             * (NOT before the first rendering! onInit() is used for that one!).
             * @memberOf demo.com.demofpm.ext.main.Main
             */
            //  onBeforeRendering: function() {
            //
            //  },

            /**
             * Called when the View has been rendered (so its HTML is part of the document). Post-rendering manipulations of the HTML could be done here.
             * This hook is the same one that SAPUI5 controls get after being rendered.
             * @memberOf demo.com.demofpm.ext.main.Main
             */
            //  onAfterRendering: function() {
            //
            //  },

            /**
             * Called when the Controller is destroyed. Use this one to free resources and finalize activities.
             * @memberOf demo.com.demofpm.ext.main.Main
             */
            //  onExit: function() {
            //
            //  }

            onStatusCodeChange: async function (oEvent) {
              let filters = oEvent.getParameter("filters");
              const that = this;
              let oTable = that.getView().byId("Table");
              let oTableData = oTable.getModel();
              let defectStatus;
      
              for (let i = 0; i < filters.length; i++) {
                //subFilterValue = filters[i].aFilters;          
                if (filters[i].sPath === "defectStatus") {
                  defectStatus = filters[i].oValue1;
                }
      
              };
              
              
              if (defectStatus === "Open" &&defectStatus !== "undefined") {
                await oTable.hideColumns(['Batch','Defect Desc', 'Start Date', 'endDate', 'reporter', 'Team', 'Defect ID', 'Defect Status'
                ]);
              } else{
                await oTable.showColumns([ 'Batch','Defect Desc', 'Start Date', 'endDate', 'reporter', 'Team', 'Defect ID', 'Defect Status']);
              }
      
      
      
      
            },

            onTilePress: function (oEvent) {
                const oTile = oEvent.getSource();
                const oContext = oTile.getBindingContext();
                if (!oContext) {
                  MessageToast.show("No binding context found!");
                  return;
                }
        
                const sPath1 = oContext.getPath();
                const sPath = sPath1.split("(")[0];    
                const oView = this.getView();
                const oNav = oView.byId("navContainer");
                const oDetail = oView.byId("detailPage");
        
                oDetail.bindElement({ path: sPath });
                oNav.to(oDetail);
              },
              onNavBack: function () {
                var oNavContainer = this.getView().byId("navContainer");
                if (oNavContainer) {
                  oNavContainer.back();
                }
              }
        });
    }
);
