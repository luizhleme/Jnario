package org.jnario.feature.tests.integration;

import org.jnario.feature.tests.integration.DefiningFeatureBasesClassesFeatureASimpleScenario;
import org.jnario.feature.tests.integration.DefiningFeatureBasesClassesFeatureScenarioWithBackground;
import org.jnario.runner.Contains;
import org.jnario.runner.FeatureRunner;
import org.jnario.runner.Named;
import org.junit.runner.RunWith;

@RunWith(FeatureRunner.class)
@Contains({ DefiningFeatureBasesClassesFeatureASimpleScenario.class, DefiningFeatureBasesClassesFeatureScenarioWithBackground.class })
@Named("Defining Feature Bases Classes")
@SuppressWarnings("all")
public class DefiningFeatureBasesClassesFeature {
}
