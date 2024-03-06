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
}
