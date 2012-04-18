/*******************************************************************************
 * Copyright (c) 2012 BMW Car IT and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.jnario.feature.tests.integration

import static org.jnario.jnario.test.util.ResultMatchers.*
import static extension org.jnario.jnario.test.util.FeatureExecutor.*

/**
 * @author Birgit Engelmann - Initial contribution and API
 */
Feature: Backgrounds

	Scenario: It is possible to add a background to a feature
		CharSequence jnarioFile
		Given I have a feature with a background
			jnarioFile = "
				package bootstrap
				Feature: Some feature
					Background:
						Given a user name
					Scenario: Scenario 1
					Scenario: Scenario 2
			"
		Then it should be successful
			jnarioFile.executesSuccessfully
			

	Scenario: Given methods from backgrounds are generated in every scenario class
		public String jnarioFile
		Given I have a feature with a background
			jnarioFile = "
				package bootstrap
				Feature: Some feature
					Background:
						Given a user name
							throw new RuntimeException()
					Scenario: Scenario 1
					Scenario: Scenario 2
			"
		Then every class should have a method that throws a RuntimeExeception
			jnarioFile.execute.failureCount => 2
			
	Scenario: Using fields from background steps
		Given a scenario with a field
			jnarioFile = '''
				package bootstrap
				import java.util.*
				Feature: Test
					Background: 
						List<String> values = new ArrayList()
						Given a list
							values += "hello"
						
					Scenario: TestScenario 2
						Then it should have contents
							values.size => 1
				'''
	 	Then it should be successful		
			