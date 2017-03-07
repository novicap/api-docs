## Create an invoice

This endoint allows you to create invoices automatically.

Note that you should have at least one sold invoice in NoviCap before create new ones using this endoint.

```shell
curl "https://api.novicap.com/v1/invoices" --data "key=abcd&invoice[amount]=10000\
&invoice[company_novicap_id]=ESX7895123H \
&invoice[debtor_novicap_id]=ESX8445123H \
&invoice[due_at]=2017-04-15 \
&invoice[issued_at]=2017-03-15 \
&invoice[reference]=201702"
```

> The above command returns the following response:

```json

{
  "advance_amount":            0,
  "company_name":              "Company 73",
  "company_novicap_id":        "ESX7895123H",
  "cost":                      100,
  "debtor_name":               "Debtor Inc.",
  "debtor_novicap_id":         "ESX8445123H",
  "due_date":                  "2017-04-15",
  "grace_period_cost_per_day": 16.25,
  "grace_period_end_date":     "2017-03-15",
  "interest_rate":             650,
  "investment_period":         30,
  "invoice_amount":            10000,
  "overdue_cost_per_day":      30,
  "receive_on_due_date":       7713,
  "status":                    "approved",
  "transaction_number":        "IG-001333"
}

```

Possible returned status codes:

- 201 (created) if the invoice was created.
- 409 (conflict) if you already have a similar invoice.
- 403 (forbidden) if you are not allowed to create this invoice. It may be because you don't have sold invoices or because the api_key is not correct.

### HTTP Request

`POST https://api.novicap.com/v1/invoices`

### Data

Parameter                   | Unit                   | Description
----------------------------|------------------------|----------------------------------------
api_key                     |                        | Your api key for authentication.
invoice[amount]             | eurocents              | The face value of the invoice
invoice[company_novicap_id] |                        | The NoviCap ID of the company.
invoice[debtor_novicap_id]  |                        | The NoviCap ID of the invoice's debtor.
invoice[due_at]             | Date in iso3601 format | The invoice due date.
invoice[issued_at]          | Date in iso3601 format | The invoice issued date.
invoice[reference]          |                        | The invoice reference.

### Response

> A successful response is a JSON compatible with the following schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Invoices endpoint json schema",
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
    "grace_period_end_date":     {
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

A successful response is a JSON payload with the following fields:

Variable                      | Type    | Unit            | Description
------------------------------|---------|-----------------|---------------------------------------------------------------------------------------------------------------------------------
advance_amount                | Integer | eurocents       | The amount advanced to the company.
advanced_date                 | String  | Iso 8601 format | The date when NoviCap advanced the funds to the company.
company_name                  | String  |                 | The name of the company
company_novicap_id            | String  |                 | The NoviCap ID of the company.
cost                          | Integer | eurocents       | The invoice amount.
debtor_name                   | String  |                 | The name of the debtor.
debtor_novicap_id             | String  |                 | The NoviCap ID of the invoice's debtor.
due_date                      | String  | ISO 8601 format | The invoice due date
grace_period_cost_per_day     | Number  |                 | The cost for every day in the grace period.
grace_period_end_date         | String  | Iso 8601 format | The due date for the grace period.
initial_expected_payment_date | String  | Iso 8601 format | The date the company expects the debtor to pay.
interest_rate                 | Number  |                 | The annual interest rate that the company has to pay on the advanced amount.
invoice_amount                | Integer |                 | The face value of the invoice
overdue_cost_per_day          | Number  |                 | The cost for every day overdue.
payment_date                  | String  | Iso 8601 format | The date in which the debtor paid to NoviCap.
receive_on_due_date           | String  | eurocents       | The difference between what the debtor paid to NoviCap and what the company has to pay back to NoviCap. When the invoice is paid, NoviCap deducts the owed amount and then gives any remaining amount back to the company.
status                        | String  |                 | The status of the invoice. One of: "accepted", "defaulted", "financed", "paid", "rejected" ore "submitted".
transaction_number            | String  |                 | The Novicap ID of the transaction.
