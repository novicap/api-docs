## Retrieve invoices

```shell
curl "https://api.novicap.com/invoices?api_key=abcd"
```

> The above command returns the following JSON:

```json
[
  {
    "advance_amount":            90000,
    "company_name":              "Company 73",
    "company_novicap_id":        "ESA62511076",
    "cost":                      2287,
    "debtor_name":               "Debtor 87",
    "debtor_novicap_id":         "ESA21532825",
    "due_date":                  "2017-03-20",
    "grace_period_cost_per_day": 16.25,
    "grace_period_due_date":     "2017-03-25",
    "interest_rate":             650,
    "investment_period":         30,
    "invoice_amount":            100000,
    "overdue_cost_per_day":      30,
    "receive_on_due_date":       7713,
    "status":                    "accepted",
    "summary":                   "Chair delivery",
    "transaction_number":        "IG-001333"
  }
]
```

Returns an array with your associated companies' invoices.

### HTTP Request

`GET https://api.novicap.com/v1/invoices?api_key=abcd`

### URL Parameters

Parameter          | Default | Required | Description
-------------------|---------|----------|---------------------------------------------------------------------------------------------------------------------------
api_key            |         | ✓        | Your api key for authentication.
status             |         |          | Filter invoices by current status. It maybe one of "accepted", "defaulted", "financed", "paid", "rejected" ore "submitted".
company_novicap_id |         |          | Return only invoices related to the given company.
debtor_novicap_id  |         |          | Return only invoices related to the given debtor.

### Response

> A successful response is a JSON compatible with this schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Invoices endpoint json schema",
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "advance_amount":            { "type": "integer" },
      "company_name":              { "type": "string" },
      "company_novicap_id":        { "type": "string" },
      "cost":                      { "type": "integer,null" },
      "debtor_name":               { "type": "string" },
      "debtor_novicap_id":         { "type": "string" },
      "due_date":                  { "type": "string" },
      "grace_period_cost_per_day": { "type": "number" },
      "grace_period_due_date":     { "type": "string"},
      "interest_rate":             { "type": "number" },
      "investment_period":         { "type": "integer"},
      "invoice_amount":            { "type": "integer" },
      "overdue_cost_per_day":      { "type": "number"},
      "receive_on_due_date":       { "type": "string,null"},
      "status":                    { "type": "string" },
      "summary":                   { "type": "string"},
      "transaction_number":        { "type": "string" }
    }
  }
}```

A successful response is a JSON payload with these fields for each item:

Variable                  | Type    | Unit            | Description
--------------------------|---------|-----------------|------------------------------------------------------------------------------------------------------------
advance_amount            | Integer | eurocents       |
company_name              | String  |                 | The invoice's company's name
company_novicap_id        | String  |                 | The NoviCap ID of the invoice's company.
cost                      | Integer | eurocents       |
debtor_name               | String  |                 | The invoice's debtor's name
debtor_novicap_id         | String  |                 | The NoviCap ID of the invoice's debtor.
due_date                  | String  | ISO 8601 format | The invoice's due date
grace_period_cost_per_day | Number  |                 |
grace_period_due_date     | String  | Iso 8601 format |
interest_rate             | Number  |                 |
investment_period         | Integer |                 |
invoice_amount            | Integer |                 |
overdue_cost_per_day      | Number  |                 |
receive_on_due_date       | String  | Iso 8601 format |
status                    | String  |                 | The status of the invoice. One of: "accepted", "defaulted", "financed", "paid", "rejected" ore "submitted".
summary                   | String  |                 |
transaction_number        | String  |                 |
