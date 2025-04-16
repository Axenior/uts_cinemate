import 'package:flutter/material.dart';
import 'package:uts_cinemate/models/team.dart';
import 'package:uts_cinemate/screens/detail_screen_team.dart';
import 'package:uts_cinemate/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Team> _englishPremierLeague = [];
  List<Team> _spanishLaLiga = [];
  List<Team> _germanBundesliga = [];

  bool _isLoadingEPL = true;
  bool _isLoadingLaLiga = true;
  bool _isLoadingBundesliga = true;

  @override
  void initState() {
    super.initState();
    _loadEnglishPremierLeague();
    _loadSpanishLaLiga();
    _loadGermanBundesliga();
  }

  Future<void> _loadEnglishPremierLeague() async {
    try {
      final data =
          await _apiService.getAllTeamsInLeague("English Premier League");
      if (!mounted) return;
      setState(() {
        _englishPremierLeague = data.map((e) => Team.fromJson(e)).toList();
        _isLoadingEPL = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingEPL = false);
      print("Error EPL: $e");
    }
  }

  Future<void> _loadSpanishLaLiga() async {
    try {
      final data = await _apiService.getAllTeamsInLeague("Spanish La Liga");
      if (!mounted) return;
      setState(() {
        _spanishLaLiga = data.map((e) => Team.fromJson(e)).toList();
        _isLoadingLaLiga = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingLaLiga = false);
      print("Error La Liga: $e");
    }
  }

  Future<void> _loadGermanBundesliga() async {
    try {
      final data = await _apiService.getAllTeamsInLeague("German Bundesliga");
      if (!mounted) return;
      setState(() {
        _germanBundesliga = data.map((e) => Team.fromJson(e)).toList();
        _isLoadingBundesliga = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingBundesliga = false);
      print("Error Bundesliga: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Europe Team"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildteamsList('English Premier League Team',
                _englishPremierLeague, _isLoadingEPL),
            _buildteamsList(
                'Spanish La Liga Team', _spanishLaLiga, _isLoadingLaLiga),
            _buildteamsList('German Bundesliga Team', _germanBundesliga,
                _isLoadingBundesliga),
          ],
        ),
      ),
    );
  }

  Widget _buildteamsList(String title, List<Team> teams, bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final Team team = teams[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreenTeam(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 80,
                          child: Column(
                            children: [
                              Image.network(
                                team.badge,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                team.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
