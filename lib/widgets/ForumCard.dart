import 'package:flutter/material.dart';
import 'package:epilepto_guard/models/Forum.dart';
import 'package:epilepto_guard/services/ForumService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForumCard extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final Forum forum;

  ForumCard({required this.forum, this.firstName, this.lastName});

  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  bool _liked = false;
  late String loadedFirstName;
  late String loadedLastName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = FlutterSecureStorage();

    loadedFirstName = await storage.read(key: "firstName") ?? '';
    loadedLastName = await storage.read(key: "lastName") ?? '';

    setState(() {}); // Mettre à jour l'état après le chargement des données
  }

  void deleteFeedback(String description) async {
    try {
      await ForumService().deleteFeedback(description);
    } catch (e) {
      // Ignorer les erreurs de suppression
    }
  }

  void toggleLike() {
    setState(() {
      _liked = !_liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Choose the right option'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors de la sélection de l'option "Modify"
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Modify', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      // Action à effectuer lors de la sélection de l'option "Delete"
                      Navigator.of(context).pop();
                      deleteFeedback(widget.forum.description ?? '');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Delete', style: TextStyle(color: Colors.red)),
                        SizedBox(width: 8),
                        Icon(Icons.delete, color: Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.all(8.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${loadedFirstName} ${loadedLastName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${widget.forum.description}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: toggleLike,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: _liked ? Colors.red : Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(_liked ? 'You Liked this Feedback' : 'Like'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Comment'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
