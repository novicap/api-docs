## Create payment instruction

```shell
curl -H "Content-Type: application/json" -X POST -i -d '{
  "api_key": "abcd",
  "product_id": 123
  }' \
"https://api.novicap.com/v1/dynamic_discounting/payment_instructions"
```

> The above command returns a JSON payload with the 201 CREATED status.

This endpoint creates a payment instruction for all the invoices accepted by the supplier which hasn't been included in an instruction already.

If your account has more than one legal entity, you must include a `company_id`, representing the entity which will pay invoices to suppliers.


### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/payment_instructions`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Payment instructions create endpoint json schema",
	"type": "object",
	"required": ["product_id"],
	"properties": {
		"api_key": { "type": "string" },
		"product_id": { "type": "number" },
		"debtor_id": { "type": "string" }
	}
}
```

| Parameter  | Type   | Required | Format | Description                                                             |
|------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |
| debtor_id | Number |          |        | The ID of the entity, if your account has more then one legal entity    |

### Response

A successful response has a 201 Created HTTP status code along with the list of invoices included in the payment instruction.

## Retrieve payment instructions

```shell
curl -H "Content-Type: application/json" -X GET -i -d '{
-X GET -d '{
  "api_key": "abcd",
  "product_id": 123
}' \
"https://api.novicap.com/v1/dynamic_discounting/payment_instructions"
```

> The above command returns a JSON payload with the 200 OK status.

This endpoint returns all the payments instructions with an array of invoices included with every instruction.


### HTTP Request

`GET https://api.novicap.com/v1/dynamic_discounting/payment_instructions`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Payment instructions index endpoint json schema",
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

A successful response has a 200 OK HTTP status code along with the list of payment instructions and the included invoices.
