Class {
	#name : #BaselineOfDataTables,
	#superclass : #BaselineOf,
	#category : #BaselineOfDataTables
}

{ #category : #baselines }
BaselineOfDataTables >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Seaside3'
					with: [ spec
						repository: 'github://SeasideSt/Seaside/repository';
						loads: #('Development' 'Zinc' 'Email') ];
				configuration: 'SortFunctions'
					with: [ spec
						repository: 'http://smalltalkhub.com/mc/emaringolo/SortFunctions/main';
						version: #stable ];
				baseline: 'Magritte'
					with: [ spec
						repository: 'github://magritte-metamodel/magritte/source';
						loads: #('Core' 'Seaside') ].
			spec
				package: 'DataTables-Core';
				package: 'DataTables-Libraries'
					with: [ spec requires: 'DataTables-Core' ];
				package: 'DataTables-Magritte'
					with: [ spec requires: #('DataTables-Core' 'DataTables-Libraries') ].
			spec
				group: 'default'
					with: #('CoreAndLibraries' 'Magritte' 'SortFunctions');
				group: 'Core' with: #('DataTables-Core');
				group: 'CoreAndLibraries' with: #('DataTables-Libraries');
				group: 'Magritte'
					with: #('CoreAndLibraries' 'DataTables-Magritte') ]
]
