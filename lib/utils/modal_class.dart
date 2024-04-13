class Quotes {
  final String quote, author, category;
  final int likes = 0;
  final bool isLiked = false;

  Quotes({
    required this.quote,
    required this.author,
    required this.category,
  });

  /// factory constructor for creating object of each map in allQuoteData and
  /// initializing data members in this class ie., Quotes by
  /// returning default constructor Quotes().
  factory Quotes.fromMap({required Map object}) => Quotes(
        quote: object['quote'],
        author: object['author'],
        category: object['category'],
      );

  /// getter toMap for converting the this class's data back into the map format for
  /// easy manipulation through out multiple screens.
  Map<String, dynamic> get toMap => {
        'quote': quote,
        'author': author,
        'category': category,
        'likes': likes,
        'isLiked': isLiked,
      };
}
