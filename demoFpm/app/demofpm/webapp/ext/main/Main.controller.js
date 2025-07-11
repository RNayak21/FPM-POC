sap.ui.define(
  [
    'sap/fe/core/PageController',
    'sap/ui/core/BusyIndicator',
    'sap/ui/export/Spreadsheet',
    'sap/m/MessageToast'
  ],
  function (PageController, BusyIndicator, Spreadsheet, MessageToast) {
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
        this.getExtensionAPI().getRouting().navigateToRoute("ProcessAreaEntityObjectPage", { 'ID': `'${value}'` })
      },
      onNavBack: function () {
        var oNavContainer = this.getView().byId("navContainer");
        if (oNavContainer) {
          oNavContainer.back();
        }
      },

      onFilterChange: function (oEvent) {
        let filters = oEvent.getSource().getFilters().filters;
        filters.forEach(filter => {
          if (filter.sPath === 'Type') {
            if (filter.oValue1 === 'Bug') {
              this.getView().byId('JiraDefectTable').setVisible(true);
              this.getView().byId('JiraBuildTable').setVisible(false);
              this.getView().byId('demo.com.demofpm::JiraEntityMain--FilterBar-content-btnSearch').firePress();
            }
            else {
              this.getView().byId('JiraDefectTable').setVisible(false);
              this.getView().byId('JiraBuildTable').setVisible(true);
              this.getView().byId('demo.com.demofpm::JiraEntityMain--FilterBar-content-btnSearch').firePress();
            }


          }
        });


      },

      openUploadDialog: async function () {
        this._oDialog = null
        if (!this._oDialog) {
          this._oDialog = await this.loadFragment({ name: "demo.com.demofpm.ext.fragment.ExcelUpload" });
          this.getView().addDependent(this._oDialog);
        }
        this._oDialog.open();
      },

      onCancel: function () {
        if (this._oDialog) {
          this._oDialog.close();
          this._oDialog.destroy();
        }
      },

      onFileBrowse: function (oEvent) {
        let oFileUploader = oEvent.getSource();
        let file = oFileUploader.oFileUpload.files[0];
        MessageToast.show("Excel Selected: " + file.name)
      },

      onUploadExcel: async function () {
        const that = this;
        const oView = this.getView();
        const oTable = oView.byId('Table');
        const oFileUploader = oView.byId('fileUploader');
        const file = oFileUploader.oFileUpload?.files?.[0];

        if (!file) {
          MessageToast.show("No file selected for upload.");
          return;
        }

        const fileName = file.name;
        const serviceUrl = this.getModel().sServiceUrl.split('v4')[0];
        const uploadUrl = `${serviceUrl}v4/demo-fpm/JiraExcelUpload/excel`;

        oFileUploader.setUploadUrl(uploadUrl);

        try {
          BusyIndicator.show();

          // Upload the file
          await oFileUploader.upload();
          that.onCancel()
          // Refresh table data
          oTable.getModel().refresh();
          MessageToast.show(`${fileName} uploaded successfully.`);
        } catch (error) {
          console.error("Upload failed:", error);
          MessageBox.error("An error occurred while uploading the file. Please try again.");
        } finally {
          // Clean up
          oFileUploader.clear();
          BusyIndicator.hide();
        }
      },


      onDownloadTemplate: function () {
        // Define column structure
        var aCols = [
          { label: "JIRA ID", property: "defectID", type: "string" },
          { label: "Description", property: "defectDesc", type: "string" },
          { label: "Priority", property: "priority_code", type: "string" },
          { label: "Type", property: "type", type: "string" },
          { label: "Due Date", property: "endDate", type: "date" },
          { label: "Functional Area", property: "functionalArea", type: "string" },
          { label: "Resolving Team", property: "team", type: "string" },
          { label: "Assignee", property: "assignee", type: "string" },
          { label: "Reporter", property: "reporter", type: "string" }
        ];

        // Generate dummy empty row based on column structure
        var aData = [
          {
            defectID: "",
            defectDesc: "",
            priority_code: "",
            type: "",
            defectStatus: "",
            startDate: "",
            endDate: "",
            functionalArea: "",
            team: "",
            assignee: "",
            reporter: ""
          }
        ];


        // Use Spreadsheet to create Excel
        var oSettings = {
          workbook: {
            columns: aCols,
            context: {
              application: "Jira Dashboard",
              sheetName: "JIRA_Defects"
            }
          },
          dataSource: aData,
          fileName: "Jira_Template.xlsx"
        };

        var oSheet = new Spreadsheet(oSettings);
        oSheet.build().finally(function () {
          MessageToast.show("Template downloaded successfully")
          oSheet.destroy();
        });
      }

    });
  }
);
