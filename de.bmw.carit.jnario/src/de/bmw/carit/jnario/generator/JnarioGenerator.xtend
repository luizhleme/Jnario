/*
 * generated by Xtext
 */
package de.bmw.carit.jnario.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import com.google.common.collect.Iterators

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.xbase.compiler.*
import org.eclipse.xtext.xbase.*
import de.bmw.carit.jnario.jnario.*
import org.eclipse.xtext.common.types.*
import java.util.*
import com.google.inject.Inject
import static extension org.eclipse.xtext.xtend2.lib.ResourceExtensions.*
import org.eclipse.xtext.xtend2.lib.StringConcatenation

class JnarioGenerator implements IGenerator {
	
	@Inject JnarioCompiler jnarioCompiler
	
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		
		for(feature: resource.allContentsIterable.filter(typeof(Jnario))) {
			fsa.generateFile(feature.featureName + ".java", feature.compile)
		}
	}
	
	def compile(Jnario spec) '''
		�val importManager = new ImportManager(true)�
		�steps(spec, importManager)�
	'''
	
	def steps(Jnario feature, ImportManager importManager) '''
		import org.junit.Test;
		import org.junit.Before;
		
		public class �feature.featureName�{
			
			�FOR s:feature.scenarios�
				�given(s.spec.given, s.spec.given.desc.extractName, importManager)�
				
				@Test
				public void test(){
					�var whenName = s.spec.when.desc.extractName�
					�whenName�(); 
					�var thenName = s.spec.then.desc.extractName�
					�thenName�();
				}
				
				�when(s.spec.when, whenName, importManager)�
				
				�then(s.spec.then, thenName, importManager)�
			�ENDFOR�
		}
	'''
	

	
	def given(Given given, String givenName, ImportManager importManager)'''
			@Before
			public void �givenName�(){
				�jnarioCompiler.compile(given.code, importManager)�
			}
	'''
// TODO: extract method, as parameter when/then
// how to treat AND? multiple method calls one after the other?
	def when(When when, String whenName, ImportManager importManager)'''
			private void �whenName�(){
				�jnarioCompiler.compile(when.code, importManager)� 
			}
	'''
	
	def then(Then then, String thenName, ImportManager importManager)'''
			private void �thenName�(){
				�jnarioCompiler.compile(then.code, importManager)� 
			}
	'''
	
	def extractName(String name){
		var methodName = ""
		var words = name.split(' ');
		for(word: words){
			var upperWord = word.toFirstUpper
			methodName = methodName + upperWord
		}
		var indexOfSentenceEnd = methodName.lastIndexOf(".")
		methodName = methodName.substring(0, indexOfSentenceEnd);
		methodName = methodName.toFirstLower
		return methodName
	}
}