class Apiauth {
  final String access_token;
  final String token_type;
  final int expires_in;

  Apiauth(
      {required this.access_token,
      required this.token_type,
      required this.expires_in});

  factory Apiauth.fromJson(Map<String, dynamic> json) {
    return Apiauth(
      access_token: json['access_token'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
    );
  }
}
