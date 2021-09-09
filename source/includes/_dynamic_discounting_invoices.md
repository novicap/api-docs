## Add invoices

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "product_id": 123,
  "invoices": [
    "company_id": "00445790",
    "reference": "A1234",
    "amount": 1000,
    "due_at": "2021/10/30",
  ]
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices"
```

> The above command returns a empty JSON payload with the 201 CREATED status.

This endpoint adds invoices to your dynamic discounting product. You must add suppliers before you add invoices for those suppliers.

The company will receive an onboarding email chain, and we may reach out to the company by phone to assist in onboarding.

If your account has more than one legal entity, you must include a `debtor_id` along with every supplier, representing the entity which will pay invoices to that supplier.


### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/invoices`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
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
				"required": ["company_id", "reference", "amount", "due_at"],
				"properties": {
					"debtor_id": { "type": "string" },
					"company_id": { "type": "string" },
					"reference": { "type": "string" },
					"amount": { "type": "number" },
					"due_at": { "type": "string" }
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

| Parameter                    | Type          | Required          | Format                  | Default value | Description                                                                                                                          |   |
|------------------------------+---------------+-------------------+-------------------------+---------------+--------------------------------------------------------------------------------------------------------------------------------------+---|
| debtor_id                    | String        |                   |                         |               | If your account contains more than one legal entity, this is the ID of the entity that pays invoices to this supplier                |   |
| company_id                   | String        | ✓                 | Depends on country code |               | The ID of the supplier (see [identifying companies](!identifying-companies)])                                                        |   |
| reference                    | String        | ✓                 |                         |               | The reference of the invoice                                                                                                         |   |
| amount                       | String        |                   |                         |               | The amount of the invoice                                                                                                            |   |
| due_at                       | String        |                   |                         |               | The date on which the invoice is due                                                                                                 |   |

### Response

A successful response has a 201 Created HTTP status code.


## Retrieve invoices

```shell
curl -H "Content-Type: application/json" \
-X GET -d '{
  "api_key": "abcd",
  "product_id": 123,
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices"
```

> The above command returns an array of Invoice objects in the JSON payload with the 200 OK status.

This endpoint returns all the invoices in your dynamic discounting product.


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

A successful response has a 200 Created HTTP status code along with an array of invoice objects described above.


## Delete invoice

```shell
curl -H "Content-Type: application/json" \
-X DELETE -d '{
  "api_key": "abcd",
  "product_id": 123,
}' \
"https://api.novicap.com/v1/dynamic_discounting/invoices/DDI-ABCDE"
```

> The above command returns a empty JSON payload with the 202 ACCEPTED status.

This endpoint permanently deletes the invoice. This cannot be undone.

The invoice cannot be deleted if it's already in a payment instruction.


### HTTP Request

`DELETE https://api.novicap.com/v1/dynamic_discounting/invoices/:transaction_id`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Invoices destroy endpoint json schema",
	"type": "object",
	"required": ["product_id", "transaction_id"],
	"properties": {
		"api_key": { "type": "string" },
		"product_id": { "type": "number" },
		"transaction_id": { "type": "number" }
	}
}
```

| Parameter      | Type   | Required | Format | Description                                                             |
|----------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key        | String |          |        | Your API key for authentication                                         |
| product_id     | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |
| transaction_id | Number | ✓        |        | The transaction id of the invoice, visible in the invoice get payload   |


### Response

A successful response has a 202 Accepted HTTP status code.
