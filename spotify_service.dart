import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String accessToken;

  SpotifyService(this.accessToken);

  // Method to fetch user profile from Spotify
  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load user profile');
    }
  }
}
