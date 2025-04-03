import '../lib/prodCommande.dart';
import '../lib/api_client.dart';

void main() async {
  // Création de la liste des produits
  List<Produit> produits = [
    Produit("Téléphone", 5000, 10, "Phone"),
    Produit("Ordinateur", 12000, 5, "Electronics"),
    Produit("Casque", 800, 20, "Accessories")
  ];

  // Création d'une nouvelle commande
  Commande commande1 = Commande(1);

  try {
    // Ajout des produits à la commande
    commande1.ajouterProduit(produits[0], 2);
    commande1.ajouterProduit(produits[1], 1);
    
    // Affichage de la commande
    commande1.afficherCommande();
  } catch (e) {
    print(e);
  }

  print("\n📡 Test API REST (Node.js Express)");
  
  try {
    // Tests des requêtes API
    final produitsApi = await ApiClient.recupererProduits();
    print('Produits du serveur: $produitsApi');

    await ApiClient.ajouterProduit({
      "nom": "Tablette",
      "prix": 3000,
      "stock": 15,
      "categorie": "Electronics"
    });

    final commandesApi = await ApiClient.recupererCommandes();
    print('Commandes du serveur: $commandesApi');

    await ApiClient.ajouterCommande(commande1.toJson());
  } catch (e) {
    print('Erreur API: $e');
  }
}