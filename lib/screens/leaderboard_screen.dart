import 'package:flutter/material.dart';
import 'package:uts_cinemate/models/leaderboard.dart';
import 'package:uts_cinemate/services/api_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final ApiService apiService = ApiService();

  String selectedLeague = '4328';
  bool _isLoading = true;
  List<Leaderboard> _leaderboard = [];

  final leagues = {
    '4328': 'Premier League',
    '4332': 'Serie A',
    '4331': 'Bundesliga',
    '4335': 'La Liga',
    '4334': 'Ligue 1',
  };

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await apiService.getLeaderboard(selectedLeague);
      setState(() {
        _leaderboard = data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onLeagueChanged(String? newLeagueId) {
    if (newLeagueId != null) {
      setState(() {
        selectedLeague = newLeagueId;
      });
      _fetchLeaderboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedLeague,
              decoration: const InputDecoration(
                labelText: 'Pilih Liga',
                border: OutlineInputBorder(),
              ),
              items: leagues.entries
                  .map((entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: _onLeagueChanged,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _leaderboard.isEmpty
                    ? const Center(child: Text('Tidak ada data tersedia.'))
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Rank')),
                              DataColumn(label: Text('Team')),
                              DataColumn(label: Text('Played')),
                              DataColumn(label: Text('W')),
                              DataColumn(label: Text('D')),
                              DataColumn(label: Text('L')),
                              DataColumn(label: Text('GF')),
                              DataColumn(label: Text('GA')),
                              DataColumn(label: Text('GD')),
                              DataColumn(label: Text('Pts')),
                            ],
                            rows: _leaderboard
                                .map(
                                  (team) => DataRow(cells: [
                                    DataCell(Text(team.rank.toString())),
                                    DataCell(
                                      Row(
                                        children: [
                                          Image.network(
                                            team.badge,
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(team.team),
                                        ],
                                      ),
                                    ),
                                    DataCell(Text(team.played.toString())),
                                    DataCell(Text(team.win.toString())),
                                    DataCell(Text(team.draw.toString())),
                                    DataCell(Text(team.loss.toString())),
                                    DataCell(Text(team.goalsFor.toString())),
                                    DataCell(
                                        Text(team.goalsAgainst.toString())),
                                    DataCell(
                                        Text(team.goalDifference.toString())),
                                    DataCell(Text(team.points.toString())),
                                  ]),
                                )
                                .toList(),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
