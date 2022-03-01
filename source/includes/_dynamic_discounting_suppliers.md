## Add suppliers

```shell
curl --header "Authorization: Bearer abcd" --header "Content-Type: application/json" --data '{
  "suppliers": [
    {
      "country_code": "GB",
      "supplier_id": "00445790",
      "supplier_name": "Tesco PLC",
      "contact_first_name": "John",
      "contact_last_name": "Smith",
      "contact_email": "john.smith@company.com",
      "contact_phone": "+44724565898",
      "apr": 10,
      "custom_supplier_data": { "internal_id": "supplier-001", "tags": ["batch 1"] }
    }
  ]
}' \
"https://api.novicap.com/v1/dynamic_discounting/suppliers?product_id=123"
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
  "required": ["suppliers"],
  "properties": {
    "suppliers": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["supplier_id", "supplier_name", "contact_email", "apr"],
        "properties": {
          "debtor_id": {"type": "string"},
          "country_code": {"type": "string"},
          "supplier_id": {"type": "string"},
          "supplier_name": {"type": "string"},
          "contact_first_name": {"type": "string"},
          "contact_last_name": {"type": "string"},
          "contact_email": {"type": "string"},
          "contact_phone": {"type": ["string", "number"]},
          "apr": {"type": "number"},
          "fixed_fee_percentage": {"type": "number"},
          "early_payment_cutoff_in_days": {"type": "integer"},
          "iban": {"type": "string"},
          "custom_supplier_data": {"type": "object"}
        }
      }
    }
  }
}
```

| Parameter  | Type   | Required | Format                                  | Description                                                             |
|------------+--------+----------+-----------------------------------------+-------------------------------------------------------------------------|
| suppliers  | Array  | ✓        | Array of [supplier objects](#suppliers) | A list of suppliers you want to add                                     |

### Suppliers

| Parameter                    | Type          | Required | Format                                     | Default value          | Description                                                                                                                          |                                                   |
|------------------------------+---------------+----------+--------------------------------------------+------------------------+--------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------|
| debtor_id                    | String        |          |                                            |                        | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier                |                                                   |
| country_code                 | String        |          | ISO 3166 alpha-2                           | ES                     | The country code of the supplier                                                                                                     |                                                   |
| supplier_id                  | String        | ✓        | Depends on country code                    |                        | The ID of the supplier (see [identifying companies](#identifying-companies))                                                         |                                                   |
| supplier_name                | String        | ✓        |                                            |                        | The name of the supplier                                                                                                             |                                                   |
| contact_first_name           | String        |          |                                            |                        | The first name of the supplier contact                                                                                               |                                                   |
| contact_last_name            | String        |          |                                            |                        | The last name of the supplier contact                                                                                                |                                                   |
| contact_email                | String        | ✓        |                                            |                        | The email of the supplier contact                                                                                                    |                                                   |
| contact_phone                | String/Number |          |                                            |                        | The full phone number of the supplier contact, including country code                                                                |                                                   |
| apr                          | Number        | ✓        | Percentage points                          |                        | The APR your want this supplier to pay in percentage points e.g. 10% -> 10                                                           |                                                   |
| fixed_fee_percentage         | Number        |          | Percentage points                          | Configured per product | The fixed fee, as a percentage of the face value of the invoice, you want the supplier to pay, in percentage points e.g. 0.5% -> 0.5 |                                                   |
| early_payment_cutoff_in_days | Number        |          |                                            | 10                     | This number of days before the due date, we stop allowing the supplier to accept financing                                           |                                                   |
| iban                         | String        |          | IBAN                                       |                        | The IBAN code of the bank account you pay to when making payments to the supplier                                                    |                                                   |
| custom_supplier_data         | Object        |          | Any valid JSON, maximum of 8192 characters | []                     |                                                                                                                                      | Any data you want to associate with this supplier |

### Response

A successful response has a 201 Created HTTP status code.

## Retrieve suppliers

```shell
curl --header "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/suppliers?product_id=123"
```

> The above command returns an array of Supplier objects in the JSON payload with the 200 OK status.

This endpoint returns all the suppliers in your dynamic discounting product.

### HTTP Request

`GET https://api.novicap.com/v1/dynamic_discounting/suppliers`

### Response

A successful response has a 200 OK HTTP status code along with an array of supplier objects described above.
