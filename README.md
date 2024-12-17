# MatchingApp

To fulfill your request for approach, algorithm, and demo, here's the breakdown:


---

Approach

The goal is to provide a gamified matching algorithm for a dating app that meets the requirements. Here’s a clear approach:

1. Data Modeling:
Create a User class containing fields like:

Interests (List of Strings)

Affiliations (List of Strings)

Age

Location



2. Similarity Calculation:
Use weighted calculations to determine the similarity score between Person A and others. Key criteria include:

Shared interests

Shared affiliations (e.g., clubs or memberships)

Age similarity (normalized using a mathematical function)



3. Mystery and Gamification:

Person B will see 4 profiles (Person A + 3 most similar users).

Shuffle the profiles to hide Person A's identity.

Allow Person B to "like" or "dislike" any profile. Matching happens only if Person B likes Person A.



4. Scalability:
Use sorting algorithms and efficient filtering to handle growing user bases without performance degradation.


5. Data Privacy:

Use app-provided data only, avoiding scraping third-party platforms (e.g., Instagram).

Allow users to manage their preferences and data permissions.





---

Algorithm

The matching logic consists of the following steps:

1. Input: User A (person expressing interest), List of all users.


2. Filter Out User A: Exclude User A from the list of candidates.


3. Calculate Similarity Scores: For each user:

Compare shared interests using cosine similarity.

Compare shared affiliations.

Normalize age difference using a decay function.



4. Sort Candidates: Rank users based on their similarity scores.


5. Select Top 3: Pick the top 3 most similar users.


6. Combine and Shuffle: Add User A and the top 3 users into a list and shuffle it.


7. Output: Return the shuffled list of 4 profiles.




---

Implementation in Flutter

Here is the code in Flutter with a focus on the matching algorithm:

1. User Model

class User {
  final String userId;
  final String name;
  final List<String> interests;
  final List<String> affiliations;
  final int age;

  User({
    required this.userId,
    required this.name,
    required this.interests,
    required this.affiliations,
    required this.age,
  });
}


---

2. Matching Algorithm

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


---

3. HomeScreen UI

This shows Person A's interest and the 4 shuffled profiles.

import 'package:flutter/material.dart';
import 'matching_service.dart';
import 'user_model.dart';

class HomeScreen extends StatelessWidget {
  final MatchingService matchingService = MatchingService();

  // Sample Data
  final User personA = User(
    userId: '1',
    name: 'John',
    interests: ['music', 'sports', 'travel'],
    affiliations: ['finance club', 'hiking club'],
    age: 25,
  );

  final List<User> allUsers = [
    User(userId: '2', name: 'Alice', interests: ['music', 'reading'], affiliations: ['book club'], age: 26),
    User(userId: '3', name: 'Bob', interests: ['sports', 'gaming'], affiliations: ['gaming club'], age: 24),
    User(userId: '4', name: 'Clara', interests: ['travel', 'hiking'], affiliations: ['hiking club'], age: 25),
    User(userId: '5', name: 'David', interests: ['movies', 'music'], affiliations: ['movie club'], age: 30),
  ];

  @override
  Widget build(BuildContext context) {
    List<User> similarUsers = matchingService.findSimilarUsers(personA, allUsers);
    List<User> profiles = [personA, ...similarUsers]..shuffle();

    return Scaffold(
      appBar: AppBar(title: Text('Gamified Matching System')),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          User profile = profiles[index];
          return Card(
            child: ListTile(
              title: Text(profile.name),
              subtitle: Text('Interests: ${profile.interests.join(', ')}'),
              trailing: Icon(Icons.favorite_border),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('You liked ${profile.name}'),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}


---

Demo and Testing

To run the app locally:

1. Install Flutter SDK.


2. Copy the code into a Flutter project.


3. Run the project using:

flutter run




---

Deployment

To provide a working demo:

1. I can deploy the app on Firebase Hosting or share an APK file for Android testing.


2. If you want a demo video, I can record the app in action and provide a link.



Let me know how you'd like to proceed with testing! 🚀
