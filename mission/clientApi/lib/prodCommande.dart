class Produit {
  final String nom;
  double prix;
  int stock;
  final String categorie;

  Produit(this.nom, this.prix, this.stock, this.categorie);

  void afficherDetails() {
    print("Produit : $nom\nPrix : \$${prix.toStringAsFixed(2)}\nStock disponible : $stock\nCatégorie : $categorie");
  }

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'prix': prix,
    'stock': stock,
    'categorie': categorie,
  };
}

class Commande {
  final int id;
  final Map<Produit, int> produits = {};
  double total = 0.0;

  Commande(this.id);

  void ajouterProduit(Produit produit, int quantite) {
    if (produit.stock >= quantite) {
      produit.stock -= quantite;
      produits[produit] = (produits[produit] ?? 0) + quantite;
      calculerTotal();
    } else {
      throw StockInsuffisantException("Stock insuffisant pour ${produit.nom}");
    }
  }

  void calculerTotal() {
    total = 0.0;
    produits.forEach((produit, quantite) => total += quantite * produit.prix);
  }

  void afficherCommande() {
    if (produits.isNotEmpty) {
      print("Commande ID: $id, Total: $total DH");
      produits.forEach((produit, quantite) {
        print(" ${produit.nom} x $quantite = ${produit.prix * quantite} DH");
      });
    } else {
      throw CommandeVideException("La commande est vide");
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'produits': produits.map((key, value) => MapEntry(key.nom, value)),
    'total': total,
  };
}

class StockInsuffisantException implements Exception {
  final String message;
  StockInsuffisantException(this.message);
  @override
  String toString() => "Erreur: $message";
}

class CommandeVideException implements Exception {
  final String message;
  CommandeVideException(this.message);
  @override
  String toString() => "Erreur: $message";
}