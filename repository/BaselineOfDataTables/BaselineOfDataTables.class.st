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
				package: 'DataTables-Core' ;
				package: 'DataTables-Libraries'
					with: [ spec requires: 'DataTables-Core' ];
				package: 'DataTables-Magritte'
					with:
						[ spec requires: #('DataTables-Core' 'DataTables-Libraries') ].
			spec
				group: 'default' with: #('CoreAndLibraries');
				group: 'Core' with: #('DataTables-Core');
				group: 'CoreAndLibraries' with: #('DataTables-Libraries');
				group: 'Magritte'
					with: #('CoreAndLibraries' 'DataTables-Magritte') ]
]
