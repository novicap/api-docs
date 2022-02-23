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

If your account has more than one legal entity, you must include a `debtor_id`, representing the entity which will pay invoices to suppliers.


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
| debtor_id  | Number |          |        | The ID of the entity, if your account has more then one legal entity    |

### Response

A successful response has a 201 Created HTTP status code along with a [payment instruction object](#payment-instruction) described below.

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

This endpoint returns all the payments instructions associated with the product.

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

### Payment instructions

| Parameter            | Type  | Format                                                       | Description                                  |
|----------------------+-------+--------------------------------------------------------------+----------------------------------------------|
| payment_instructions | Array | Array of [payment instruction objects](#payment-instruction) | List of payment instructions in your account |

### Payment instruction

| Parameter              | Type   | Format                                     | Description                                                 |
|------------------------+--------+--------------------------------------------+-------------------------------------------------------------|
| payment_instruction_id | String |                                            | A unique ID for this payment instruction                    |
| invoices               | Array  | Array of [invoice objects](#invoice-index) | A list of invoices associated with this payment instruction |
| payments               | Array  | Array of [payment objects](#payment)       | A list of payments to make, one per supplier                |

### Payment

| Parameter     | Type   | Format                               | Description                                                                                                    |
|---------------+--------+--------------------------------------+----------------------------------------------------------------------------------------------------------------|
| supplier_name | String |                                      | Name of the supplier to pay                                                                                    |
| supplier_id   | String | Depends on country code              | The ID of the supplier to pay (see [identifying companies](#identifying-companies))                             |
| debtor_name   | String |                                      | Name of the legal entity that should make the payment, which matters if you have more than one in your account |
| debtor_id     | String | Depends on country code              | The ID of the legal entity that should make the payment (see [identifying companies](#identifying-companies))   |
| amount        | Number |                                      | The amount you should pay the supplier                                                                         |
| iban          | String | IBAN                                 | The bank account you should pay into (if you give it to us)                                                    |
| references    | String | Seperated by ', ' (comma then space) | A list of invoice references included in this payment                                                          |


### Response

A successful response has a 200 OK HTTP status code along with the list of [payment instructions](!payment-instruction) and the included invoices.
