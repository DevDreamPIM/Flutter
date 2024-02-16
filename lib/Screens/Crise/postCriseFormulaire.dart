import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostCriseFormulaire extends StatefulWidget {
  const PostCriseFormulaire({Key? key}) : super(key: key);

  @override
  _PostCriseFormulaireState createState() => _PostCriseFormulaireState();
}

class _PostCriseFormulaireState extends State<PostCriseFormulaire> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Seizure Form',
          style: TextStyle(
            color: const Color(0xFF8A4FE9),
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Text(
              'When did you first feel the initial signs of the seizure?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'How long did the seizure last?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Did you experience an aura before the seizure? If yes, can you describe it?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Are identifiable triggering factors present (stress, lack of sleep, etc.)?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Were you injured during the seizure?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Did you experience confusion,significant fatigue or any changes in your behavior or sensations after the seizure?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: const Color(0xFF8A4FE9),
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
                // Add logic to save rating here
              },
            ),
            SizedBox(height: 20.0),

            Text(
              'Did you require medical assistance or emergency intervention?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: const Color(0xFF8A4FE9),
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
                // Add logic to save rating here
              },
            ),
            SizedBox(height: 20.0),

            Text(
              'Did you notice any changes in your emotional state before or after the seizure?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Réponse...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Text(
              'How would you describe the post-seizure recovery in terms of fatigue and the time required to regain normal capabilities?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: const Color(0xFF8A4FE9),
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
                // Add logic to save rating here
              },
            ),
            SizedBox(height: 20.0),

            //*********************************************************** */
            Text(
              'Do you have anything to add?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              maxLines: null, // Allow user to input multiple lines
              decoration: InputDecoration(
                hintText: 'Your response...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logic to save responses here
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF8A4FE9), // Set background color here
                padding: EdgeInsets.symmetric(
                    vertical: 16.0), // Adjust button height here
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 18.0, // Adjust text size here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
