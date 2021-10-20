## Authentication

> To authorize while using the endpoints, there are two ways:

```shell
curl "https://api.novicap.com/v1/dynamic_discounting/suppliers" --data api_key=abcd

curl -H "Authorization: Bearer abcd" "https://api.novicap.com/v1/dynamic_discounting/suppliers"
```

> where `abcd` should be replaced with your API key. Note that all the endpoints also require a valid `product_id` in the request (see [/v1/dynamic_discounting/suppliers](#add-suppliers)).

We use an API key to authenticate which can be found by logging into your account at [novicap.com](https://www.novicap.com) and generating it under your user profile. All API hits will be associated with your user and an indefinite audit log is accessible from your account.

The API key should be included in all requests to the server either as a HTTP request parameter named `api_key` or inside an `Authorization: Bearer` HTTP request header.

OAuth 2.0 authentication is available on request. The exact implementation will depend on your authentication provider and workflow.

| Parameter  | Type   | Required | Format | Description                                                             |
|------------+--------+----------+--------+-------------------------------------------------------------------------|
| api_key    | String |          |        | Your API key for authentication                                         |
| product_id | Number | ✓        |        | The ID of the product, visible in the Novicap platform near the API key |

All the endpoints also require a valid `product_id` in the request.
