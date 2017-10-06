## Create an invoice

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "reference": "20170832",
  "company_novicap_id": "ESA46103834",
  "debtor_novicap_id": "ESB66367129",
  "amount": 150000,
  "issued_at": "2017-08-12",
  "due_at": "2017-10-12"
}' \
"https://api.novicap.com/v1/invoices"
```

> The above command returns the following response:

```json
{
  "data": {
    "id": "I-1A2B",
    "reference": "20170832",
    "invoice_amount": 150000,
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

This endpoint allows you to create an invoice for a company.

If the company is not using NoviCap yet, it will be created and associated to you.

### HTTP Request

`POST https://api.novicap.com/v1/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "reference", "company_novicap_id", "debtor_novicap_id", "amount", "issued_at", "due_at"],
  "properties": {
    "api_key": { "type": "string" },
    "reference": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "debtor_novicap_id": { "type": "string" },
    "amount": { "type": "number" },
    "issued_at": { "type": "string" },
    "due_at": { "type": "string" }
  }
}
```

| Parameter          | Type   | Required | Format   | Description                                               |
|--------------------|--------|----------|----------|-----------------------------------------------------------|
| api_key            | String | ✓        |          | Your API key for authentication                           |
| reference          | String | ✓        |          | The reference used by the company for this invoice        |
| company_novicap_id | String | ✓        |          | The NoviCap ID of the company associated with the invoice |
| debtor_novicap_id  | String | ✓        |          | The NoviCap ID of the debtor associated with the invoice  |
| amount             | String | ✓        | cents    | The total amount of the invoice                           |
| issued_at          | String | ✓        | ISO 8601 | The date when the invoice was issued                      |
| due_at             | String | ✓        | ISO 8601 | The invoice due date                                      |

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
| invoice_amount     | Number | cents    | The total amount of the invoice                           |
| currency           | String | ISO 4217 | The currency of invoice                                   |
| company_name       | String |          | The name of the company                                   |
| company_novicap_id | String |          | The NoviCap ID of the company associated with the invoice |
| debtor_name        | String |          | The name of the debtor                                    |
| debtor_novicap_id  | String |          | The NoviCap ID of the debtor associated with the invoice  |
| issued_at          | String | ISO 8601 | The date when the invoice was issued                      |
| due_at             | String | ISO 8601 | The invoice due date                                      |
| status             | String |          | The status of the invoice                                 |

### Status Codes

| Code | Meaning              | Description                                                                                      |
|------|----------------------|--------------------------------------------------------------------------------------------------|
| 201  | Created              | The invoice has been successfully created                                                        |
| 403  | Forbidden            | The provided company is associated to another partner                                            |
| 409  | Conflict             | The invoice was not created because an invoice with the same debtor and reference already exists |
| 422  | Unprocessable Entity | The invoice has not been created because of errors                                               |
