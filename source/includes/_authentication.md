# Authentication

> To authorize while using a GET endpoint:

```shell
curl -H "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/suppliers?product_id=123"
```

> To authorize while using a POST endpoint, you have more options, since a JSON payload is accepted. Either of these is valid:

```shell
curl -H "Authorization: Bearer abcd" -H "Content-Type: application/json" -X POST -i -d '{"payment_adjustments": []}' \
"https://api.novicap.com/v1/dynamic_discounting/payment_adjustments?product_id=123"
```

```shell
curl -H "Content-Type: application/json" -X POST -i -d '{
  "api_key": "abcd",
  "product_id": 123,
  "payment_adjustments": []
}' \
"https://api.novicap.com/v1/dynamic_discounting/suppliers"
```

> where `abcd` should be replaced with your API key, and `123` with your product ID. We advise using a JSON payload instead of putting data into the URL, as it is required for more some endpoints that accept things like arrays and objects.

We use an API key to authenticate which can be found by logging into your account at [novicap.com](https://www.novicap.com) and generating it under your user profile. All API hits will be associated with your user and an indefinite audit log is accessible from your account.

The API key should be included in all requests to the server either as a HTTP request parameter named `api_key`, inside a JSON payload with key `api_key`, or inside an `Authorization: Bearer` HTTP request header.

All API requests target a particular product inside your account, such as factoring or dynamic discounting. Each product has an ID which you can find inside the platform near the API key. The product ID should be included in all requests as a HTTP request parameter named `product_id` or inside a JSON payload with key `product_id`.

OAuth 2.0 authentication is available on request. The exact implementation will depend on your authentication provider and workflow.
