class Apierr {
  final String message;

  Apierr({required this.message});

  factory Apierr.fromJson(Map<String, dynamic> json) {
    return Apierr(
      message: json['message'],
    );
  }
}
