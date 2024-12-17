import 'dart:math';
import 'user_model.dart';

class MatchingService {
  // Calculate shared interests using cosine similarity
  double calculateInterestSimilarity(List<String> interestsA, List<String> interestsB) {
    int commonCount = interestsA.where((interest) => interestsB.contains(interest)).length;
    return commonCount / (sqrt(interestsA.length) * sqrt(interestsB.length));
  }

  // Calculate shared affiliations
  double calculateAffiliationScore(List<String> affiliationsA, List<String> affiliationsB) {
    int common = affiliationsA.where((aff) => affiliationsB.contains(aff)).length;
    return common / max(affiliationsA.length, affiliationsB.length);
  }

  // Normalize age difference
  double calculateAgeSimilarity(int ageA, int ageB) {
    double ageDiff = (ageA - ageB).abs().toDouble();
    return 1 / (1 + ageDiff);
  }

  // Final similarity score
  double calculateSimilarity(User userA, User userB) {
    double interestScore = calculateInterestSimilarity(userA.interests, userB.interests);
    double affiliationScore = calculateAffiliationScore(userA.affiliations, userB.affiliations);
    double ageScore = calculateAgeSimilarity(userA.age, userB.age);

    return (0.5 * interestScore) + (0.3 * affiliationScore) + (0.2 * ageScore);
  }

  // Find similar users
  List<User> findSimilarUsers(User personA, List<User> allUsers) {
    List<User> candidates = allUsers.where((user) => user.userId != personA.userId).toList();

    // Sort users by similarity
    candidates.sort((a, b) => calculateSimilarity(personA, b).compareTo(calculateSimilarity(personA, a)));

    // Select top 3
    return candidates.take(3).toList();
  }
}