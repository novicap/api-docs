## Retrieve all companies

```shell
curl -H "Content-Type: application/json" \
"https://api.novicap.com/v1/companies?api_key=abcd"
```

> The above command returns the following response:

```json
{
  "data": [
    {
      "currency": "EUR",
      "name": "MERCADONA SA",
      "novicap_id": "ESA46103834",
      "status": "not_registered",
      "line_limit": 17000000,
      "line_usage": 0.0,
      "line_remainder": 0.0,
      "debtors": [
        {
        "novicap_id": "ESA46103834",
        "name": "LAVINIA BROADCASTING SL",
        "max_allowed_limit": null,
        "status": "new"
        }
      ]
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": null,
    "prev_page": null,
    "total_pages": 1,
    "total_count": 1
  }
}
```

This endpoint allows you to retrieve the companies associated to you.

### HTTP Request

`GET https://api.novicap.com/v1/companies`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key"],
  "properties": {
    "api_key": { "type": "string" },
    "status": { "type": "string" }
  }
}
```

| Parameter | Type   | Required | Description                                                                                                   |
|-----------|--------|----------|---------------------------------------------------------------------------------------------------------------|
| api_key   | String | ✓        | Your API key for authentication                                                                               |
| status    | String |          | Filter companies by current status. It maybe one of "rejected", "not_registered", "activated" or "onboarding" |

### Response

> A successful response is a JSON compatible with the following schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "properties": {
    "data": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "currency": { "type": "string" },
          "name": { "type": "string" },
          "novicap_id": { "type": "string" },
          "status": { "type": "string" },
          "line_limit": { "type": "number" },
          "line_usage": { "type": "number" },
          "line_remainder": { "type": "number" },
          "debtors": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "novicap_id": { "type": "string" },
                "name": { "type": "string" },
                "max_allowed_limit": { "type": ["null", "number"] },
                "status": { "type": "string" }
              }
            }
          }
        }
      }
    },
    "meta": {
      "current_page": { "type": "number" },
      "next_page": { "type": ["null", "number"] },
      "prev_page": { "type": ["null", "number"] },
      "total_pages": { "type": "number" },
      "total_count": { "type": "number" }
    }
  }
}
```

A company has the following fields:

| Attribute          | Type   | Unit     | Description                                                       |
|--------------------|--------|----------|-------------------------------------------------------------------|
| currency           | String | ISO 4217 | The currency of the credit line. It may be "EUR" or "GBP"         |
| name               | String |          | The name of the company                                           |
| novicap_id         | String |          | The NoviCap ID of the company                                     |
| status             | String |          | One of 'not_registered', 'onboarding', 'activated' and 'rejected' |
| line_limit         | Number | cents    | The size of the credit line NoviCap can provide to the company    |
| line_usage         | Number | cents    | The amount currently used by the company                          |
| line_remainder     | Number | cents    | The amount currently available for the company                    |
| debtors            | Array  |          | The companies' debtors                                            |

Each debtor in `debtors` has the following fields:

| Variable          | Type   | Unit  | Description                            |
|-------------------|--------|-------|----------------------------------------|
| novicap_id        | String |       | The NoviCap ID of the company          |
| name              | String |       | The name of the debtor                 |
| max_allowed_limit | Number | cents | The max allowed limit for this debtor  |
| status            | String |       | One of "new", "trading", or "rejected" |

### Status Codes

| Code | Meaning              | Description                                |
|------|----------------------|--------------------------------------------|
| 200  | Success              | The companies are returned in the response |
| 422  | Unprocessable Entity | The status code is not valid               |
