## Retrieve one invoice

```shell
curl "https://api.novicap.com/invoices/:transaction_number?api_key=abcd"
```

> The above command returns the following JSON:

```json
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
  "transaction_number":        "IG-001333"
}

```

Returns an invoice. Note that this invoice should belong to your company. Otherwise you'll get an error.

### HTTP Request

`GET https://api.novicap.com/v1/invoices/:transaction_number?api_key=abcd`

### URL Parameters

Parameter          | Default | Required | Description
-------------------|---------|----------|---------------------------------------------------------------------------------------------------------------------------
api_key            |         | ✓        | Your api key for authentication.

### Response

> A successful response is a JSON compatible with this schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Auctions (invoices in routes.rb) endpoint json schema",
  "type": "object",
  "properties": {
    "advance_amount":            { "type": "integer" },
    "advanced_date": {
      "type": "string,null",
      "description": "Formatted in iso 8601"
    },
    "company_name":              { "type": "string" },
    "company_novicap_id":        { "type": "string" },
    "cost":                      { "type": "integer,null" },
    "debtor_name":               { "type": "string" },
    "debtor_novicap_id":         { "type": "string" },
    "due_date":                  {
      "type": "string",
      "description": "Formatted in iso 8601"
    },
    "grace_period_cost_per_day": { "type": "number" },
    "grace_period_due_date":     {
      "type": "string",
      "description": "Formatted in iso 8601"
    },
    "initial_expected_payment_date": {
      "type": "string",
      "description": "Formatted in iso 8601"
    },
    "interest_rate":             { "type": "number" },
    "invoice_amount":            { "type": "integer" },
    "overdue_cost_per_day":      { "type": "number" },
    "payment_date": {
      "type": "string,null",
      "description": "Formatted in iso 8601"
    },
    "receive_on_due_date":       { "type": "string,null" },
    "status":                    { "type": "string" },
    "transaction_number":        { "type": "string" }
  }
}
```

A successful response is a JSON payload with these fields:

Variable                      | Type    | Unit            | Description
------------------------------|---------|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
advance_amount                | Integer | eurocents       | The amount advanced to the company.
advanced_date                 | String  | Iso 8601 format | The date when NoviCap advanced the invoice to the company.
company_name                  | String  |                 | The invoice's company's name
company_novicap_id            | String  |                 | The NoviCap ID of the invoice's company.
cost                          | Integer | eurocents       | The invoice's cost.
debtor_name                   | String  |                 | The invoice's debtor's name
debtor_novicap_id             | String  |                 | The NoviCap ID of the invoice's debtor.
due_date                      | String  | ISO 8601 format | The invoice's due date
grace_period_cost_per_day     | Number  |                 | The cost for every day in the grace period.
grace_period_due_date         | String  | Iso 8601 format | The due date for the grace period.
initial_expected_payment_date | String  | Iso 8601 format | The date thecompany expects the debtor to pay.
interest_rate                 | Number  |                 | The annual interest rate that the company has to pay on the advanced amount.
invoice_amount                | Integer |                 | The face value of the invoice
overdue_cost_per_day          | Number  |                 | The cost for every day overdue.
payment_date                  | String  | Iso 8601 format | The date in which the debtor paid to NoviCap.
receive_on_due_date           | String  | eurocents       | The difference between what the debtor paid to NoviCap and what the company has to pay back to NoviCap. When the invoice is paid, NoviCap deducts the owed amount and then gives any remaining amount back to the company.
status                        | String  |                 | The status of the invoice. One of: "accepted", "defaulted", "financed", "paid", "rejected" ore "submitted".
transaction_number            | String  |                 | The Novicap ID of the transaction.
