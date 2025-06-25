# Contributing to HavenHero Platform

## 🚢 Welkom bij HavenHero!

We zijn blij dat je wilt bijdragen aan het HavenHero platform! Dit document helpt je om effectief bij te dragen.

## 📋 Development Setup

### Vereisten
- PHP 8.1+
- MySQL 8.0+
- Apache/Nginx webserver
- Git

### Lokale Setup
1. Fork en clone de repository
```bash
git clone https://github.com/your-username/havenhero-platform.git
cd havenhero-platform
```

2. Database setup
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/seed_data.sql
```

3. Backend configuratie
```bash
cp backend/config/config.example.php backend/config/config.php
# Bewerk config.php met jouw database gegevens
```

## 🏗️ Project Structuur

```
havenhero-platform/
├── database/           # Database schema en seed data
├── backend/           # PHP backend (API, controllers, models)
├── frontend/          # Frontend applicaties
│   ├── marketing/     # Marketing website
│   ├── booteigenaar/  # Booteigenaar app
│   ├── havenmeester/  # Havenmeester app
│   └── eigenaar/      # Platform eigenaar dashboard
└── docs/             # Documentatie
```

## 🎯 Component Focus Areas

### Marketing Website (`frontend/marketing/`)
- Landing pages
- Product informatie
- Contact formulieren
- SEO optimalisatie

### Booteigenaar App (`frontend/booteigenaar/`)
- Haven zoeken en filteren
- Reserveringssysteem
- Bootbeheer
- Review systeem

### Havenmeester App (`frontend/havenmeester/`)
- Haven dashboard
- Plattegrond editor
- Reserveringsbeheer
- Gastencommunicatie

### Eigenaar Dashboard (`frontend/eigenaar/`)
- Platform analytics
- Multi-haven beheer
- SaaS abonnementen
- Support systeem

## 🛠️ Development Guidelines

### Code Style
- **PHP:** PSR-12 coding standard
- **JavaScript:** ES6+ met vanilla JS
- **CSS:** BEM methodology met CSS custom properties
- **HTML:** Semantisch en toegankelijk

### Naming Conventions
- **Files:** lowercase-hyphen-separated
- **CSS Classes:** BEM (block__element--modifier)
- **JavaScript:** camelCase voor variabelen, PascalCase voor classes
- **Database:** snake_case voor tabellen en kolommen

### Commit Messages
Gebruik het volgende format:
```
type(scope): description

[optional body]

🤖 Generated with [Memex](https://memex.tech)
Co-Authored-By: Memex <noreply@memex.tech>
```

Types:
- `feat`: nieuwe feature
- `fix`: bug fix
- `docs`: documentatie
- `style`: formatting, missing semicolons, etc.
- `refactor`: code refactoring
- `test`: tests toevoegen
- `chore`: maintenance

### Branch Strategy
- `main`: production-ready code
- `develop`: development branch
- `feature/feature-name`: nieuwe features
- `fix/bug-description`: bug fixes
- `docs/documentation-update`: documentatie updates

## 🧪 Testing

### Frontend Testing
- Manuele tests in meerdere browsers
- Responsive design testing
- Performance testing

### Backend Testing
- Unit tests voor API endpoints
- Database integration tests
- Security testing

## 📝 Pull Request Process

1. **Fork** de repository
2. **Create branch** van `develop`
```bash
git checkout develop
git checkout -b feature/your-feature-name
```
3. **Implement** je changes
4. **Test** je changes lokaal
5. **Commit** met beschrijvende messages
6. **Push** naar je fork
7. **Create Pull Request** naar `develop` branch

### PR Template
```markdown
## Description
Brief description van je changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested lokaal
- [ ] Cross-browser tested
- [ ] Mobile responsive tested

## Screenshots (if applicable)
```

## 🎨 Design System

### Kleuren
- Primary Blue: `#1e40af`
- Secondary Blue: `#3b82f6`
- Accent Orange: `#f97316`
- Success Green: `#10b981`
- Warning Yellow: `#f59e0b`

### Typografie
- Font Familie: Inter
- Font Sizes: Gedefinieerd in CSS custom properties
- Line Heights: 1.6 voor body text, 1.2 voor headings

## 🔒 Security Guidelines

- Sanitize alle user inputs
- Gebruik prepared statements voor database queries
- Implementeer CSRF protection
- Valideer alle uploads
- Gebruik HTTPS in productie

## 📚 Resources

- [PHP PSR-12](https://www.php-fig.org/psr/psr-12/)
- [BEM Methodology](http://getbem.com/)
- [WCAG Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## 💬 Vragen?

- Open een Issue voor bugs of feature requests
- Start een Discussion voor algemene vragen
- Check de documentatie in `/docs/`

## 📄 License

Dit project is private en eigendom van HavenHero.

---

Bedankt voor je bijdrage aan HavenHero! 🚢⚓