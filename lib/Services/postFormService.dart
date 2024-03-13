import 'dart:convert';
import 'package:epilepto_guard/Models/postCriseForm.dart';
import 'package:epilepto_guard/Utils/Constantes.dart';
import 'package:http/http.dart' as http;

class PostFormService {
  static const String baseURL = Constantes.URL_API;

  Future<String?> sendDataToBackend(PostCriseFormData formData) async {
    final url = baseURL + '/postCriseForm';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData.toJson()),
      );

      if (response.statusCode == 200) {
        // La requête a réussi, traitez la réponse si nécessaire
        final responseData = jsonDecode(response.body);
        return responseData['criseId']; // Récupérer l'ID de la crise
      } else {
        // La requête a échoué, affichez le code d'erreur
        print('Erreur lors de la requête : ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou de traitement
      print('Erreur lors de l\'envoi des données au backend : $e');
      return null;
    }
  }

  Future<PostCriseFormData?> getFormData(String id) async {
    final url = baseURL +
        '/postCriseForm'; // L'URL pour récupérer les données du formulaire

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PostCriseFormData.fromJson(jsonData);
      } else {
        print(
            'Erreur lors de la récupération des données du formulaire : ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des données du formulaire : $e');
      return null;
    }
  }

  Future<bool> checkIfFormSubmitted(String crisisId) async {
    final url =
        '$baseURL/seizures/$crisisId/formData'; // URL pour vérifier si un formulaire est soumis

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // Vérifiez si des données de formulaire sont renvoyées
        // Si des données sont renvoyées, cela signifie qu'un formulaire est soumis
        return jsonData != null;
      } else {
        print(
            'Erreur lors de la vérification de la soumission du formulaire : ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(
          'Erreur lors de la vérification de la soumission du formulaire : $e');
      return false;
    }
  }
}
