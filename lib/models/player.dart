class Player {
  final String idPlayer;
  final String idTeam;
  final String name;
  final String team;
  final String sport;
  final String? thumb;
  final String nationality;
  final String dateBorn;
  final String status;
  final String gender;
  final String position;

  Player({
    required this.idPlayer,
    required this.idTeam,
    required this.name,
    required this.team,
    required this.sport,
    this.thumb,
    required this.nationality,
    required this.dateBorn,
    required this.status,
    required this.gender,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idPlayer: json['idPlayer'] ?? '',
      idTeam: json['idTeam'] ?? '',
      name: json['strPlayer'] ?? '',
      team: json['strTeam'] ?? '',
      sport: json['strSport'] ?? '',
      thumb: json['strThumb'],
      nationality: json['strNationality'] ?? '',
      dateBorn: json['dateBorn'] ?? '',
      status: json['strStatus'] ?? '',
      gender: json['strGender'] ?? '',
      position: json['strPosition'] ?? '',
    );
  }
}
