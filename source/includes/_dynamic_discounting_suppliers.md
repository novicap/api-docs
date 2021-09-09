## Add suppliers

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "product_id": 123,
  "suppliers": [
    "country_code": "GB",
    "company_id": "00445790",
    "company_name": "Tesco PLC",
    "contact_first_name": "John",
    "contact_last_name": "Smith",
    "contact_email": "john.smith@company.com",
    "contact_phone": "+44724565898",
    "apr": 10,
    "fixed_fee_percentage": 0.5,
    "early_payment_cutoff_in_days": 5
  ]
}' \
"https://api.novicap.com/v1/dynamic_discounting/suppliers"
```

> The above command returns a empty JSON payload with the 201 CREATED status.

This endpoint adds suppliers to your dynamic discounting product. You must add suppliers before you add invoices for those suppliers.

The company will receive an onboarding email chain, and we may reach out to the company by phone to assist in onboarding.

If your account has more than one legal entity, you must include a `debtor_id` along with every supplier, representing the entity which will pay invoices to that supplier.


### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/suppliers`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Schema for POST /v1/dynamic_discounting/suppliers",
  "type": "object",
  "required": ["product_id", "suppliers"],
  "properties": {
    "api_key": {"type": "string"},
    "product_id": {"type": "number"},
    "suppliers": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["company_id", "company_name", "contact_email", "apr", "fixed_fee_percentage"],
        "properties": {
          "debtor_id": {"type": "string"},
          "country_code": {"type": "string"},
          "company_id": {"type": "string"},
          "company_name": {"type": "string"},
          "contact_first_name": {"type": "string"},
          "contact_last_name": {"type": "string"},
          "contact_email": {"type": "string"},
          "contact_phone": {"type": ["string", "number"]},
          "apr": {"type": "number"},
          "fixed_fee_percentage": {"type": "number"},
          "early_payment_cutoff_in_days": {"type": "integer"},
          "iban": {"type": "string"}
        }
      }
    }
  }
}
```

| Parameter  | Type   | Required | Format | Description                                                             |
|------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |
| suppliers  | Array  | ✓        |        | An array of objects matching the supplier schema below                  |

#### Suppliers

| Parameter                    | Type          | Required          | Format                  | Default value | Description                                                                                                                          |   |
|------------------------------+---------------+-------------------+-------------------------+---------------+--------------------------------------------------------------------------------------------------------------------------------------+---|
| debtor_id                    | String        |                   |                         |               | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier                |   |
| country_code                 | String        | ✓                 | ISO 3166 alpha-2        |               | The country code of the supplier                                                                                                     |   |
| company_id                   | String        | ✓                 | Depends on country code |               | The ID of the supplier (see [identifying companies](!identifying-companies)])                                                        |   |
| company_name                 | String        | ✓                 |                         |               | The name of the supplier                                                                                                             |   |
| contact_first_name           | String        |                   |                         |               | The first name of the supplier contact                                                                                               |   |
| contact_last_name            | String        |                   |                         |               | The last name of the supplier contact                                                                                                |   |
| contact_email                | String        |                   |                         |               | The email of the supplier contact                                                                                                    |   |
| contact_phone                | String/Number |                   |                         |               | The full phone number of the supplier contact, including country code                                                                |   |
| apr                          | Number        | Percentage points | ✓                       |               | The APR your want this supplier to pay in percentage points e.g. 10% -> 10                                                           |   |
| fixed_fee_percentage         | Number        | Percentage points | ✓                       |               | The fixed fee, as a percentage of the face value of the invoice, you want the supplier to pay, in percentage points e.g. 0.5% -> 0.5 |   |
| early_payment_cutoff_in_days | Number        |                   |                         | 10            | This number of days before the due date, we stop allowing the supplier to accept financing                                           |   |
| iban                         | String        | IBAN              |                         |               | The IBAN code of the bank account you pay to when making payments to the supplier                                                    |   |

### Response

A successful response has a 201 Created HTTP status code.
