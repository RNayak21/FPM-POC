sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'demo/com/demofpm/test/integration/FirstJourney',
		'demo/com/demofpm/test/integration/pages/JiraEntityMain'
    ],
    function(JourneyRunner, opaJourney, JiraEntityMain) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('demo/com/demofpm') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheJiraEntityMain: JiraEntityMain
                }
            },
            opaJourney.run
        );
    }
);