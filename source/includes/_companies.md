## Retrieve companies

```shell
curl "https://api.novicap.com/companies?api_key=abcd&page=1&status="
```

> The above command returns the following JSON:

```json
[
  {
    "name": "Company 937",
    "novicap_id": "ESA32340135",
    "status": "approved_for_trading",
    "line_limit": 1000000,
    "line_usage": 0,
    "line_remainder": 1000000,
    "debtors": [
      {
        "novicap_id": "ESA33218306",
        "name": "Debtor 1744",
        "max_allowed_limit": 10000,
        "status": "draft"
      }
    ]
  }
]
```

Returns an array with your associated companies.

### HTTP Request

`GET http://api.novicap.com/v1/companies?api_key=abcd&status=pending`

### URL Parameters

Parameter            | Default | Required | Description
---------------------|---------|----------|--------------------------------------------------------
api_key              |         | ✓        | Your api key for authentication.
status               |         |          | Filter companies by current status. It maybe one of "rejected", "not_registered", "activated" or "onboarding"

### Response

> A successful response is a JSON compatible with this schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Companies endpoint json schema. It contains data about partner's companies and debtors",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "novicap_id": { "type": "string" },
      "status": {
        "type": "string",
        "description": "One of 'not_registered', 'onboarding', 'activated' and 'rejected'"
      },
      "name": { "type": "string" },
      "line_limit": { "type": "number" },
      "line_usage": { "type": "number" },
      "line_remainder": { "type": "number" },
      "debtors": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "novicap_id": { "type": "string" },
            "status": {
              "type": "string",
              "description": "One of 'new', 'trading' and 'rejected'"
            },
            "name": { "type": "string" },
            "max_allowed_limit": { "type": "number,null"}
          }
        }
      }
    }
  }
}
```

A successful response is a JSON payload with these fields:

Variable     | Type   | Unit | Description
-------------|--------|------|-----------------------------------------------------------------------------------------
novicap_id   | String |      | The `novicap_id` of the company.
status       | String |      | One of 'not_registered', 'onboarding', 'activated' and 'rejected'.
name         | String |      | The name of the company.
line_limit   | Number | €    | The size of the credit line NoviCap can provide to the company.
line_usage   | Number | €    | The amount currently used by the company.
line_remaind | Number | €    | The amount currently available for the company.
debtors      | Array  |      | The companies' debtors.

Each debtor in `debtors` has these fields:

Variable          | Type   | Unit | Description
------------------|--------|------|------------------------------------------------------------------------------------------------
novicap_id        | String |      | The `novicap_id` of the company.
status            | String |      | One of "new", "trading", or "rejected".
name              | String |      | The name of the debtor.
max_allowed_limit | Number |  €   | The max allowed limit for this debtor.
