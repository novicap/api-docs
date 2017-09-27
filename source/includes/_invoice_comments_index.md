## Retrieve invoice comments

This endpoint allows you to retrieve your comments for a specific invoice.

```shell
curl "https://api.novicap.com/v1/invoices/:transaction_number/comments?api_key=abcd"
```

> The above command returns a JSON with a list of comments:

```json
[
  {
    "comment": "An invoice comment",
    "created_at": "2017-03-06T00:00:00Z",
    "author_name": "Author Name"
  }
]
```

### HTTP Request

`GET https://api.novicap.com/v1/invoices/:transaction_number/comments`

### URL Parameters

Parameter          | Type   | Description
-------------------|--------|----------------------------------
api_key            | String | Your api key for authentication.
transaction_number | String | The Novicap ID of the transaction

### Response

> A successful response is a JSON compatible with this schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Comment representation in json schema",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "author_name": { "type": "string" },
      "comment": { "type": "string" },
      "created_at": { "type": "string" }
    }
  }
}
```
A successful response is a JSON payload with the following fields for each item:

Variable    | Type   | Unit                     | Description
------------|--------|--------------------------|-------------------------------------
author_name | String |                          | The name of the author.
comment     | String | The body of the comment. |
create_at   | String | Iso 8601 format          | A timestamp with the comment creation time.
