## Add invoices

```shell
curl -i -H "Content-Type: application/json" -X POST -i -d '{
  "api_key": "abcd",
  "product_id": 123,
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
"https://api.novicap.com/v1/dynamic_discounting/invoices"
```

> The above command returns a empty JSON payload with the 201 CREATED status.

This endpoint adds invoices to your dynamic discounting product. You must add suppliers before you add invoices for those suppliers.

The company will receive an onboarding email chain, and we may reach out to the company by phone to assist in onboarding.

If your account has more than one legal entity, you must include a `debtor_id` along with every supplier, representing the entity which will pay invoices to that supplier.

If an invoice already exists under the product with the same supplier and reference, and the invoice is not yet part of a payment instruction, we attempt to update it. If the supplier has already accepted early payment and the update changes the `amount`, `due_at`, or `adjustments_to_invoice`, we will cancel acceptance and ask the supplier to accept the new terms instead.

### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{

  "description": "Invoices create endpoint json schema",
	"type": "object",
	"required": ["product_id", "invoices"],
	"properties": {
		"api_key": { "type": "string" },
		"product_id": { "type": "number" },
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
                    "custom_invoice_data": {"type": "object"}
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
| invoices   | Array  | ✓        |        | An array of objects matching the invoice schema below                  |

#### Invoices

| Parameter           | Type   | Required | Format                                     | Default value | Description                                                                                                           |                                                  |
|---------------------+--------+----------+--------------------------------------------+---------------+-----------------------------------------------------------------------------------------------------------------------+--------------------------------------------------|
| debtor_id           | String |          |                                            |               | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier |                                                  |
| supplier_id         | String | ✓        | Depends on country code                    |               | The ID of the supplier (see [identifying companies](!identifying-companies)])                                         |                                                  |
| reference           | String | ✓        |                                            |               | The reference of the invoice                                                                                          |                                                  |
| amount              | String | ✓        |                                            |               | The amount of the invoice                                                                                             |                                                  |
| due_at              | String | ✓        | ISO 8601                                |               | The date on which the invoice is due                                                                                  |                                                  |
| custom_invoice_data | Object |          | Any valid JSON, maximum of 8192 characters |               |                                                                                                                       | Any data you want to associate with this invoice |

### Response

A successful response has a 201 Created HTTP status code.


## Retrieve invoices

```shell
curl -i -H "Content-Type: application/json" -X GET -i -d '{
  "api_key": "abcd",
  "product_id": 123
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices"
```

> The above command returns an array of Invoice objects in the JSON payload with the 200 OK status.

This endpoint returns all the invoices registered in your product.

### HTTP Request

`GET https://api.novicap.com/v1/dynamic_discounting/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Suppliers index endpoint json schema",
	"type": "object",
	"required": ["product_id"],
	"properties": {
		"api_key": { "type": "string" },
		"product_id": { "type": "number" }
	}
}
```

| Parameter  | Type   | Required | Format | Description                                                             |
|------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |


### Response

A successful response has a 200 Created HTTP status code along with an array of invoice objects.

| Parameter | Type  | Format | Description                           |
|-----------+-------+--------+---------------------------------------|
| invoices  | Array |        | A list of all invoices in the product |

#### Invoices

Each invoice object has the following schema:

| Parameter              | Type   | Format             | Description                                                                          |
|------------------------+--------+--------------------+--------------------------------------------------------------------------------------|
| supplier_id            | String | Depends on country | The ID of the supplier (see [identifying companies](!identifying-companies)])        |
| debtor_id              | String | Depends on country | The ID of the debtor (see [identifying companies](!identifying-companies)])          |
| reference              | String |                    | The reference you gave us - unique for each pair of debtor and supplier              |
| transaction_id         | String |                    | A unique reference for this invoice in our system                                    |
| amount                 | Number |                    | The amount (face value) of the invoice                                               |
| discount               | Number |                    | The total discount that the supplier agreed to in return for early payment           |
| facilitator_fee        | Number |                    | The amount we will charge you for processing this invoice                            |
| accepted_at            | String | ISO 8601           | The date the supplier (most recently) accepted early payment of this invoice         |
| due_at                 | String | ISO 8601           | The date this invoice is due                                                         |
| management_status      | String |                    | An internal invoice status that may help you track how the invoie is doing           |
| rectified_invoice_url  | String | URL                | A link to the rectified invoice PDF generated by the supplier. Expires after 1 week. |
| payment_instruction_id | String |                    | The payment instruction that this invoice is included in                             |
| custom_invoice_data    | Object | Any valid JSON     | The custom invoice data you gave us                                                  |
| custom_supplier_data   | Object | Any valid JSON     | The custom supplier data you gave us                                                 |

## Delete invoice

```shell
curl -i -H "Content-Type: application/json" -X DELETE -i -d '{
  "api_key": "abcd",
  "product_id": 123
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices/DDI-ABCD"
```

> The above command returns a empty JSON payload with the 202 ACCEPTED status.

This endpoint permanently deletes the invoice. This cannot be undone.

The URL must contain a valid transaction ID, matching one returned from [GET /v1/dynamic_discounting/invoices](#retrieve-invoices). The transaction ID is not the same as the reference of the invoice submitted by you.

The invoice cannot be deleted if it is already part of a payment instruction. If the supplier has already accepted early payment, we will notify them that the invoice is no longer eligible and that they will not receive it.

### HTTP Request

`DELETE https://api.novicap.com/v1/dynamic_discounting/invoices/:transaction_id`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Invoices destroy endpoint json schema",
	"type": "object",
	"required": ["product_id"],
	"properties": {
		"api_key": { "type": "string" },
		"product_id": { "type": "number" },
	}
}
```

| Parameter  | Type   | Required | Format | Description                                                             |
|------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |


### Response

A successful response has a 202 Accepted HTTP status code.
