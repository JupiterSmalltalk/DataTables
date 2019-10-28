Class {
	#name : #DTObject,
	#superclass : #JSObject,
	#instVars : [
		'options'
	],
	#category : #'DataTables-Core'
}

{ #category : #'as yet unclassified' }
DTObject >> initialize [

	super initialize.
	self initializeOptions
]

{ #category : #'as yet unclassified' }
DTObject >> initializeOptions [

	options := GRSmallDictionary new
]

{ #category : #'as yet unclassified' }
DTObject >> javascriptContentOn: aStream [
	
	JSStream encodeDictionary: self options on: aStream  
]

{ #category : #'as yet unclassified' }
DTObject >> options [
	options ifNil: [ self initializeOptions ].
	^ options
]
