## Retrieve confirming payment instructions

```shell
curl --header "Authorization: Bearer abcd" "https://api.novicap.com/v1/confirming_standard/payment_instructions?product_id=123"
```

> The above command returns a JSON payload with the 200 OK status.

This endpoint returns all the payments instructions associated with the product.

### HTTP Request

`GET https://api.novicap.com/v1/confirming_standard/payment_instructions`

### Confirming payment instructions

| Parameter            | Type  | Format                                                       | Description                                  |
|----------------------+-------+--------------------------------------------------------------+----------------------------------------------|
| payment_instructions | Array | Array of [payment instruction objects](#confirming-payment-instruction) | List of payment instructions in your account |

### Confirming payment instruction

| Parameter              | Type   | Format                                     | Description                                                 |
|------------------------+--------+--------------------------------------------+-------------------------------------------------------------|
| payment_instruction_id | String |                                            | A unique ID for this payment instruction                    |
| invoices               | Array  | Array of [invoice objects](#confirming-invoice-index) | A list of invoices associated with this payment instruction |
| payments               | Array  | Array of [payment objects](#confirming-payment)       | A list of payments to make, one per supplier                |

### Confirming payment

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

A successful response has a 200 OK HTTP status code along with the list of [payment instructions](!confirming-payment-instruction) and the included invoices.
