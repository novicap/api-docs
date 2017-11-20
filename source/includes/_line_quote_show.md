## Retrieve a line quote

```shell
curl -H "Content-Type: application/json" \
"https://api.novicap.com/v1/line_quotes/wxyz?api_key=abcd"
```

> The above command returns the following response:

```json
{
  "status": "ok",
  "company_novicap_id": "ESA12345678",
  "credit_limit": 70000.0,
  "provisional_quote": false,
  "debtors": [
    {
      "debtor_novicap_id": "ESB12345678",
      "status": "ok",
      "credit_limit": 50000.0,
      "interest_rate": 4.8,
      "invoice_handling_fee": 0.5,
      "advance_rate": 70.0
    },
    {
      "debtor_novicap_id": "ESC12345678",
      "status": "rejected"
    }
  ]
}
```

This endpoint allows you to retrieve the data for a quote using an existing quote ID.

### HTTP Request

`GET https://api.novicap.com/v1/line_quotes/:quote_id`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "quote_id"],
  "properties": {
    "api_key": { "type": "string" },
    "quote_id": { "type": "string" }
  }
}
```

| Parameter | Type   | Required | Description                                   |
|-----------|--------|----------|-----------------------------------------------|
| api_key   | String | ✓        | Your API key for authentication               |
| quote_id  | String | ✓        | The quote ID retrieved from the previous step |

### Response

> A successful response is a JSON compatible with the following schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "properties": {
    "status": { "type": "string" },
    "company_novicap_id": { "type": ["null", "string"] },
    "credit_limit": { "type": ["null", "number"] },
    "provisional_quote": { "type": ["null", "boolean"] },
    "debtors": {
      "type": ["null", "array"],
      "items": {
        "type": "object",
        "properties": {
          "debtor_novicap_id": { "type": "string" },
          "status": { "type": "string" },
          "credit_limit": { "type": ["null", "number"] },
          "advance_rate": { "type": ["null", "number"] },
          "interest_rate": { "type": ["null", "number"] },
          "invoice_handling_fee": { "type": ["null", "number"] }
        }
      }
    }
  }
}
```

A successful response is a JSON payload with the following fields:

| Attribute          | Type    | Unit | Description                                                                                                                 |
|--------------------|---------|------|-----------------------------------------------------------------------------------------------------------------------------|
| status             | String  |      | One of "ok", "processing", or "review"                                                                                      |
| company_novicap_id | String  |      | The NoviCap ID of the company associated to the quote                                                                       |
| credit_limit       | Number  | €    | The size of the credit line NoviCap can provide to the company                                                              |
| provisional_quote  | Boolean |      | Indicates if the quote is provisional and if the credit limit could be higher when more financial documentation is provided |
| debtors            | Array   |      | A list of debtors that were priced as part of the quote                                                                     |

Each debtor in `debtors` has these fields:

| Attribute            | Type   | Unit | Description                                                                         |
|----------------------|--------|------|-------------------------------------------------------------------------------------|
| advance_rate         | Number | %    | The percentage of the total value of the invoice NoviCap will advance               |
| credit_limit         | Number | €    | The size of the credit line NoviCap can provide to the company for this debtor      |
| debtor_novicap_id    | String |      | The NoviCap ID of the debtor company                                                |
| interest_rate        | Number | %    | The annual interest rate NoviCap will charge as a percentage of the amount advanced |
| invoice_handling_fee | Number | %    | The fee NoviCap will charge as a percentage of the amount advanced                  |
| status               | String |      | One of "ok", "rejected", or "review"                                                |

### Status

The response has a `status` parameter. If this is `ok`, the quote is ready to use. Any other status means that the quote is not available or may be incomplete:

| Status     | Explanation                                                                                                                  |
|------------|------------------------------------------------------------------------------------------------------------------------------|
| ok         | Quote successful, included in the response                                                                                   |
| processing | The quote is still processing. Try again in a few seconds                                                                    |
| review     | NoviCap could not provide an automatic price quote. The quote may be provided at a later date, or the team may be in contact |
| rejected   | NoviCap cannot provide a quote because the company does not pass financing requirements                                      |

### Status Codes

| Code | Meaning              | Description                                         |
|------|----------------------|-----------------------------------------------------|
| 200  | Success              | The line quote request has been correctly processed |
| 202  | Accepted             | The line quote request is still processing          |
| 422  | Unprocessable Entity | The quote ID is invalid                             |
