# HavenHero API Documentatie

## Overzicht
HavenHero REST API voor havenbeheer platform met vier hoofdcomponenten:
- Booteigenaar endpoints
- Havenmeester endpoints  
- Platform eigenaar endpoints
- Publieke endpoints

## Basis URL
```
https://api.havenhero.nl/v1
```

## Authenticatie
API gebruikt JWT tokens voor authenticatie:
```
Authorization: Bearer <jwt_token>
```

## Gebruikersrollen
- `booteigenaar` - Boot eigenaren die ligplaatsen reserveren
- `havenmeester` - Haven beheerders
- `eigenaar` - Platform beheerders/eigenaren

## Endpoints

### Authenticatie
```http
POST /auth/login
POST /auth/register
POST /auth/logout
POST /auth/refresh
POST /auth/forgot-password
POST /auth/reset-password
```

### Gebruikers
```http
GET /users/profile
PUT /users/profile
GET /users/{id}
PUT /users/{id}/avatar
```

### Havens
```http
GET /havens
GET /havens/{id}
POST /havens
PUT /havens/{id}
DELETE /havens/{id}
GET /havens/search
GET /havens/{id}/reviews
GET /havens/{id}/plattegrond
```

### Ligplaatsen
```http
GET /havens/{haven_id}/ligplaatsen
GET /ligplaatsen/{id}
POST /havens/{haven_id}/ligplaatsen
PUT /ligplaatsen/{id}
DELETE /ligplaatsen/{id}
GET /ligplaatsen/{id}/beschikbaarheid
```

### Boten
```http
GET /boten
GET /boten/{id}
POST /boten
PUT /boten/{id}
DELETE /boten/{id}
```

### Reserveringen
```http
GET /reserveringen
GET /reserveringen/{id}
POST /reserveringen
PUT /reserveringen/{id}
DELETE /reserveringen/{id}
GET /reserveringen/{id}/bevestiging
POST /reserveringen/{id}/checkin
POST /reserveringen/{id}/checkout
```

### Betalingen
```http
GET /betalingen
GET /betalingen/{id}
POST /betalingen
GET /betalingen/{id}/status
POST /betalingen/{id}/refund
```

### Reviews
```http
GET /reviews
GET /reviews/{id}
POST /reviews
PUT /reviews/{id}
DELETE /reviews/{id}
POST /reviews/{id}/response
```

### Berichten
```http
GET /berichten
GET /berichten/{id}
POST /berichten
PUT /berichten/{id}/read
DELETE /berichten/{id}
```

## Response Formaten

### Succes Response
```json
{
  "success": true,
  "data": {
    // response data
  },
  "message": "Operatie succesvol"
}
```

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validatie fout",
    "details": {
      "field": "email",
      "message": "Ongeldig emailadres"
    }
  }
}
```

## Status Codes
- `200` - OK
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Internal Server Error

## Rate Limiting
- 1000 requests per uur per API key
- 100 requests per minuut per IP

## Webhooks
```http
POST /webhooks/payment-status
POST /webhooks/reservation-status
```

## SDK's
- PHP SDK
- JavaScript SDK
- Mobile SDK (React Native)

## Voorbeelden

### Haven zoeken
```javascript
fetch('/api/v1/havens/search?location=Amsterdam&checkin=2024-07-15&checkout=2024-07-18', {
  headers: {
    'Authorization': 'Bearer ' + token
  }
})
.then(response => response.json())
.then(data => console.log(data));
```

### Reservering maken
```javascript
fetch('/api/v1/reserveringen', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ' + token
  },
  body: JSON.stringify({
    ligplaats_id: 1,
    boot_id: 2,
    check_in_date: '2024-07-15',
    check_out_date: '2024-07-18',
    guests_count: 2,
    special_requests: 'Rustige ligplaats gewenst'
  })
})
.then(response => response.json())
.then(data => console.log(data));
```