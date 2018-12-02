## Retrieve a single invoice

```shell
curl -H "Content-Type: application/json" \
"https://api.novicap.com/v1/invoices/I-1A2B?api_key=abcd"
```

> The above command returns the following response:

```json
{
  "data": {
    "id": "I-1A2B",
    "reference": "20170832",
    "invoice_amount": 1500.00,
    "currency": "EUR",
    "company_name": "MERCADONA SA",
    "company_novicap_id": "ESA46103834",
    "debtor_name": "LAVINIA BROADCASTING SL",
    "debtor_novicap_id": "ESB66367129",
    "issued_at": "2017-08-12",
    "due_at": "2017-10-12",
    "status": "draft"
  }
}
```

This endpoint allows you to retrieve a single invoice associated to your companies.

### HTTP Request

`GET https://api.novicap.com/v1/invoices/:invoice_id`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key"],
  "properties": {
    "api_key": { "type": "string" }
  }
}
```

| Parameter           | Type   | Required | Description                     |
|---------------------|--------|----------|---------------------------------|
| api_key             | String | ✓        | Your API key for authentication |
| id                  | String | ✓        | The invoice ID                  |

### Response

> A successful response is a JSON compatible with the following schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "properties": {
    "data": {
      "type": "object",
      "properties": {
        "id": { "type": "string" },
        "reference": { "type": "string" },
        "invoice_amount": { "type": "number" },
        "currency": { "type": "string" },
        "company_name": { "type": "string" },
        "company_novicap_id": { "type": "string" },
        "debtor_name": { "type": "string" },
        "debtor_novicap_id": { "type": "string" },
        "issued_at": { "type": "string" },
        "due_at": { "type": "string" },
        "status": { "type": "string" }
      }
    }
  }
}
```

An invoice has the following fields:

| Attribute          | Type   | Unit     | Description                                               |
|--------------------|--------|----------|-----------------------------------------------------------|
| id                 | String |          | The ID of the invoice                                     |
| reference          | String |          | The reference used by the company for this invoice        |
| invoice_amount     | Number | €        | The total amount of the invoice                           |
| currency           | String | ISO 4217 | The currency of invoice                                   |
| company_name       | String |          | The name of the company                                   |
| company_novicap_id | String |          | The NoviCap ID of the company associated with the invoice |
| debtor_name        | String |          | The name of the debtor                                    |
| debtor_novicap_id  | String |          | The NoviCap ID of the debtor associated with the invoice  |
| issued_at          | String | ISO 8601 | The date when the invoice was issued                      |
| due_at             | String | ISO 8601 | The invoice due date                                      |
| status             | String |          | The status of the invoice                                 |

### Status Codes

| Code | Meaning              | Description                                                                        |
|------|----------------------|------------------------------------------------------------------------------------|
| 200  | Success              | The requested invoice is returned in the response                                  |
| 404  | Not Found            | The requested invoice does not exist or is not associated to one of your companies |
