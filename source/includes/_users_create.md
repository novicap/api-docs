## Create a user

This endpoint allows you to create a user in a company that has no users associated.

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "your_api_key",
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

Possible returned status codes:

-   201 (created) if the user has been created.
-   409 (conflict) the company is already associated with another user.
-   422 (unprocessable entity) the user has not been created because of errors.

### HTTP Request

`POST https://api.novicap.com/v1/users`

> The params for this endpoint should match this json schema:

```json
{
  "type": "object",
  "required": ["company_novicap_id", "user"],
  "properties": {
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

### Data

Parameter          | Required | Description
-------------------|----------|-------------------------------------------------------------------------------
api_key            | ✓        | Your api key for authentication.
company_novicap_id | ✓        | The NoviCap ID of the company.
user               | ✓        | The user you want to create, in json format (see the following table)

The user object should have the following fields:

Parameter          | Required | Description
-------------------|----------|----------------------------------------------------------
first_name         | ✓        | The user's first name
last_name          | ✓        | The user's last name
email              | ✓        | The user's last name
phone              |          | The user's phone
language           |          | An ISO 639-1 code (e.g. ‘en’) for the user's language

### Response

A successful response is an empty JSON with a 201 created HTTP status code.
