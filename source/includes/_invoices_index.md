## Retrieve all invoices

```shell
curl -H "Content-Type: application/json" \
"https://api.novicap.com/v1/invoices?api_key=abcd"
```

> The above command returns the following response:

```json
{
  "data": [
    {
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

This endpoint allows you to retrieve the invoices associated to all your companies.

### HTTP Request

`GET https://api.novicap.com/v1/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key"],
  "properties": {
    "api_key": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "debtor_novicap_id": { "type": "string" }
  }
}
```

| Parameter           | Type   | Required | Description                                    |
|---------------------|--------|----------|------------------------------------------------|
| api_key             | String | ✓        | Your API key for authentication                |
| company_novicap_id  | String |          | The company ID you want to filter invoices for |
| debtor_novicap_id   | String |          | The debtor ID you want to filter invoices for  |

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

| Code | Meaning              | Description                                          |
|------|----------------------|------------------------------------------------------|
| 200  | Success              | The companies' invoices are returned in the response |
