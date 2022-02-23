# Authentication

> To authorize while using the endpoint `dynamic_discounting/suppliers`, any of these will work:

```shell
curl "https://api.novicap.com/v1/dynamic_discounting/suppliers" --data '{ "api_key": "abcd", "product_id": 123 }'

curl -H "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/suppliers" --data '{ "product_id": 123 }'

curl -H "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/suppliers?product_id=123"
```

> where `abcd` should be replaced with your API key, and `123` with your product ID. We advise using a JSON payload instead of putting data into the URL, as it is required for more some endpoints that accept things like arrays and objects.

We use an API key to authenticate which can be found by logging into your account at [novicap.com](https://www.novicap.com) and generating it under your user profile. All API hits will be associated with your user and an indefinite audit log is accessible from your account.

The API key should be included in all requests to the server either as a HTTP request parameter named `api_key` or inside an `Authorization: Bearer` HTTP request header.

All API requests target a particular product inside your account, such as factoring or dynamic discounting. Each product has an ID which you can find inside the platform near the API key. The product ID should be included in all requests as a HTTP request parameter named `product_id`.

OAuth 2.0 authentication is available on request. The exact implementation will depend on your authentication provider and workflow.

| Parameter  | Type   | Required | Format | Description                                                             |
|------------|--------|----------|--------|-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |
