# Line quote

## Submit a line quote

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
debtor_ids |         |          | An array of BVD IDs of debtors you want quotes for.

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
  "credit_limit": 200000,
  "opening_fee": 2.25,
  "commission": 900
}
```

Exchange a quote ID for a quote.

### HTTP Request

`GET http://api.novicap.com/v1/line_quote`

### URL Parameters

Parameter  | Default | Required | Description
---------  | ------- | -------- | -----------
api_key    |         | ✓        | Your api key for authentication.
quote_id   |         | ✓        | The quote ID retrieved from the previous step.
