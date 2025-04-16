import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://www.thesportsdb.com/api/v1/json/3";

  Future<List<Map<String, dynamic>>> getAllTeamsInLeague(String ligue) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search_all_teams.php?l=$ligue'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['teams']);
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<List<dynamic>> searchPlayers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/searchplayers.php?p=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Filter hanya pemain Soccer
      final players = data['player'] as List<dynamic>?;
      if (players == null) return [];

      return players.where((p) => p['strSport'] == 'Soccer').toList();
    } else {
      throw Exception('Failed to load players');
    }
  }
}