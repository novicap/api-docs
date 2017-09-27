## Create a user

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "company_novicap_id": "ESX7895123H",
  "user": {
    "first_name": "John",
    "last_name": "Snow",
    "email": "snow@novicap.com",
    "phone": "724565898",
    "language": "es"
  }
}' \
"https://api.novicap.com/v1/users"
```

> The above command returns a empty JSON with the 201 CREATED status.

This endpoint allows you to create a user in a company that has no users associated.

### HTTP Request

`POST https://api.novicap.com/v1/users`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "company_novicap_id", "user"],
  "properties": {
    "api_key": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "user": {
      "type": "object",
      "required": ["first_name", "last_name", "email"],
      "properties": {
        "first_name": { "type": "string" },
        "last_name": { "type": "string" },
        "email": { "type": "string" },
        "phone": { "type": ["null", "string"] },
        "language": { "type": ["null", "string"] }
      }
    }
  }
}
```

| Parameter          | Type   | Required | Description                                                           |
|--------------------|--------|----------|-----------------------------------------------------------------------|
| api_key            | String | ✓        | Your API key for authentication                                       |
| company_novicap_id | String | ✓        | The `novicap_id` of the company you want to add the user to           |
| user               | Object | ✓        | The user you want to create, in JSON format (see the following table) |

The user object should have the following fields:

| Parameter  | Type   | Required | Format             | Description           |
|------------|--------|----------|-----------|-----------------------|
| first_name | String | ✓        |           | The user's first name |
| last_name  | String | ✓        |           | The user's last name  |
| email      | String | ✓        |           | The user's email      |
| phone      | String |          |           | The user's phone      |
| language   | String |          | ISO 639-1 | The user's language   |

### Response

A successful response is an empty JSON with a 201 Created HTTP status code.

### Status Codes

| Code | Meaning              | Description                                         |
|------|----------------------|-----------------------------------------------------|
| 201  | Created              | The user has been created                           |
| 409  | Conflict             | The company is already associated with another user |
| 422  | Unprocessable Entity | The user has not been created because of errors     |
