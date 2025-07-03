

sap.ui.define([
    'jquery.sap.global',
    'sap/suite/ui/commons/library',
    'sap/m/library',
    'sap/ui/model/json/JSONModel',
    'sap/ui/Device',
    'sap/m/MessageToast',
    'sap/suite/ui/commons/ProcessFlowConnectionLabel',
    'sap/m/StandardListItem',
    'sap/m/Button',
    'sap/m/List',
    'sap/m/ResponsivePopover',
    'sap/ui/core/Core',
    'sap/ui/core/Element'
  ], function (
    jQuery, SuiteLibrary, MobileLibrary, JSONModel, Device,
    MessageToast, ProcessFlowConnectionLabel, StandardListItem,
    Button, List, ResponsivePopover, Core, Element
  ) {
    'use strict';
    var aConnections = null;
    var sContainerId = "";
    function createListEntryObject(oConnection) {
  
  
      
        return {
            title: oConnection.label.getText(),
            // info: oConnection.sourceNode.getNodeId() + "-" + oConnection.targetNode.getNodeId(),
            type: "Active"
        };
    }
    function getListData() {
        var aNavigation = aConnections.map(createListEntryObject);
        return { navigation: aNavigation };
    }
  
  
  
    
    // 🔹 Define the handler object first
    var ProcessFlowHandler = {
        onLabelPress: function (oEvent) {
            aConnections = oEvent.getParameter("connections");
            sContainerId = oEvent.getSource().getId().split("-")[2];
            var oSelectedLabel = oEvent.getParameter("selectedLabel");
            var oListData = getListData();
            var oItemTemplate = new StandardListItem({
                title: "{title}",
                // info: "{info}"
            });
            var oList = new List({
                mode: MobileLibrary.ListMode.SingleSelectMaster,
                selectionChange: ProcessFlowHandler.onListItemPress
            });
            oList.setModel(new JSONModel(oListData));
            oList.bindAggregation("items", "/navigation", oItemTemplate);
            var oResponsivePopover;
            // var oBeginButton = new Button({
            //     text: "Action1",
            //     type: MobileLibrary.ButtonType.Reject,
            //     press: function () {
            //         oResponsivePopover.setShowCloseButton(true);
            //     }
            // });
            // var oEndButton = new Button({
            //     text: "Action2",
            //     type: MobileLibrary.ButtonType.Accept,
            //     press: function () {
            //         oResponsivePopover.setShowCloseButton(true);
            //     }
            // });
            oResponsivePopover = Element.getElementById("__popover") || new ResponsivePopover("__popover", {
                placement: MobileLibrary.PlacementType.Auto,
                // title: "Paths[" + aConnections.length + "]",
                content: [oList],
                showCloseButton: true,
                afterClose: function () {
                    oResponsivePopover.destroy();
                    Core.byId(sContainerId).setFocusToLabel(oSelectedLabel);
                },
                // beginButton: oBeginButton,
                // endButton: oEndButton
            });
            if (Device.system.phone) {
                oResponsivePopover.setShowCloseButton(true);
            }
            oResponsivePopover.openBy(oSelectedLabel);
            oResponsivePopover.setShowCloseButton(true);
        },
        // onChange: function (oEvent) {
        //     var oSelect = oEvent.getSource();
        //      // Get the selected key
        //      var sSelectedKey = oSelect.getSelectedKey();
        //     if(sSelectedKey === "PO"){
        //      this.getView().byId("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable-listUl").setVisible(true);
        //      this.getView().byId("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable1-listUl").setVisible(false);
        //     }else if (sSelectedKey === "SO")
        //      {
        //       this.getView().byId("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable-listUl").setVisible(false);
        //         this.getView().byId("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable1-listUl").setVisible(true);
        //      }
        //     // MessageToast.show("change event fired! \n Selected Item id: " + oEvent.getParameters().selectedItem.sId
        //     // + "\n Previously Selected Item id: " + oEvent.getParameters().previousSelectedItem.sId);
        // },
        onNodePress: function(event) {
            console.log(event.getParameters(),"event.getParameters()")
      MessageToast.show(event.getParameters()?.mProperties?.title);
    },
        // onChange: function (oEvent) {
        //     var oSelect = oEvent.getSource();
        //     var sSelectedKey = oSelect.getSelectedKey();
        //      var oPO = Element.getElementById("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable");
        //      var oSO = Element.getElementById("zbuvcm47419ui::PFC_ListObjectPage--fe::CustomSubSection::ProcessFlow--productTable1");
        //     if (sSelectedKey === "PO") {
        //         oPO.setVisible(true);
        //         oSO.setVisible(false);
        //     } else if (sSelectedKey === "SO") {
        //         oPO.setVisible(false);
        //         oSO.setVisible(true);
        //     }
        // },
        formatConnectionLabels: function(childrenData) {
            var aChildren = [];
            for (var i = 0; childrenData &&  i < childrenData.length; i++) {
                if (childrenData[i].connectionLabel && childrenData[i].connectionLabel.id) {
                    var oConnectionLabel = Element.getElementById(childrenData[i].connectionLabel.id);
                    if (!oConnectionLabel) {
                        oConnectionLabel = new ProcessFlowConnectionLabel({
                            id: childrenData[i].connectionLabel.id,
                            text: childrenData[i].connectionLabel.text,
                            enabled: childrenData[i].connectionLabel.enabled,
                            icon: childrenData[i].connectionLabel.icon,
                            state: childrenData[i].connectionLabel.state,
                            priority: childrenData[i].connectionLabel.priority
                        });
                    }
                    aChildren.push({
                        nodeId: childrenData[i].nodeId,
                        connectionLabel: oConnectionLabel
                    });
                } else if (jQuery.type(childrenData[i]) === 'number'){
                    aChildren.push(childrenData[i]);
                }
            }
            return aChildren;
        },
        onListItemPress: function (oEvent) {
            var selectedItem = oEvent.getParameter("listItem");
            var aSourceTarget = selectedItem.getInfo().split("-");
            var sSourceId = aSourceTarget[0];
            var sTargetId = aSourceTarget[1];
            aConnections.forEach(function (conn) {
                if (
                    conn.sourceNode.getNodeId() === sSourceId &&
                    conn.targetNode.getNodeId() === sTargetId
                ) {
                    Core.byId(sContainerId).setSelectedPath(sSourceId, sTargetId);
                }
            });
        }
    };
    // ✅ Export the named object
    return ProcessFlowHandler;
  });