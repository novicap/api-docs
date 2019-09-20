## Request a line quote

```shell
curl -H "Content-Type: application/json" \
-X POST -d '{
  "api_key": "abcd",
  "company_novicap_id": "ESA12345678",
  "debtor_novicap_ids": ["ESB12345678", "ESC12345678"]
}' \
"https://api.novicap.com/v1/line_quotes"
```

> The above command returns the following response:

```json
{
  "quote_id": "wxyz",
  "company_novicap_id": "ESA12345678",
  "debtor_novicap_ids": ["ESB12345678", "ESC12345678"]
}
```

This endpoint allows you to request a line quote for a company.

Submit a company and an optional list of debtors for an automatic price quote.

It returns a quote ID that can be used to poll for the quote.

### HTTP Request

`POST https://api.novicap.com/v1/line_quotes`

### Parameters

> The params for this endpoint should match this JSON schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "required": ["api_key", "company_novicap_id"],
  "properties": {
    "api_key": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "debtor_novicap_ids": {
      "type": "array",
      "items": {
        "type": "string"
      }
    }
  }
}
```

| Parameter          | Type   | Required | Default | Description                                              |
|--------------------|--------|----------|---------|----------------------------------------------------------|
| api_key            | String | ✓        |         | Your API key for authentication                          |
| company_novicap_id | String | ✓        |         | The `novicap_id` of the company you want a quote for     |
| debtor_novicap_ids | Array  |          | []      | An array of `novicap_id`s of debtors you want quotes for |

<aside class="notice">
You must submit one company at a time, but you may submit as many debtors per company as you want.
</aside>

### Response

> A successful response is a JSON compatible with the following schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "type": "object",
  "properties": {
    "quote_id": { "type": "string" },
    "company_novicap_id": { "type": "string" },
    "debtor_novicap_ids": {
      "type": "array",
      "items": {
        "type": "string"
      }
    }
  }
}
```

A successful response is a JSON payload with the following fields:

| Attribute          | Type   | Description                                                   |
|--------------------|--------|---------------------------------------------------------------|
| quote_id           | String | The ID that can be used to poll for the quote                 |
| company_novicap_id | String | The `novicap_id` of the company you asked for the quote       |
| debtor_novicap_ids | Array  | The array of `novicap_id`s of debtors you asked for the quote |

### Status Codes

| Code | Meaning              | Description                                                              |
|------|----------------------|--------------------------------------------------------------------------|
| 202  | Accepted             | The line quote request has been received and our system is processing it |
| 422  | Unprocessable Entity | The company NoviCap ID is not present                                    |
