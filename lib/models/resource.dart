class Resource {
  Resource({
    this.title,
    this.lang,
    this.group,
    this.description,
    this.publisher,
    this.category,
    this.isRecommended,
    this.references,
  });

  final String title;
  final String lang;
  final String group;
  final String description;
  final String publisher;
  final String category;
  final bool isRecommended;
  final List<Reference> references;
}

class Reference {
  Reference({this.title, this.description, this.url, this.buttonText});

  final String title;
  final String description;
  final String url;
  final String buttonText;
}
