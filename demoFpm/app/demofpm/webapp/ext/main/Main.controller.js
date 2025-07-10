sap.ui.define(
  [
    'sap/fe/core/PageController'
  ],
  function (PageController) {
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

      onTilePress: function (oEvent) {
        const oTile = oEvent.getSource();
        let value = oEvent.getSource().getBindingContext().getObject().ID;
        this.getExtensionAPI().getRouting().navigateToRoute("ProcessAreaEntityObjectPage", {'ID': `'${value}'`})
      },
      onNavBack: function () {
        var oNavContainer = this.getView().byId("navContainer");
        if (oNavContainer) {
          oNavContainer.back();
        }
      },

      onFilterChange: function(oEvent){
        let filters = oEvent.getSource().getFilters().filters;
        filters.forEach(filter => {
            if(filter.sPath ==='Type'){
              if(filter.oValue1 ==='Bug'){
                this.getView().byId('JiraDefectTable').setVisible(true);
                this.getView().byId('JiraBuildTable').setVisible(false);
                this.getView().byId('demo.com.demofpm::JiraEntityMain--FilterBar-content-btnSearch').firePress();
              }
              else{
                this.getView().byId('JiraDefectTable').setVisible(false);
                this.getView().byId('JiraBuildTable').setVisible(true);
                this.getView().byId('demo.com.demofpm::JiraEntityMain--FilterBar-content-btnSearch').firePress();
              }
               

            }
        });

        
      }
    });
  }
);
