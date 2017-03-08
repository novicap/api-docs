## Mark an invoice as approved by debtor

This endpoint allows you to mark an existing invoice as approved by debtor.

Note that you can only approve invoices for trade relationships that already have at least one invoice sold.

```shell
curl "https://api.novicap.com/v1/invoices/:transaction_number/approved_by_debtor" --data "api_key=abcd"
```

> The above command returns a empty JSON with the 201 CREATE status.

Possible returned status codes:

- 201 (created) if the invoice has been marked as approved by debtor.
- 422 (unprocessable entity) if the invoice could not been modified.

### HTTP Request

`POST https://api.novicap.com/v1/invoices/:transaction_number/approved_by_debtor`

### Data

Parameter          | Type   | Description
-------------------|--------|----------------------------------
api_key            | String | Your api key for authentication.
transaction_number | String | The Novicap ID of the transaction

### Response

A successful response is an empty JSON with a proper HTTP status code.
