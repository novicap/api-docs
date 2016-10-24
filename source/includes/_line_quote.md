# Line quote

## Request a line quote

```shell
curl "https://api.novicap.com/line_quote" --data api_key=abcd \
                                                 &company_id=ES123456 \
                                                 &debtor_ids[]=ES234567 \
                                                 &debtor_ids[]=ES345678
```

> The above command returns JSON structured like this:

```json
{
  "quote_id": "wxyz"
}
```

Submit a company and an optional list of debtors for an automatic price quote.
Returns a quote ID that can be used to poll for the quote.

### HTTP Request

`POST http://api.novicap.com/v1/line_quote`

### Query Parameters

Parameter  | Default | Required | Description
---------  | ------- | -------- | -----------
api_key    |         | ✓        | Your api key for authentication.
company_id |         | ✓        | The BVD ID of the company you want a quote for.
debtor_ids | []        |          | An array of BVD IDs of debtors you want quotes for.

<aside class="notice">
You must submit one company at a time, but you may submit as many debtors per company as you want.
</aside>

## Retrieve a line quote

```shell
curl "https://api.novicap.com/line_quote" --data api_key=abcd \
                                                 &quote_id=wxyz \
```

> The above command returns JSON structured like this:

```json
{
  "status": "ok",
  "credit_limit": 200000,
  "opening_fee": 2.25,
  "commission": 900
}
```

Exchange a quote ID for a quote.

The response has a `status` parameter. If this is `ok`, the quote is ready to use. Any other status means that the quote is not available or may be incomplete:

Status   | Explanation
---------|------------------------------------------------------------------------------------------------------------------------------
ok       | Quote successful, included in the response.
review   | NoviCap could not provide an automatic price quote. The quote may be provided at a later date, or the team may be in contact.
rejected | NoviCap cannot provide a quote because the company does not pass financing requirements.
taken    | The company already has an account with NoviCap, or a different partner is already associated with the company.

### HTTP Request

`GET http://api.novicap.com/v1/line_quote`

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
credit_limit | Number | €    | The size of the credit line NoviCap can provide to the company.
opening_fee  | Number | %    | The fee NoviCap will charge to open the credit line as a percentage of the credit limit.
commission   | Number | €    | The commission the partner will make if the company opens the line.
debtors      | Array  |      | A list of debtors that were priced as part of the quote.

Each debtor in `debtors` has these fields:

Variable              | Type   | Unit | Description
----------------------|--------|------|------------------------------------------------------------------------------------------------
status                | String |      | One of "ok", "review", or "rejected".
apr_on_invoice        | Number | %    | The annual interest rate NoviCap will charge as a percentage of the total value of the invoice.
apr_on_advanced       | Number | %    | The annual interest rate NoviCap will charge as a percentage of the amount advanced.
fixed_fee_on_invoice  | Number | %    | The fee NoviCap will charge as a percentage of the total value of the invoice.
fixed_fee_on_advanced | Number | %    | The fee NoviCap will charge as a percentage of the amount advanced.
advanced              | Number | %    | The percentage of the total value of the invoice NoviCap will advance.
