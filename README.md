# 💅 Classy – Beauty & Wellness Platform  

**Classy** est une application innovante permettant aux utilisateurs de rechercher, réserver et évaluer des **salons de coiffure, centres de beauté et spas en Tunisie**.  
Les propriétaires de centres disposent d’un **BackOffice puissant** pour gérer leurs services, personnels et réservations, tandis que les clients bénéficient d’une **expérience fluide et intuitive**.  

---

## ✨ Fonctionnalités  

### 🖥️ BackOffice (Web)  
- 🏢 **Gestion des centres** : informations, horaires, photos, évaluations, commentaires  
- 🗂️ **Gestion des catégories**  
- 💇 **Gestion des services**  
- 🎁 **Gestion des offres & réductions**  
- 👤 **Gestion des propriétaires**  
- 👥 **Gestion des personnels** (créés uniquement par les propriétaires)  
- 👨‍💼 **Profil individuel pour chaque personnel** avec accès à ses rendez-vous  
- 📨 **Gestion des demandes d’inscription** (validation par l’admin)  
- 📊 **Dashboard analytique avancé** (statistiques de réservations, popularité, performances)  

### 📱 FrontOffice (Web + Mobile)  
- 🔎 **Recherche de centres** par emplacement, catégorie ou service  
- 🗺️ **Recherche avancée par carte (Mapbox)**  
- 📖 **Affichage détaillé des centres** (photos, adresse, horaires, avis, services)  
- 📅 **Gestion des réservations** : prise, modification et annulation de rendez-vous  
- 💳 **Paiement en ligne sécurisé via Stripe**  
- 🔔 **Notifications en temps réel**  
- 📧 **Confirmation par email après réservation**  
- ⭐ **Évaluations & commentaires des clients**  

---

## 🛠️ Stack technique  

### Frontend  
- ⚛️ **React.js** → Application Web (FrontOffice & BackOffice)  
- 📱 **Flutter** → Application mobile multi-plateformes (iOS/Android)  
- 🎨 **TailwindCSS + Bootstrap 5** → UI & design responsive  

### Backend  
- 🟢 **Node.js + Express** → API REST  
- 🗄️ **MySQL** → Base de données relationnelle  

### Autres outils  
- 🔑 **JWT Authentication** → Authentification sécurisée  
- 💳 **Stripe** → Paiement en ligne  
- 📊 **Recharts** → Visualisation des statistiques  
- 🗺️ **Mapbox** → Recherche & affichage sur carte  
- 📧 **Nodemailer** → Confirmation email  

---
## 📂 Structure du projet  
classy/
│── backend/ # Node.js + Express (API + logique métier)
│── frontend/ # React.js (Web - BackOffice & FrontOffice)
│── mobile/ # Flutter (Mobile App iOS & Android)
│── database/ # Scripts MySQL (schémas & seeds)
│── README.md # Documentation principale


---

## ⚡ Installation & lancement  

### 🔧 Backend (Node.js + Express)  
```bash
cd backend
npm install
npm start
```
### 🎨 Frontend Web (React.js)
```bash
cd frontend
npm install
npm run dev
```
### 📱 Mobile (Flutter) 
```bash
cd mobile
flutter pub get
flutter run
```
### 🗄️ Base de données (MySQL)
CREATE DATABASE classy;


### 📊 Architecture
flowchart LR
    ClientWeb[💻 React.js] --> API[🟢 Node.js + Express]
    Mobile[📱 Flutter] --> API
    API --> DB[(🗄️ MySQL)]
    API --> Stripe[💳 Paiement Stripe]
    API --> Email[📧 Confirmation Email]
    API --> Notif[🔔 Notifications]
    API --> Mapbox[🗺️ Recherche par carte]
    Admin[👨‍💼 BackOffice] --> API
## 📂 Structure du projet  

