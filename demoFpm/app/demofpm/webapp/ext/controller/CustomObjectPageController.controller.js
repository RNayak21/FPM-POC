sap.ui.define(['sap/ui/core/mvc/ControllerExtension', 'sap/ui/model/json/JSONModel'], function (ControllerExtension, JSONModel) {
    'use strict';

    return ControllerExtension.extend('demo.com.demofpm.ext.controller.CustomObjectPageController', {
        // this section allows to extend lifecycle hooks or hooks provided by Fiori elements
        override: {
            /**
             * Called when a controller is instantiated and its View controls (if available) are already created.
             * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
             * @memberOf demo.com.demofpm.ext.controller.CustomObjectPageController
             */
            onInit: function () {
                const oRouter = this.base.getAppComponent().getRouter();
                oRouter.getRoute('JiraEntityObjectPage').attachPatternMatched(
                    function (oEvent){
                        console.log(oEvent.getParameter('arguments').JiraEntityKey);
                    }
                );
                
                let da3 = {
                    "nodes": [
                        {
                            "id": "1",
                            "lane": "0",
                            "title": "OPEN",
                            "titleAbbreviation": "OPEN",
                            "type": "Single",

                            "children": [
                                {
                                    "nodeId": 14,
                                    "connectionLabel": {
                                        "id": "myButtonId1To14",
                                        "text": "First stage",
                                        "enabled": true,
                                        "state": "Critical",
                                        "tooltip": "This is the tooltip text for JIRA" // Tooltip text
                                    }
                                }
                            ],
                            "state": "Positive",
                            "stateText": null,
                            "focused": false,
                            "texts": [""],
                            "highlighted": false
                        },

                        {
                            "id": "20",
                            "lane": "2",
                            "title": "Exceeded Due Date",
                            "titleAbbreviation": "Exceeded Due Date",
                            "type": "Single",
                            "state": "Negative",
                            "children": [
                                {
                                    "nodeId": 30,
                                    "connectionLabel": {
                                        "id": "myButtonId14To20",
                                        "text": "Last Stage",
                                        "enabled": true,
                                        "priority": 7,
                                        "state": "Positive",
                                        "tooltip": "Hiiiiiiiiiiiiii"
                                    }
                                }
                            ],
                        },
                        {
                            "id": "14",
                            "lane": "1",
                            "title": "In Progress",
                            "titleAbbreviation": "In Progress",
                            "type": "Single",
                            "state": "Neutral",
                            "children": [
                                {
                                    "nodeId": 20,
                                    "connectionLabel": {
                                        "id": "myButtonId14To30",
                                        "text": "Second Stage",
                                        "enabled": true,
                                        "state": "Positive"
                                    }
                                }
                            ],
                        },
                        {
                            "id": "30",
                            "lane": "3",
                            "title": "Closed",
                            "titleAbbreviation": "Closed",
                            "type": "Single",
                            "children": null,
                            "state": "Positive",
                            "stateText": null,
                            "focused": true,
                            "texts": null,
                            "highlighted": false
                        }
                    ],
                    "lanes": [
                        {
                            "id": "0",
                            "icon": "sap-icon://learning-assistant",
                            "label": "Open",
                            "position": 0,
                            "state": [
                                {
                                    "state": "Critical",
                                    "value": 10
                                }
                            ]
                        },
                        {
                            "id": "1",
                            "icon": "sap-icon://workflow-tasks",
                            "label": "In Progress",
                            "position": 1,
                            "state": [
                                {
                                    "state": "Negative",
                                    "value": 25
                                }
                            ]
                        },
                        {
                            "id": "2",
                            "icon": "sap-icon://status-critical",
                            "label": "Exceeded Due Date",
                            "position": 2,
                            "state": [
                                {
                                    "state": "Negative",
                                    "value": 25
                                }
                            ]
                        },
                        {
                            "id": "3",
                            "icon": "sap-icon://complete",
                            "label": "Closed",
                            "position": 3,
                            "state": [
                                {
                                    "state": "Positive",
                                    "value": 10
                                }
                            ]
                        }
                    ]
                };
 

                // Set up the model
                let oModel3 = new JSONModel(da3);
                this.getView().setModel(oModel3, "data3");
               
            },

            onAfterRendering: function () {
                const oProcessFlow = this.getView().byId("processflow4");

                if (oProcessFlow) {
                    oProcessFlow.attachEventOnce("nodesUpdated", function () {
                        console.log("nodesUpdated event triggered");
                        this._attachHoverEvents();
                    }.bind(this));
                } else {
                    console.error("ProcessFlow control not found!");
                }
            },
            _loadChartData: function () {
                const oODataModel = this.getView().getModel(); // OData v4 model
                const sApply = "$apply=groupby((team),aggregate(taskCount with sum as TaskCountsAgg))";
 
                oODataModel.read("/TeamTaskCount", {
                    urlParameters: {
                        $apply: "groupby((team),aggregate(taskCount with sum as TaskCountsAgg))"
                    },
                    success: (oData) => {
                        // oData.value contains aggregated chart data
                        const oChartModel = new JSONModel(oData.value);
                        this.getView().setModel(oChartModel, "chartData");
                    },
                    error: (oError) => {
                        console.error("Failed to load chart data:", oError);
                    }
                });
            }

        }
    });
});
