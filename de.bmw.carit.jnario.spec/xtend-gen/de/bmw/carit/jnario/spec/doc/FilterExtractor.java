package de.bmw.carit.jnario.spec.doc;

import de.bmw.carit.jnario.spec.doc.Filter;
import de.bmw.carit.jnario.spec.doc.FilteringResult;
import de.bmw.carit.jnario.spec.doc.RegexFilter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;

@SuppressWarnings("all")
public class FilterExtractor {
  private static String TAG = "(^|\\W)@filter(\\((.*?)\\))";
  
  private static Pattern TAG_PATTERN = new Function0<Pattern>() {
    public Pattern apply() {
      Pattern _compile = Pattern.compile(FilterExtractor.TAG, Pattern.DOTALL);
      return _compile;
    }
  }.apply();
  
  public FilteringResult apply(final String input) {
      boolean _operator_equals = ObjectExtensions.operator_equals(input, null);
      if (_operator_equals) {
        return FilteringResult.EMPTY_RESULT;
      }
      StringBuilder _stringBuilder = new StringBuilder();
      final StringBuilder resultString = _stringBuilder;
      ArrayList<Filter> _newArrayList = CollectionLiterals.<Filter>newArrayList();
      final List<Filter> filters = _newArrayList;
      Matcher _matcher = FilterExtractor.TAG_PATTERN.matcher(input);
      final Matcher matcher = _matcher;
      int offset = 0;
      boolean _find = matcher.find();
      boolean _while = _find;
      while (_while) {
        {
          String _group = matcher.group(3);
          RegexFilter _create = RegexFilter.create(_group);
          CollectionExtensions.<RegexFilter>operator_add(filters, _create);
          int _start = matcher.start();
          final int nextOffset = _start;
          String _substring = input.substring(offset, nextOffset);
          resultString.append(_substring);
          int _end = matcher.end();
          offset = _end;
        }
        boolean _find_1 = matcher.find();
        _while = _find_1;
      }
      String _substring = input.substring(offset);
      resultString.append(_substring);
      String _string = resultString.toString();
      FilteringResult _filteringResult = new FilteringResult(_string, filters);
      return _filteringResult;
  }
}
