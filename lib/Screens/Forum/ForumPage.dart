import 'package:flutter/material.dart';
import 'package:epilepto_guard/models/Forum.dart';
import 'package:epilepto_guard/models/UserForum.dart';
import 'package:epilepto_guard/widgets/ForumCard.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ForumCard(
                    forum: Forum(description: "Très bon forum pour les débutants", comments: []),
                    user: UserForum(firstName: "Mohamed Maamoun", lastName: "Jrad"),
                  ),
                  SizedBox(height: 20),
                  ForumCard(
                    forum: Forum(description: "J'aime les discussions ici", comments: []),
                    user: UserForum(firstName: "Malek", lastName: "Labidi"),
                  ),
                  SizedBox(height: 20),
                  ForumCard(
                    forum: Forum(description: "Toujours à jour avec les nouveautés", comments: []),
                    user: UserForum(firstName: "Jouhayna", lastName: "Cheikh"),
                  ),
                  SizedBox(height: 20),
                  ForumCard(
                    forum: Forum(description: "Super expérience utilisateur", comments: []),
                    user: UserForum(firstName: "Marwan", lastName: "Hammami"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a Feedback...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
  onPressed: () {
    // Action à effectuer lors de l'envoi du commentaire
  },
  child: Text(
    'Send',
    style: TextStyle(color: Colors.white),  // Définir la couleur du texte en blanc
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColor,  // Définir la couleur de fond du bouton
  ),
)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
