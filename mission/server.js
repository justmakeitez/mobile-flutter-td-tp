const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
app.use(express.json());

const dataPath = path.join(__dirname, 'data');
const produitsFile = path.join(dataPath, "produits.json");
const commandesFile = path.join(dataPath, "commandes.json");

// Créer le dossier data s'il n'existe pas
if (!fs.existsSync(dataPath)) {
  fs.mkdirSync(dataPath);
}

// Initialiser les fichiers s'ils n'existent pas
if (!fs.existsSync(produitsFile)) {
  fs.writeFileSync(produitsFile, "[]");
}
if (!fs.existsSync(commandesFile)) {
  fs.writeFileSync(commandesFile, "[]");
}

const lireFichier = (file) => {
  try {
    return JSON.parse(fs.readFileSync(file, "utf-8"));
  } catch (e) {
    console.error(`Erreur lecture ${file}:`, e);
    return [];
  }
};

const ecrireFichier = (file, data) => {
  try {
    fs.writeFileSync(file, JSON.stringify(data, null, 2));
  } catch (e) {
    console.error(`Erreur écriture ${file}:`, e);
  }
};

app.get("/produits", (req, res) => {
  const produits = lireFichier(produitsFile).filter(p => p !== null);
  res.json(produits);
});

app.post("/produits", (req, res) => {
  let produits = lireFichier(produitsFile);
  const nouveauProduit = {...req.body, id: produits.length + 1};
  produits.push(nouveauProduit);
  ecrireFichier(produitsFile, produits);
  res.json(nouveauProduit);
});

app.get("/commandes", (req, res) => {
  const commandes = lireFichier(commandesFile).filter(c => c !== null);
  res.json(commandes);
});

app.post("/commandes", (req, res) => {
  let commandes = lireFichier(commandesFile);
  const nouvelleCommande = {...req.body, id: commandes.length + 1};
  commandes.push(nouvelleCommande);
  ecrireFichier(commandesFile, commandes);
  res.json(nouvelleCommande);
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Serveur lancé sur le port ${PORT}`));