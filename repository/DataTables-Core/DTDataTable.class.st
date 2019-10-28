Class {
	#name : #DTDataTable,
	#superclass : #JQPlugin,
	#category : #'DataTables-Core'
}

{ #category : #private }
DTDataTable >> ajax [
	"Sets the url of receiver ajax data source."

	^self options at: 'ajax' ifAbsentPut: [DTAjax context: self renderContext]
	
]

{ #category : #private }
DTDataTable >> ajax: aDTAjax [
	"Sets the url of receiver ajax data source."

	self optionAt: 'ajax' put: aDTAjax
	
]

{ #category : #options }
DTDataTable >> beServerSide [

	self serverSide: true
	
]

{ #category : #options }
DTDataTable >> buttons: anArray [
	self optionAt: 'buttons' put: anArray
]

{ #category : #sorting }
DTDataTable >> columnCssClasses: anArray [
	"Send in an array like #(nil nil 'myClass' 'myClass1' nil 'myClass3') and this will ensure datatables uses those classes 
	
	
	See: https://datatables.net/reference/option/columns.className
	
"

	anArray notNil
		ifTrue: [ self ensureColumnArrayOfSize: anArray size.
			anArray
				doWithIndex: [ :eachSortType :index | 
					| columnDetails |
					eachSortType notNil
						ifTrue: [ columnDetails := self columns at: index.
							columnDetails at: 'className' put: eachSortType asString ] ] ]
]

{ #category : #options }
DTDataTable >> columnDefs [

	^self optionAt: 'columnDefs'

]

{ #category : #options }
DTDataTable >> columnDefs: anObject [ 

	self optionAt: 'columnDefs' put: anObject

]

{ #category : #sorting }
DTDataTable >> columnSortHelpers: anArray [
	"Send in an array like #(nil nil 'dom-checkbox' 'dom-text' nil 'dom-select') and this will pick the right orderDataType helper to allow you to sort on columns that are html inputs.
	
	
	See: http://www.datatables.net/examples/plug-ins/dom_sort.html
	
	
	If you're going to use this you need to load the code that provides the sort values prior to instantiating your table"

	anArray notNil
		ifTrue: [ self ensureColumnArrayOfSize: anArray size.
			anArray
				doWithIndex: [ :eachSortType :index | 
					| columnDetails |
					eachSortType notNil
						ifTrue: [ columnDetails := self columns at: index.
							columnDetails at: 'orderDataType' put: eachSortType asString ] ] ]
]

{ #category : #options }
DTDataTable >> columns [

	^self optionAt: 'columns'
]

{ #category : #options }
DTDataTable >> columns: aCollection [ 

	self optionAt: 'columns' put: aCollection
]

{ #category : #options }
DTDataTable >> dataSrc: aString [

	self optionAt: 'dataSrc' put: aString
	
]

{ #category : #options }
DTDataTable >> deferRender: aBoolean [

	self optionAt: 'deferRender' put: aBoolean
]

{ #category : #options }
DTDataTable >> dom: aStringOfDomParameters [
	"http://datatables.net/reference/option/dom"

	self optionAt: 'dom' put: aStringOfDomParameters
]

{ #category : #sorting }
DTDataTable >> ensureColumnArrayOfSize: anArraySize [
	| currentColumns |
	currentColumns := self columns.
	currentColumns isNil
		ifTrue: [ 
			| colArray |
			colArray := OrderedCollection new.
			anArraySize timesRepeat: [ colArray add: Dictionary new ].
			self columns: colArray ]
		ifFalse: [ 
			currentColumns size < anArraySize
				ifTrue: [ anArraySize - currentColumns size timesRepeat: [ currentColumns add: Dictionary new ] ] ]
]

{ #category : #extensions }
DTDataTable >> ensureDomIncludesTableTools [
	| dom |
	dom := self optionAt: 'dom'.
	dom isNil
		ifTrue: [ self dom: 'Tlfrtip' ]
		ifFalse: [ 
			('*T*' match: dom)
				ifFalse: [ self dom: 'T', dom ] ]
]

{ #category : #options }
DTDataTable >> fixedHeader: aBoolean [
  self optionAt: 'fixedHeader' put: aBoolean
]

{ #category : #options }
DTDataTable >> includeAllInLengthMenu [
	"the first array is the number of rows to show.  The second array is the labels"

	self optionAt: 'lengthMenu' put: (Array with: #(10 25 50 -1) with: #(10 25 50 'All'))
]

{ #category : #options }
DTDataTable >> info: aBoolean [

	self optionAt: 'info' put: aBoolean
]

{ #category : #initializing }
DTDataTable >> initialize [

	super initialize.
	self initializeOptions
]

{ #category : #initializing }
DTDataTable >> initializeOptions [

	options := GRSmallDictionary new
]

{ #category : #options }
DTDataTable >> languageSet: aSymbol [

	self optionAt: 'language' put: {'url' -> (DTLanguagesLibrary / (aSymbol asLowercase asCamelCase,  #Lang) asSymbol) asString } asDictionary.
	

]

{ #category : #options }
DTDataTable >> languageUrl: urlString [

	self optionAt: 'language' put: {'url' -> urlString } asDictionary.
	

]

{ #category : #options }
DTDataTable >> lengthMenu: aBoolean [
  self optionAt: 'lengthMenu' put: aBoolean
]

{ #category : #private }
DTDataTable >> method [

	^'dataTable'
]

{ #category : #options }
DTDataTable >> optionAt: aKey [
	^ self options at: aKey ifAbsent: [ nil ]
]

{ #category : #options }
DTDataTable >> optionAt: aKey put: aValue [
	^ self options at: aKey asString put: aValue
]

{ #category : #private }
DTDataTable >> options [
	^ options ifNil: [ self initializeOptions ]
]

{ #category : #options }
DTDataTable >> order: anArray [
	"	An array with two entries:

    Column index to order upon (0 indexed!)
    Direction so order to apply (asc or desc)"

	self optionAt: 'order' put: anArray
]

{ #category : #options }
DTDataTable >> pageLength: aNumber [
  self optionAt: 'pageLength' put: aNumber
]

{ #category : #options }
DTDataTable >> paging: aBoolean [
	self optionAt: 'paging' put: aBoolean
]

{ #category : #callbacks }
DTDataTable >> respond: aBlock [
	"Sets the callback "

	self ajax callback: aBlock
	
]

{ #category : #extensions }
DTDataTable >> responsive: aBoolean [
	"defaults to false.  http://www.datatables.net/extensions/responsive/"

	self optionAt: 'responsive' put: aBoolean
]

{ #category : #options }
DTDataTable >> scrollX: anInteger [
	self optionAt: 'scrollX' put: anInteger
]

{ #category : #options }
DTDataTable >> scrollY: anInteger [
	self optionAt: 'scrollY' put: anInteger
]

{ #category : #options }
DTDataTable >> serverSide: aBoolean [

	self optionAt: 'serverSide' put: aBoolean
	
]

{ #category : #extensions }
DTDataTable >> tableToolsFlashFilePath: aPath [
	| dict |
	dict := Dictionary new.
	dict at: 'sSwfPath' put: aPath.
	self ensureDomIncludesTableTools.
	self optionAt: 'tableTools' put: dict
]
