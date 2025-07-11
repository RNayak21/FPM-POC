sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        onNavBack: function(oEvent) {
            this.getRouting().navigateToRoute('JiraEntityMain');
        }
    };
});
