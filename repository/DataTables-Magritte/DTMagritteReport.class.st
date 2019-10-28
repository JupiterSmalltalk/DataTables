Class {
	#name : #DTMagritteReport,
	#superclass : #MAReport,
	#category : #'DataTables-Magritte-Seaside'
}

{ #category : #'as yet unclassified' }
DTMagritteReport class >> rows: aCollection description: aDescription [
	| report |
	report := self rows: aCollection.
	aDescription asContainer do: [ :each | 
		(each isContainer not and: [each visibleInReport]) ifTrue: [ report addColumnDescription: each ] ].
	^ report
]

{ #category : #columns }
DTMagritteReport >> addColumn: aMAColumn [

	aMAColumn class == MADescribedColumn 
		ifTrue: [ super addColumn: aMAColumn ].
	^aMAColumn
]

{ #category : #ajax }
DTMagritteReport >> configureAjaxDataTable: dt [

	dt respond: [ :request | self respondTo: request ]
]

{ #category : #columns }
DTMagritteReport >> configureColumns: dt on: html [

	dt columns: (self columns collect: [ :each |
		DTColumnDefinition fromMagritteColumn: each canvas: html.
		 ])
	
]

{ #category : #javascript }
DTMagritteReport >> createDataTableScriptOn: html [
	| dt |
	dt := (html jQuery: self ajaxId asSymbol) dataTable.
	self configureColumns: dt on: html.
	dt serverSide: self serverSide.
	(self usesAjax or: [ self serverSide ])
		ifTrue: [ self configureAjaxDataTable: dt ]
		ifFalse: [ dt deferRender: true ].
	self language ifNotNil: [ :lang | dt languageSet: lang ].
	^ dt
]

{ #category : #rendering }
DTMagritteReport >> createSelectionScriptOn: html [
	| selClass |
	selClass := 'selected'.
	^ (html jQuery: '#' , self ajaxId , ' tbody')
		on: 'click'
		selector: 'tr'
		do:
			((html jQuery this removeClass: selClass)
				condition: (html jQuery this hasClass: selClass)
				else:
					(JSScript new
						add: ((html jQuery: '#' , self ajaxId , ' tr.' , selClass) removeClass: selClass);
						add: (html jQuery this addClass: selClass);
						yourself))
]

{ #category : #ajax }
DTMagritteReport >> dataFrom: aCollection [
	
	^aCollection collect: [ :object | self columns collect: [ :col | self renderObject: object using: col ] ]
]

{ #category : #'accessing-defaults' }
DTMagritteReport >> defaultSelectable [

	^false
]

{ #category : #'accessing-defaults' }
DTMagritteReport >> defaultServerSide [

	^true
]

{ #category : #'accessing-defaults' }
DTMagritteReport >> defaultShowBatch [
	^ false
]

{ #category : #'accessing-defaults' }
DTMagritteReport >> defaultUsesAjax [
	^ true
]

{ #category : #'rows-operations' }
DTMagritteReport >> filterRows: aCollection using: params [
	
	| pattern |
	pattern := params search.
	^pattern notEmpty
		ifTrue: [ 
			pattern := (pattern includes: $*) ifFalse: [ pattern copyWith: $* ].
			aCollection select: [ :each | each match: pattern ]]
		ifFalse: [ aCollection ].

]

{ #category : #'accessing-settings' }
DTMagritteReport >> language [

	^properties at: 'language' ifAbsent: [  ]
]

{ #category : #'accessing-settings' }
DTMagritteReport >> language: aSymbol [

	properties at: 'language' put: aSymbol
]

{ #category : #'rows-operations' }
DTMagritteReport >> paginate: aCollection using: params [
	
	^params length = -1 
		ifTrue: [ aCollection ]
		ifFalse: [ aCollection copyFrom: params start to: (aCollection size min: params start + params length - 1) ]

]

{ #category : #rendering }
DTMagritteReport >> renderContentOn: html [
	super renderContentOn: html.
	self renderCreateDataTableOn: html.

]

{ #category : #rendering }
DTMagritteReport >> renderCreateDataTableOn: html [
	html document addLoadScript: (self createDataTableScriptOn: html).
	self renderSelectionHandlerOn: html
]

{ #category : #ajax }
DTMagritteReport >> renderObject: object using: col [
	^ col formatter value: (col valueFor: object)
]

{ #category : #rendering }
DTMagritteReport >> renderSelectionHandlerOn: html [
	self selectable
		ifTrue: [ html document addLoadScript: (self createSelectionScriptOn: html) ]
]

{ #category : #rendering }
DTMagritteReport >> renderTableBodyOn: html [ 

	self usesAjax ifFalse: [ super renderTableBodyOn: html ]
]

{ #category : #ajax }
DTMagritteReport >> respondTo: request [

	| filteredRows |
	filteredRows := (self filterRows: (self sortRows: self rows using: request) using: request).
	request response
		recordsTotal: self rows size;
		recordsFiltered: filteredRows size;
		data: (self dataFrom: (self paginate: filteredRows using: request)).



]

{ #category : #'accessing-settings' }
DTMagritteReport >> selectable [

	^properties at: 'selectable' ifAbsent: [ self defaultSelectable  ]
]

{ #category : #'accessing-settings' }
DTMagritteReport >> selectable: aBoolean [

	properties at: 'selectable' put: aBoolean
]

{ #category : #'accessing-settings' }
DTMagritteReport >> serverSide [

	^properties at: 'serverSide' ifAbsent: [ self defaultServerSide  ]
]

{ #category : #'accessing-settings' }
DTMagritteReport >> serverSide: aBoolean [

	properties at: 'serverSide' put: aBoolean
]

{ #category : #'accessing-settings' }
DTMagritteReport >> showBatch [

	^false
]

{ #category : #'accessing-settings' }
DTMagritteReport >> showFilter [

	^false
]

{ #category : #'accessing-settings' }
DTMagritteReport >> sortEnabled [

	^false
]

{ #category : #'rows-operations' }
DTMagritteReport >> sortRows: aCollection using: params [
	
	^params sortColumns 
		ifEmpty: [ aCollection ]
		ifNotEmpty: [:sortColumns |  
			| sorter |
			sorter := (sortColumns collect: [:each | (columns at: each number) magritteDescription asSortFunction direction: each sortDirection ]) reduce:[:a :b | a , b].
			aCollection sorted: sorter
		]


]

{ #category : #'accessing-settings' }
DTMagritteReport >> usesAjax [

	^properties at: #usesAjax ifAbsent: [ self defaultUsesAjax ]
]

{ #category : #'accessing-settings' }
DTMagritteReport >> usesAjax: aBoolean [

	properties at: #usesAjax put: aBoolean
]
