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