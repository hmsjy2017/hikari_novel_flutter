const String kWordJoiner = '\u2060';

const String _leadingPunctuationChars = '，。、？！：；）】》〉」』”’…—～,.!?:;)]}>';

final RegExp _leadingPunctuationExp = RegExp('([${RegExp.escape(_leadingPunctuationChars)}])');
final RegExp _wordJoinerBeforeLeadingPunctuationExp = RegExp('$kWordJoiner(?=[${RegExp.escape(_leadingPunctuationChars)}])');

/// Returns true when [text] is a punctuation mark that should not start a
/// Chinese reading line.
bool isChineseLeadingPunctuation(String text) => text.isNotEmpty && _leadingPunctuationChars.contains(text[0]);

/// Inserts a word joiner before Chinese line-start-prohibited punctuation so
/// Flutter's native text layout keeps the punctuation with the previous glyph.
String keepChinesePunctuationWithPreviousLine(String text) {
  if (text.isEmpty) return text;
  return text.replaceAll(_wordJoinerBeforeLeadingPunctuationExp, '').replaceAllMapped(_leadingPunctuationExp, (match) => '$kWordJoiner${match.group(1)}');
}
