import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> recupererProduits() async {
    final response = await http.get(Uri.parse('$baseUrl/produits'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception('Échec du chargement des produits');
    }
  }

  static Future<void> ajouterProduit(Map<String, dynamic> produit) async {
    final response = await http.post(
      Uri.parse('$baseUrl/produits'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(produit),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de l\'ajout du produit');
    }
  }

  static Future<List<dynamic>> recupererCommandes() async {
    final response = await http.get(Uri.parse('$baseUrl/commandes'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List;
    } else {
      throw Exception('Échec du chargement des commandes');
    }
  }

  static Future<void> ajouterCommande(Map<String, dynamic> commande) async {
    final response = await http.post(
      Uri.parse('$baseUrl/commandes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(commande),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de l\'ajout de la commande');
    }
  }
}