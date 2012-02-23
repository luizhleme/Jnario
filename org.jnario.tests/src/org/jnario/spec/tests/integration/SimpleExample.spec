/*******************************************************************************
 * Copyright (c) 2012 BMW Car IT and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
 package org.jnario.spec.tests.integration

describe "SimpleExample" {
 
	it "should pass"{
		val spec = '
			package bootstrap
	
			describe "Example" {
			
				it "should pass"{
						org::junit::Assert::assertTrue(true) 
				} 
						
			}
		'
		val result = org::jnario::jnario::test::util::SpecExecutor::execute(spec)
		org::junit::Assert::assertThat(result, org::jnario::jnario::test::util::ResultMatchers::successful)
	} 
	
	it "should fail"{
		val spec = '
			package bootstrap

			describe "Example" {
			
				it "should fail"{
						org::junit::Assert::assertFalse("reason of failure", true)
				} 
						
			}
		'
		val result = org::jnario::jnario::test::util::SpecExecutor::execute(spec)
		org::junit::Assert::assertThat(result, org::jnario::jnario::test::util::ResultMatchers::hasSingleFailureContaining("reason of failure"))
	}
			
}
	