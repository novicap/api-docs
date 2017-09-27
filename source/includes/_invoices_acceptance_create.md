## Accept an invoice

This endpoint allows you to accept an existing invoice.

Note that you can only accept invoices for trade relationships that already have at least one invoice sold.

```shell
curl "https://api.novicap.com/v1/invoices/:transaction_number/acceptance" --data "api_key=abcd"
```

> The above command returns a empty JSON with the 201 CREATE status.

Possible returned status codes:

- 201 (created) if the invoice has been accepted.
- 422 (unprocessable entity) if the invoice could not been accepted.

### HTTP Request

`POST https://api.novicap.com/v1/invoices/:transaction_number/acceptance`

### Data

Parameter          | Type   | Description
-------------------|--------|----------------------------------
api_key            | String | Your API key for authentication.
transaction_number | String | The Novicap ID of the transaction

### Response

A successful response is an empty JSON with a proper HTTP status code.
