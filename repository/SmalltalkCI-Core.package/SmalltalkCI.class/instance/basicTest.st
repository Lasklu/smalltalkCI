executing
basicTest
	| runner |
	self ensureSpecIsValid.
	self class
		stage: 'Testing project...'
		id: 'test_project'
		block: [
			self prepareForTesting.
			self isCoverageTestingEnabled
				ifTrue: [ self class codeCoverageClass
							run: [ runner := self runTests ]
							spec: self spec
							in: self projectDirectory ]
				ifFalse: [ runner := self runTests ].
			self finishUpAfterTesting ].
	self reportResults: runner.
	runner isSuccessful
		ifFalse: [ SCIError signal: '[test failure]' ]