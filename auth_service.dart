import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class SpotifyAuthService {
  // Define Spotify credentials and parameters
  final String clientId =
      'ffe728b4bacc4093994cdb50aedb45aa'; // Replace with your Spotify Client ID
  final String clientSecret =
      '5fadc31f0e4f47b29b4fcf312be2d803'; // Replace with your Spotify Client Secret
  final String redirectUri =
      'http://localhost:8888/callback'; // Change this URI as needed
  final String scopes = 'user-read-private user-read-email';

  // This method starts the authentication process
  Future<String?> authenticate() async {
    // Build the Spotify authentication URL
    final String authUrl =
        'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=$scopes';

    // Launch the web auth flow
    final result = await FlutterWebAuth.authenticate(
      url: authUrl,
      callbackUrlScheme: "http",
    );

    // Extract the authorization code from the callback URL
    final code = Uri.parse(result).queryParameters['code'];

    // If code is null, something went wrong
    if (code == null) {
      throw Exception('Authorization failed');
    }

    // Exchange the authorization code for an access token
    final accessToken = await _getToken(code);
    return accessToken;
  }

  // This method exchanges the authorization code for an access token
  Future<String?> _getToken(String code) async {
    final response = await http.post(
      Uri.parse("https://accounts.spotify.com/api/token"),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token']; // Access token to use for API calls
    } else {
      throw Exception('Failed to obtain access token');
    }
  }
}
