# HavenHero Platform

Een volledig havenbeheer platform bestaande uit vier componenten:

## 🚢 Componenten

### 1. HavenHero Booteigenaar Web App
Voor het zoeken en reserveren van ligplaatsen door booteigenaren.

### 2. HavenHero Havenmeester Web App  
Voor het beheren van havens en reserveringen door havenmeesters.

### 3. HavenHero Eigenaar Dashboard
Voor SaaS beheer en analytics van het volledige platform.

### 4. HavenHero Marketing Website
Voor sales en productinformatie.

## 🛠 Technische Specificaties

- **Backend:** PHP 8+ met MySQL database
- **Frontend:** HTML5, CSS3, JavaScript (vanilla)
- **Design:** Mobile-first, responsive approach
- **Styling:** Licht, toegankelijk en professioneel
- **Database:** MySQL met genormaliseerde structuur
- **Authenticatie:** Sessie-gebaseerd met gebruikersrollen

## 🎨 Kleurenschema

- **Primair:** Maritiem blauw (#1e40af)
- **Secundair:** Licht blauw (#3b82f6) 
- **Accent:** Oranje (#f97316)
- **Neutraal:** Grijs tinten (#f8fafc, #64748b)
- **Succes:** Groen (#10b981)
- **Waarschuwing:** Geel (#f59e0b)

## 📁 Repository Structuur

```
havenhero-platform/
├── README.md
├── database/
│   ├── schema.sql
│   └── seed_data.sql
├── backend/
│   ├── config/
│   ├── models/
│   ├── controllers/
│   ├── api/
│   └── includes/
├── frontend/
│   ├── assets/css/
│   ├── booteigenaar/
│   ├── havenmeester/
│   ├── eigenaar/
│   └── marketing/
└── docs/
    ├── api-documentation.md
    ├── user-manual.md
    └── deployment-guide.md
```

## 🚀 Installatie

1. Clone de repository
```bash
git clone https://github.com/guidothomassen93/havenhero-platform.git
cd havenhero-platform
```

2. Setup database (zie database/schema.sql)
```bash
mysql -u username -p < database/schema.sql
mysql -u username -p < database/seed_data.sql
```

3. Configureer backend (zie backend/config/)
4. Start lokale server

## 📚 Development

Ontwikkelingsinstructies en API documentatie staan in de `docs/` directory.

## 🌐 Demo

- **Marketing Website:** `/frontend/marketing/index.html`
- **Booteigenaar App:** `/frontend/booteigenaar/index.html`
- **Havenmeester App:** `/frontend/havenmeester/index.html`
- **Eigenaar Dashboard:** `/frontend/eigenaar/index.html`

## 📊 Features

### Voor Booteigenaren
- Zoeken en filteren van havens
- Realtime beschikbaarheid
- Online reservering en betaling
- Bootbeheer
- Reviews en ratings

### Voor Havenmeesters
- Dashboard met overzichten
- Plattegrond editor
- Reserveringsbeheer
- Gastencommunicatie
- Rapportages

### Voor Platform Eigenaren
- Multi-haven analytics
- SaaS abonnementenbeheer
- Gebruikersbeheer
- System health monitoring
- Support ticketing

---

🤖 Generated with [Memex](https://memex.tech)
Co-Authored-By: Memex <noreply@memex.tech>