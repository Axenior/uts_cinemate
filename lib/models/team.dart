class Team {
  final String id;
  final String name;
  final String shortName;
  final String formedYear;
  final String league;
  final String stadium;
  final String location;
  final String description;
  final String badge;

  Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.formedYear,
    required this.league,
    required this.stadium,
    required this.location,
    required this.description,
    required this.badge,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['idTeam'] ?? '',
      name: json['strTeam'] ?? '',
      shortName: json['strTeamShort'] ?? '',
      formedYear: json['intFormedYear'] ?? '',
      league: json['strLeague'] ?? '',
      stadium: json['strStadium'] ?? 'Unknown',
      location: json['strLocation'] ?? '',
      description: json['strDescriptionEN'] ?? '',
      badge: json['strBadge'],
    );
  }
}

