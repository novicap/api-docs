## Create a user

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "company_novicap_id": "ESX7895123H",
  "first_name": "John",
  "last_name": "Snow",
  "email": "snow@novicap.com",
  "phone": "724565898",
  "language": "es"
}' \
"https://api.novicap.com/v1/users"
```

> The above command returns a empty JSON with the 201 CREATED status.

This endpoint allows you to create a user in a company that has no users associated.

If the company is not using NoviCap yet, it will be created and associated to you.

If the user does not have an account on NoviCap yet, he/she will receive an email to set the password.

### HTTP Request

`POST https://api.novicap.com/v1/users`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "company_novicap_id", "first_name", "last_name", "email"],
  "properties": {
    "api_key": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "first_name": { "type": "string" },
    "last_name": { "type": "string" },
    "email": { "type": "string" },
    "phone": { "type": ["null", "string"] },
    "language": { "type": ["null", "string"] }
  }
}
```

| Parameter          | Type   | Required | Format    | Description                                               |
|--------------------|--------|----------|-----------|-----------------------------------------------------------|
| api_key            | String | ✓        |           | Your API key for authentication                           |
| company_novicap_id | String | ✓        |           | The NoviCap ID of the company you want to add the user to |
| first_name         | String | ✓        |           | The user's first name                                     |
| last_name          | String | ✓        |           | The user's last name                                      |
| email              | String | ✓        |           | The user's email                                          |
| phone              | String |          |           | The user's phone                                          |
| language           | String |          | ISO 639-1 | The user's language                                       |

### Response

A successful response is a JSON with a 201 Created HTTP status code and the platform's URL the user can be redirected to.

| Attribute          | Type   | Unit     | Description                                               |
|--------------------|--------|----------|-----------------------------------------------------------|
| redirect_to        | String |          | The platform URL with the authentication token            |

### Status Codes

| Code | Meaning              | Description                                           |
|------|----------------------|-------------------------------------------------------|
| 201  | Created              | The user has been successfully created                |
| 403  | Forbidden            | The provided company is associated to another partner |
| 409  | Conflict             | The company is already associated with another user   |
| 422  | Unprocessable Entity | The user has not been created because of errors       |
