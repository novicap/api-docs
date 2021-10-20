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

> The above command returns the following JSON payload with the 200 OK status.

```shell
{
  "payment_instructions": [
    {
      "payment_instruction_id": "TQEZHG",
      "invoices": [
				{
          "company_id": "00445790",
          "reference": "A1234",
          "transaction_id": "DDI-7SNOF",
          "amount": 1000,
          "discount": 100.0,
          "facilitator_fee": 20.0,
          "accepted_at": "2021-09-30T00:00:00.437Z",
          "due_at": "2021-09-30T00:00:00.437Z",
          "management_status": "",
          "supplier_registration_number": "A12345679",
          "debtor_registration_number": "A12345678",
          "payment_instruction_id": "TQEZHG",
          "rectified_invoice_url": ""
        },
        {...},
        {...}
      ]
    },
    {...},
    {...}
  ]
}
```

### Response

A successful response has a 200 OK HTTP status code along with the list of payment instructions and the included invoices.
