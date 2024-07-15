## Add confirming invoices

```shell
curl --header "Authorization: Bearer abcd" --header "Content-Type: application/json" --data '{
  "invoices": [
    {
      "supplier_id": "00445790",
      "reference": "A1234",
      "amount": 1000,
      "issued_at": "2024-05-30",
      "due_at": "2024-10-30",
    }
  ]
}' \
"https://api.novicap.com/v1/confirming_standard/invoices?product_id=123"
```

> The above command returns a empty JSON payload with the 201 CREATED status.

This endpoint adds invoices to your confirming standard product. If the supplier doesn't exist you must pass the `supplier_name` and `contact_email` to create them in the same request.

The company will receive an onboarding email chain, and we may reach out to the company by phone to assist in onboarding.

If your account has more than one legal entity, you must include a `debtor_id` along with every supplier, representing the entity which will pay invoices to that supplier.


### HTTP Request

`POST https://api.novicap.com/v1/confirming_standard/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "description": "Invoices create endpoint json schema",
  "type": "object",
  "required": ["invoices"],
  "properties": {
    "invoices": {
      "type":"array",
      "items": {
        "type": "object",
        "required": ["supplier_id", "reference", "amount", "issued_at", "due_at"],
        "properties": {
          "debtor_id": { "type": "string" },
          "country_code": { "type": "string" },
          "supplier_id": { "type": "string" },
          "supplier_name": { "type": "string" },
          "contact_first_name": { "type": "string" },
          "contact_last_name": { "type": "string" },
          "contact_email": { "type": "string" },
          "contact_phone": { "type": "string" },
          "iban": { "type": "string" },
          "bic": { "type": "string" },
          "reference": { "type": "string" },
          "amount": { "type": "number" },
          "issued_at": { "type": "string" },
          "due_at": { "type": "string" },
        }
      }
    }
  }
}
```

| Parameter  | Type   | Required | Format                                      | Description                                                             |
|------------+--------+----------+---------------------------------------------+-------------------------------------------------------------------------|
| invoices   | Array  | ✓        | Array of [invoice objects](#confirming-invoice-create) | A list of invoices to create                                            |

### Confirming invoice (create)

| Parameter           | Type   | Required | Format                                      | Default value | Description                                                                                                           |                                                  |
|---------------------|--------|----------|---------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| debtor_id           | String |          |                                             |               | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier |                                                  |
| country_code        | String |          | ISO-3166-1                     |                            | Two-letter country codes if supplier is international
| supplier_id         | String | ✓        | Depends on country code                     |               | The ID of the supplier (see [identifying companies](#identifying-companies))                                          |                                                  |
| supplier_name       | String |          |                                |                            | The name of the supplier                                                                                                             |                                                   |
| contact_first_name  | String |          |                                            |                | The first name of the supplier contact                                                                                               |                                                   |
| contact_last_name   | String |          |                                            |                | The last name of the supplier contact                                                                                                |                                                   |
| contact_email       | String |          |                                            |                | The email of the supplier contact                                                                                                    |                                                   |
| contact_phone       | String/Number |   |                                            |                | The full phone number of the supplier contact, including country code                                                                |                                                   |
| iban                | String |          | IBAN                           |                            | The IBAN code of the bank account you pay to when making payments to the supplier                                                    |                                                   |
| bic                 | String |          | BIC                            |                            | The BIC of the bank account you pay to when making payments to the supplier                                                    |                                                   |
| reference           | String | ✓        |                                             |               | The reference of the invoice                                                                                          |                                                  |
| amount              | String | ✓        |                                             |               | The amount of the invoice                                                                                             |                                                  |
| issued_at           | String | ✓        | ISO 8601                                    |               | The date on which the invoice is issued                                                                                  |                                               |
| due_at              | String | ✓        | ISO 8601                                    |               | The date on which the invoice is due                                                                                  |                                                  |

### Response

A successful response has a 201 Created HTTP status code.

## Retrieve confirming invoices

```shell
curl --header "Authorization: Bearer abcd" "https://api.novicap.com/v1/confirming_standard/invoices?product_id=123"
```

> The above command returns an array of Invoice objects in the JSON payload with the 200 OK status.

This endpoint returns all the invoices registered in your product.

### HTTP Request

`GET https://api.novicap.com/v1/confirming_standard/invoices`

### Response

A successful response has a 200 OK HTTP status code along with an array of invoice objects.

| Parameter | Type  | Format                                     | Description                           |
|-----------+-------+--------------------------------------------+---------------------------------------|
| invoices  | Array | Array of [invoice objects](#confirming-invoice-index) | A list of all invoices in the product |

### Confirming invoice (index)

Each invoice object has the following schema:

| Parameter              | Type   | Format                                             | Description                                                                          |
|------------------------|--------|----------------------------------------------------|--------------------------------------------------------------------------------------|
| supplier_id            | String | Depends on country                                 | The ID of the supplier (see [identifying companies](#identifying-companies))         |
| debtor_id              | String | Depends on country                                 | The ID of the debtor (see [identifying companies](#identifying-companies))           |
| reference              | String |                                                    | The reference you gave us - unique for each pair of debtor and supplier              |
| transaction_id         | String |                                                    | A unique reference for this invoice in our system                                    |
| amount                 | Number |                                                    | The amount (face value) of the invoice                                               |
| due_at                 | String | ISO 8601                                           | The date this invoice is due                                                         |
| payment_instruction_id | String |                                                    | The payment instruction that this invoice is included in                             |

## Delete confirming invoice

```shell
curl --header "Authorization: Bearer abcd" --request DELETE "https://api.novicap.com/v1/confirming_standard/invoices/I-ABCD?product_id=123"
```

> The above command returns a empty JSON payload with the 200 ACCEPTED status.

This endpoint permanently deletes the invoice. This cannot be undone.

The URL must contain a valid transaction ID, matching one returned from [GET /v1/confirming_standard/invoices](#retrieve-invoices). The transaction ID is not the same as the reference of the invoice submitted by you.

The invoice cannot be deleted if it is already part of a payment instruction or if it has been already paid.

### HTTP Request

`DELETE https://api.novicap.com/v1/confirming_standard/invoices/:transaction_id`

### Response

A successful response has a 200 OK HTTP status code.
