import 'dart:convert';

enum ChallengeType {
  vocabulary,
  flashcards,
  practice,
  conversation
}

class DailyChallenge {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final int targetValue;
  final int currentValue;
  final int rewardPoints;
  final bool isCompleted;
  final DateTime date;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    required this.rewardPoints,
    this.isCompleted = false,
    required this.date,
  });

  DailyChallenge copyWith({
    int? currentValue,
    bool? isCompleted,
  }) {
    return DailyChallenge(
      id: id,
      title: title,
      description: description,
      type: type,
      targetValue: targetValue,
      currentValue: currentValue ?? this.currentValue,
      rewardPoints: rewardPoints,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.index,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'rewardPoints': rewardPoints,
      'isCompleted': isCompleted,
      'date': date.toIso8601String(),
    };
  }

  factory DailyChallenge.fromJson(Map<String, dynamic> json) {
    return DailyChallenge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: ChallengeType.values[json['type']],
      targetValue: json['targetValue'],
      currentValue: json['currentValue'] ?? 0,
      rewardPoints: json['rewardPoints'],
      isCompleted: json['isCompleted'] ?? false,
      date: DateTime.parse(json['date']),
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory DailyChallenge.fromJsonString(String source) =>
      DailyChallenge.fromJson(jsonDecode(source));

  double get progress => currentValue / targetValue;
}
