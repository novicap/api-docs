## Add invoices

```shell
curl --header "Authorization: Bearer abcd" --header "Content-Type: application/json" --data '{
  "invoices": [
    {
      "supplier_id": "00445790",
      "reference": "A1234",
      "amount": 1000,
      "due_at": "2021-10-30",
      "custom_invoice_data": { "internal_id": "inv-001", "tags": ["batch 1"] }
    }
  ]
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices?product_id=123"
```

> The above command returns a empty JSON payload with the 201 CREATED status.

This endpoint adds invoices to your dynamic discounting product. You must add suppliers before you add invoices for those suppliers.

The company will receive an onboarding email chain, and we may reach out to the company by phone to assist in onboarding.

If your account has more than one legal entity, you must include a `debtor_id` along with every supplier, representing the entity which will pay invoices to that supplier.

If an invoice already exists under the product with the same supplier and reference, and the invoice is not yet part of a payment instruction, we attempt to update it. If the supplier has already accepted early payment and the update changes the `amount`, `due_at`, or `invoice_adjustments`, we will cancel acceptance and ask the supplier to accept the new terms instead.

### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/invoices`

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
        "required": ["supplier_id", "reference", "amount", "due_at"],
        "properties": {
          "debtor_id": { "type": "string" },
          "supplier_id": { "type": "string" },
          "reference": { "type": "string" },
          "amount": { "type": "number" },
          "due_at": { "type": "string" },
          "custom_invoice_data": {"type": "object"},
          "invoice_adjustments": {
            "type": "array",
            "items": {
              "type": "object",
              "required": ["adjustment_id", "adjustment"],
              "properties": {
                "adjustment_id": { "type": "string" },
                "adjustment": { "type": "number" }
              }
            }
          }
        }
      }
    }
  }
}
```

| Parameter  | Type   | Required | Format                                      | Description                                                             |
|------------+--------+----------+---------------------------------------------+-------------------------------------------------------------------------|
| invoices   | Array  | ✓        | Array of [invoice objects](#invoice-create) | A list of invoices to create                                            |

### Invoice (create)

| Parameter           | Type   | Required | Format                                      | Default value | Description                                                                                                           |                                                  |
|---------------------|--------|----------|---------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| debtor_id           | String |          |                                             |               | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier |                                                  |
| supplier_id         | String | ✓        | Depends on country code                     |               | The ID of the supplier (see [identifying companies](#identifying-companies))                                          |                                                  |
| reference           | String | ✓        |                                             |               | The reference of the invoice                                                                                          |                                                  |
| amount              | String | ✓        |                                             |               | The amount of the invoice                                                                                             |                                                  |
| due_at              | String | ✓        | ISO 8601                                    |               | The date on which the invoice is due                                                                                  |                                                  |
| custom_invoice_data | Object |          | Any valid JSON, maximum of 8192 characters  | {}            |                                                                                                                       | Any data you want to associate with this invoice |
| invoice_adjustments | Array  |          | Array of [adjustment objects](#invoice-adjustment) | []            | A list of changes to the invoice amount that should be applied before the discount                                    |                                                  |

### Invoice adjustment

You may have pre-existing credit notes that you want to apply to an invoice. These apply before we calculate a discount based on the APR. The supplier will be shown these adjustments inside the platform.

| Parameter     | Type   | Required | Format | Default value | Description                                                                                                    |
|---------------|--------|----------|--------|---------------|----------------------------------------------------------------------------------------------------------------|
| adjustment_id | String | ✓        |        |               | A reference which we show to the supplier                                                                      |
| adjustment    | Number | ✓        |        |               | The adjustment to the amount of the invoice that you want to make. For a credit note, this should be negative. |

### Response

A successful response has a 201 Created HTTP status code.

## Retrieve invoices

```shell
curl --header "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/invoices?product_id=123"
```

> The above command returns an array of Invoice objects in the JSON payload with the 200 OK status.

This endpoint returns all the invoices registered in your product.

### HTTP Request

`GET https://api.novicap.com/v1/dynamic_discounting/invoices`

### Response

A successful response has a 200 OK HTTP status code along with an array of invoice objects.

| Parameter | Type  | Format                                     | Description                           |
|-----------+-------+--------------------------------------------+---------------------------------------|
| invoices  | Array | Array of [invoice objects](#invoice-index) | A list of all invoices in the product |

### Invoice (index)

Each invoice object has the following schema:

| Parameter              | Type   | Format                                             | Description                                                                          |
|------------------------|--------|----------------------------------------------------|--------------------------------------------------------------------------------------|
| supplier_id            | String | Depends on country                                 | The ID of the supplier (see [identifying companies](#identifying-companies))         |
| debtor_id              | String | Depends on country                                 | The ID of the debtor (see [identifying companies](#identifying-companies))           |
| reference              | String |                                                    | The reference you gave us - unique for each pair of debtor and supplier              |
| transaction_id         | String |                                                    | A unique reference for this invoice in our system                                    |
| amount                 | Number |                                                    | The amount (face value) of the invoice                                               |
| discount               | Number |                                                    | The total discount that the supplier agreed to in return for early payment           |
| facilitator_fee        | Number |                                                    | The amount we will charge you for processing this invoice                            |
| accepted_at            | String | ISO 8601                                           | The date the supplier (most recently) accepted early payment of this invoice         |
| due_at                 | String | ISO 8601                                           | The date this invoice is due                                                         |
| management_status      | String |                                                    | An internal invoice status that may help you track how the invoice is doing          |
| rectified_invoice_url  | String | URL                                                | A link to the rectified invoice PDF generated by the supplier. Expires after 1 week. |
| rectified_invoice_data | Object | A [rectified invoice object](#rectified-invoice)   | Data from the rectified invoice PDF                                                  |
| payment_instruction_id | String |                                                    | The payment instruction that this invoice is included in                             |
| custom_invoice_data    | Object | Any valid JSON                                     | The custom invoice data you gave us                                                  |
| custom_supplier_data   | Object | Any valid JSON                                     | The custom supplier data you gave us                                                 |
| invoice_adjustments    | Array  | Array of [adjustment objects](#invoice-adjustment) | The pre-discount ajustments you gave us                                              |

### Rectified invoice

Each rectified invoice object has the following schema:

| Parameter   | Type   | Format            | Description                                                         |
|-------------|--------|-------------------|---------------------------------------------------------------------|
| reference   | String |                   | The reference of the rectified invoice, given to us by the supplier |
| vat_percent | Number | Percentage points | The VAT percentage on the rectified invoice PDF                     |
| vat_base    | Number |                   | The base amount to charge VAT on                                    |
| vat_amount  | Number |                   | The amount of VAT                                                   |
| issued_at   | String | ISO 8601          | The date on the rectified invoice PDF                               |

## Delete invoice

```shell
curl --header "Authorization: Bearer abcd" --request DELETE "https://api.novicap.com/v1/dynamic_discounting/invoices/DDI-ABCD?product_id=123"
```

> The above command returns a empty JSON payload with the 200 ACCEPTED status.

This endpoint permanently deletes the invoice. This cannot be undone.

The URL must contain a valid transaction ID, matching one returned from [GET /v1/dynamic_discounting/invoices](#retrieve-invoices). The transaction ID is not the same as the reference of the invoice submitted by you.

The invoice cannot be deleted if it is already part of a payment instruction. If the supplier has already accepted early payment, we will notify them that the invoice is no longer eligible and that they will not receive it.

### HTTP Request

`DELETE https://api.novicap.com/v1/dynamic_discounting/invoices/:transaction_id`

### Response

A successful response has a 200 OK HTTP status code.
