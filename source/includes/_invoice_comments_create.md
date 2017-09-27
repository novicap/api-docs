## Add a comment to an invoice

This endpoint allows you to attach a comment to an existing invoice.
This comment will be reviewed by our operations team and is free text.

Example uses would be notifications of delays in payment, reduction of the invoice amount, status changes in the debtor ERP, ...

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{"api_key":"abcd", "comment": "Test comment"}' \
"https://api.novicap.com/v1/invoices/:transaction_number/comments"
```

> The above command returns a empty JSON with the 201 CREATE status.

Possible returned status codes:

- 201 (created) if comment was created.
- 422 (unprocessable entity) if you miss the comment parameter or the invoice is not valid.

### HTTP Request

`POST https://api.novicap.com/v1/invoices/:transaction_number/comments`

### Data

Parameter          | Type   | Description
-------------------|--------|----------------------------------
api_key            | String | Your api key for authentication.
comment            | String | The body of the comment.
transaction_number | String | The Novicap ID of the transaction

### Response

A successful response is an empty JSON with a proper HTTP status code.
