## Create an SME account

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "company_novicap_id": "ESX7895123H",
  "debtor_novicap_ids": ["ESB12345678", "ESC12345678"]
  "first_name": "John",
  "last_name": "Snow",
  "email": "snow@novicap.com",
  "phone": "724565898",
  "language": "es"
}' \
"https://api.novicap.com/v1/accounts"
```

> The above command returns the following response:

```json
{
  "redirect_to": "https://esx7895123h.novicap.com?token=12345",
}
```

Allows you to create 
- a company
- debtors inside that company
- the first user of that company

and provides a URL which you can redirect to which logs the user into the platform inside the new account.

### HTTP Request

`POST https://api.novicap.com/v1/accounts`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "company_novicap_id", "debtor_novicap_ids", "first_name", "last_name", "email"],
  "properties": {
    "api_key": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "debtor_novicap_ids": { "type": "array" },
    "first_name": { "type": "string" },
    "last_name": { "type": "string" },
    "email": { "type": "string" },
    "phone": { "type": ["null", "string"] },
    "language": { "type": ["null", "string"] }
  }
}
```

| Parameter          | Type   | Required | Format    | Description                                                                   |
|--------------------|--------|----------|-----------|-------------------------------------------------------------------------------|
| api_key            | String | ✓        |           | Your API key for authentication                                               |
| company_novicap_id | String | ✓        |           | The NoviCap ID of the company you want to add the user to                     |
| debtor_novicap_ids | Array  |          |           | A list of NoviCap IDs of the debtors you want to add to the company's account |
| first_name         | String | ✓        |           | The user's first name                                                         |
| last_name          | String | ✓        |           | The user's last name                                                          |
| email              | String | ✓        |           | The user's email                                                              |
| phone              | String |          |           | The user's phone                                                              |
| language           | String |          | ISO 639-1 | The user's language                                                           |

### Response

A successful response is a JSON with a 201 Created HTTP status code and the platform's URL the user can be redirected to.

| Attribute   | Type   | Unit | Description                                                                |
|-------------|--------|------|----------------------------------------------------------------------------|
| redirect_to | String |      | A URL with an authentication token. User should be redirected to this URL. |

If the request is well-formed but we can't create the account (e.g. invalid novicap ID), the response will be a 422 Unprocessible Entity along with a description of the problem in an HTML string.

| Attribute | Type   | Unit | Description                                                                                                         |
|-----------|--------|------|---------------------------------------------------------------------------------------------------------------------|
| message   | String |      | A message describing the problem in the language requested, which can be presented to the user without modification |

### Status Codes

| Code | Meaning                  | Description                                                                                  |
|------|--------------------------|----------------------------------------------------------------------------------------------|
|  201 | Created                  | The account has been successfully created                                                    |
|  400 | Bad request              | The data provided does not match the required schema; this is a developer error on your side |
|  422 | Problem creating account | There were problems with the data the user provided, so we can't create the account          |
