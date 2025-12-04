class Review {
  Review({
    required this.title,
    required this.rating,
    this.comment,
  });

  String title;
  String? comment;
  int rating; 
}
