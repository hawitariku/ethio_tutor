import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_challenge.dart';

class ChallengeService {
  static const String _challengeKey = 'daily_challenge';
  
  final List<DailyChallenge> _templates = [
    DailyChallenge(
      id: 'vocab_5',
      title: 'Word Hunter',
      description: 'Review 5 new vocabulary words',
      type: ChallengeType.vocabulary,
      targetValue: 5,
      rewardPoints: 50,
      date: DateTime.now(),
    ),
    DailyChallenge(
      id: 'flash_10',
      title: 'Flash Master',
      description: 'Complete 10 flashcards',
      type: ChallengeType.flashcards,
      targetValue: 10,
      rewardPoints: 100,
      date: DateTime.now(),
    ),
    DailyChallenge(
      id: 'practice_15',
      title: 'Dedicated Learner',
      description: 'Practice for 15 minutes',
      type: ChallengeType.practice,
      targetValue: 15,
      rewardPoints: 150,
      date: DateTime.now(),
    ),
    DailyChallenge(
      id: 'chat_3',
      title: 'Talkative',
      description: 'Exchange 3 messages with the AI',
      type: ChallengeType.conversation,
      targetValue: 3,
      rewardPoints: 75,
      date: DateTime.now(),
    ),
  ];

  Future<DailyChallenge> getDailyChallenge() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_challengeKey);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (jsonString != null) {
      final challenge = DailyChallenge.fromJsonString(jsonString);
      final challengeDate = DateTime(challenge.date.year, challenge.date.month, challenge.date.day);
      
      if (challengeDate == today) {
        return challenge;
      }
    }

    // Generate new challenge for today
    final random = Random();
    final template = _templates[random.nextInt(_templates.length)];
    final newChallenge = DailyChallenge(
      id: template.id,
      title: template.title,
      description: template.description,
      type: template.type,
      targetValue: template.targetValue,
      rewardPoints: template.rewardPoints,
      date: today,
    );

    await saveChallenge(newChallenge);
    return newChallenge;
  }

  Future<void> saveChallenge(DailyChallenge challenge) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_challengeKey, challenge.toJsonString());
  }

  Future<void> updateProgress(ChallengeType type, int increment) async {
    final challenge = await getDailyChallenge();
    if (challenge.type == type && !challenge.isCompleted) {
      final newValue = challenge.currentValue + increment;
      final isNowCompleted = newValue >= challenge.targetValue;
      
      final updatedChallenge = challenge.copyWith(
        currentValue: newValue > challenge.targetValue ? challenge.targetValue : newValue,
        isCompleted: isNowCompleted,
      );
      
      await saveChallenge(updatedChallenge);
    }
  }
}
