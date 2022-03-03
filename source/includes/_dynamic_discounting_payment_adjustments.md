## Create payment adjustment

```shell
curl --header "Authorization: Bearer abcd" --header "Content-Type: application/json" --data '{
  "payment_adjustments": [
    {
      "supplier_id": "00445790",
      "reference": "ADJ-001",
      "amount": -100
    }
  ]
}' \
"https://api.novicap.com/v1/dynamic_discounting/payment_adjustments?product_id=123"
```

> The above command returns a JSON payload with the 201 CREATED status.

This endpoint creates an adjustment to the next payment to a supplier. It can be used to collect outstanding credit notes from the next payment you make, instead of attaching adjustments to individual invoices using [invoice adjustments](#invoice-adjustment).

If your account has more than one legal entity, you must include a `debtor_id`. The next time that entity (but not others) creates a payment instruction to the given supplier, the payment adjustment will be applied.

### HTTP Request

`POST https://api.novicap.com/v1/dynamic_discounting/payment_adjustments`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Payment adjustment create endpoint json schema",
  "type": "object",
  "required": ["payment_adjustments"],
  "properties": {
    "payment_adjustments": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["supplier_id", "reference", "amount"],
        "properties": {
          "debtor_id": { "type": "string" },
          "supplier_id": { "type": "string" },
          "reference": { "type": "string" },
          "amount": { "type": "number" },
          "custom_payment_adjustment_data": { "type": "object" }
        }
      }
    }
  }
}
```

| Parameter           | Type  | Required | Format                                                            | Description                                       |
|---------------------|-------|----------|-------------------------------------------------------------------|---------------------------------------------------|
| payment_adjustments | Array | ✓        | Array of [payment adjustment objects](#payment-adjustment-create) | The payment adjustments you want to add or update |

### Payment adjustment (create)

| Parameter           | Type   | Required | Format                                     | Description                                                                                                       |
|---------------------|--------|----------|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| debtor_id           | String |          |                                            | If your account contains more than one legal entity, this is the ID of the entity that has the payment adjustment |
| supplier_id         | String | ✓        | Depends on country code                    | The ID of the supplier (see [identifying companies](#identifying-companies))                                      |
| reference           | String | ✓        |                                            | The reference of the payment adjustment that will be shown to the supplier                                        |
| amount              | Number | ✓        |                                            | The amount of the payment adjustment. For credit notes, this should be negative.                                  |
| custom_payment_adjustment_data | Object |          | Any valid JSON, maximum of 8192 characters | Any data you want to associate with this payment adjustment                                                       |
    
### Response

A successful response has a 201 Created HTTP status code.

## Retrieve payment adjustments

```shell
curl --header "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/payment_adjustments?product_id=123"
```

> The above command returns a JSON payload with the 200 OK status.

This endpoint returns all the payments adjustments associated with the product.

### HTTP Request

`GET https://api.novicap.com/v1/dynamic_discounting/payment_adjustments`

### Response

A successful response has a 200 OK HTTP status code along with the list of payment adjustments.

| Parameter            | Type  | Format                                                       | Description                                  |
|----------------------|-------|--------------------------------------------------------------|----------------------------------------------|
| payment_adjustments  | Array | Array of [payment adjustment objects](#payment-adjustment-index)   | List of payment adjustments in your account  |

### Payment adjustment (index)

| Parameter                      | Type   | Description                                                                                                       |
|--------------------------------|--------|-------------------------------------------------------------------------------------------------------------------|
| debtor_id                      | String | If your account contains more than one legal entity, this is the ID of the entity that has the payment adjustment |
| supplier_id                    | String | The ID of the supplier (see [identifying companies](#identifying-companies))                                      |
| reference                      | String | The reference of the payment adjustment that is shown to the supplier                                             |
| transaction_id                 | String | A unique internal ID used for the destroy endpoint                                                                |
| amount                         | Number | The amount of the payment adjustment. For credit notes, this should be negative.                                  |
| custom_payment_adjustment_data | Object | Any data you gave us to associate with this payment adjustment                                                    |
| payment_instruction_id         | String | The ID of the payment instruction that this adjustment was applied to, if it has been applied                     |

## Delete payment adjustment

```shell
curl --header "Authorization: Bearer abcd" --request DELETE "https://api.novicap.com/v1/dynamic_discounting/payment_adjustments/DDPI-ABCD?product_id=123"
```

> The above command returns a empty JSON payload with the 200 ACCEPTED status.

This endpoint permanently deletes the payment adjustment. This cannot be undone.

The URL must contain a valid transaction ID, matching one returned from [GET /v1/dynamic_discounting/payment_adjustments](#retrieve-payment-adjustments). The transaction ID is not the same as the reference of the payment adjustment submitted by you.

The payment adjustment cannot be deleted if it is already part of a payment instruction.

### HTTP Request

`DELETE https://api.novicap.com/v1/dynamic_discounting/payment_adjustments/:transaction_id`

### Response

A successful response has a 200 OK HTTP status code.

