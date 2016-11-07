# Invoice quote

## Request an invoice quote

```shell
curl https://api.novicap.com/quote --header "Content-Type: application/json" --data <<EOF
  {
    "api_key": abcd,
    "company_novicap_id": "ESB94021474",
    "invoices": [
      {
        "debtor_novicap_id": "ESB20707378",
        "invoice_id": "efgh",
        "amount": 50_000.0,
        "days_remaining": 30,
        "payment_method": "bank_transfer",
        "currency": "EUR"
      },
      {
        "debtor_novicap_id": "ESB86126216",
        "invoice_id": "ijkl",
        "amount": 35_000.0,
        "days_remaining": 15,
        "payment_method": "bank_transfer",
        "currency": "EUR"
      }
    ]
  }
EOF
```

> The above command returns JSON structured like this:

```json
{
  "quote_id": "wxyz"
}
```

Submit a company and an optional list of invoices for an automatic price quote.
Returns a quote ID that can be used to poll for the quote.

### HTTP Request

`POST http://api.novicap.com/v1/quote`

### Query Parameters

Parameter          | Default | Required | Example     | Description
-------------------|---------|----------|-------------|------------------------------------------------
api_key            |         | ✓        | "abcd"      | Your api key for authentication.
company_novicap_id |         | ✓        | "ES1234567" | The NoviCap ID of the company you want a quote for.
invoices           | []      |          |             | An array of invoices you want quotes for.

Each invoice may have these parameters:

Parameter         | Default         | Required | Example         | Description
------------------|-----------------|----------|-----------------|-----------------------------------------------------------------------------------------------------
debtor_novicap_id |                 | ✓        | "ES1234567"     | The NoviCap ID of the company you want a quote for.
amount            |                 | ✓        | 20000.0         | The currency amount of the invoice. This example is €20,000.00.
days_remaining    |                 | ✓        | 50              | The number of days before the invoice is paid. This example is 50 days.
payment_method    | "bank_transfer" |          | "bank_transfer" | One of "bank_transfer", "transferable_promissory_note", "non_transferable_promissory_note", "other".
invoice_id        | ""              |          | "12345"         | An identifier for the invoice that can be matched to the corresponding quote later.
currency          | "EUR"           |          | "EUR"           | The currency of the invoice.

## Retrieve an invoice quote

```shell
curl "https://api.novicap.com/quote?api_key=abcd&quote_id=wxyz"
```

> The above command returns JSON structured like this:

```json
{
  "status": "ok",
  "credit_limit": 200000,
  "opening_fee": 2.25,
  "commission": 900,
  "invoices": [
    {
      "status": "ok",
      "apr_on_invoice": 4.2,
      "apr_on_advanced": 6,
      "advanced": 90
    }
  ]
}
```

Exchange a quote ID for a quote.

The response has a `status` parameter. If this is `ok`, the quote is ready to use. Any other status means that the quote is not available or may be incomplete.

Status     | Explanation
-----------|------------------------------------------------------------------------------------------------------------------------------
ok         | Quote successful, included in the response.
processing | The quote is still processing. Try again in a few seconds.
review     | NoviCap could not provide an automatic price quote. The quote may be provided at a later date, or the team may be in contact.
rejected   | NoviCap cannot provide a quote because the company does not pass financing requirements.
taken      | The company already has an account with NoviCap, or a different partner is already associated with the company.

### HTTP Request

`GET http://api.novicap.com/v1/quote`

### URL Parameters

Parameter  | Default | Required | Description
---------  | ------- | -------- | -----------
api_key    |         | ✓        | Your api key for authentication.
quote_id   |         | ✓        | The quote ID retrieved from the previous step.

### Response

A successful response is a JSON payload with these fields:

Variable     | Type   | Unit | Description
-------------|--------|------|-----------------------------------------------------------------------------------------
status       | String |      | One of "ok", "review", or "rejected".
credit_limit | Number | €    | The size of the credit invoice NoviCap can provide to the company.
opening_fee  | Number | %    | The fee NoviCap will charge to open the credit line as a percentage of the credit limit.
commission   | Number | €    | The commission the partner will make if the company opens the line.
invoices     | Array  |      | A list of invoices that were priced as part of the quote.

Each invoice in `invoices` has these fields:

Variable                     | Type   | Unit | Example | Description                                                                                                           
-----------------------------|--------|------|---------|-----------------------------------------------------------------------------------------------------------------------
status                       | String |      |         | One of "ok", "review", or "rejected".                                                                                 
apr_on_invoice               | Number | %    | 4.2     | The annual interest rate NoviCap will charge as a percentage of the total value of the invoice. This example is 4.2%.
apr_on_advanced              | Number | %    | 6       | The annual interest rate NoviCap will charge as a percentage of the amount advanced. This example is 6%.              
apr_on_invoice_amount        | Number | €    | 2100.0  | The interest NoviCap will charge. This example is €2100.0                                                             
fixed_fee_on_invoice         | Number | %    |         | The fee NoviCap will charge as a percentage of the total value of the invoice.                                        
fixed_fee_on_advanced        | Number | %    |         | The fee NoviCap will charge as a percentage of the amount advanced.                                                   
fixed_fee_on_invoice_amount  | Number | €    |         | The fee NoviCap will charge.                                                                                          
fixed_fee_on_advanced_amount | Number | €    |         | The fee NoviCap will charge.                                                                                          
advanced                     | Number | %    |         | The percentage of the total value of the invoice NoviCap will advance.                                                
advanced_amount              | Number | €    |         | The amount of the invoice that NoviCap will advance.                                                                  
invoice_id                   | String |      | "efgh"  | The invoice ID given to us during the quote request. Can be used to match this quote to your own records.             
