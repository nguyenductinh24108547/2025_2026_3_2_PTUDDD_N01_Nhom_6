class Vocabulary {
  final String id;
  final String term;
  final String definition;
  final String example;

  const Vocabulary({
    required this.id,
    required this.term,
    required this.definition,
    this.example = '',
  });
}
