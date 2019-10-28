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
				configuration: 'SortFunctions'
					with: [ spec
						repository: 'http://smalltalkhub.com/mc/emaringolo/SortFunctions/main';
						version: #stable ];
				baseline: 'Magritte'
					with: [ spec
						repository: 'github://magritte-metamodel/magritte/source';
						loads: #('Core') ].
			spec
				package: 'DataTables-Core';
				package: 'DataTables-Libraries'
					with: [ spec requires: 'DataTables-Core' ];
				package: 'DataTables-Magritte'
					with: [ spec requires: #('Magritte' 'DataTables-Core' 'DataTables-Libraries') ].
			spec
				group: 'default'
					with: #('CoreAndLibraries' 'Magritte' 'SortFunctions');
				group: 'Core' with: #('DataTables-Core');
				group: 'CoreAndLibraries' with: #('DataTables-Libraries');
				group: 'Magritte'
					with: #('CoreAndLibraries' 'DataTables-Magritte') ]
]
