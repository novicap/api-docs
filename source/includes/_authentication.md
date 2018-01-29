# Authentication

> To authorize while using the endpoint `line_quote`, there are two ways:

```shell
curl "https://api.novicap.com/v1/line_quote" --data api_key=abcd

curl -H "Authorization: Bearer abcd" https://api.novicap.com/v1/line_quote
```

> where `abcd` should be replaced with your API key.

We use an API key to authenticate which can be found in your partner portal > settings under API key section at [novicap.com](https://www.novicap.com). It is possible to refresh the API key automatically by enabling this in your partner portal > settings > activate at [novicap.com](https://www.novicap.com)

The API key should be included in all requests to the server either as a HTTP request parameter named `api_key` or inside an `Authorization: Bearer` HTTP request header.

## Refresh Token Authentication
> To refresh the API key, there are three ways:

```shell
curl -X POST https://api.novicap.com/v1/token?api_key=abcd&refresh_token=wxyz

curl -X POST -H 'Authorization: Basic abcd' https://api.novicap.com/v1/token \
     --data '{ "refresh_token": "wxyz" }'
 
curl -X POST https://api.novicap.com/v1/token \
     --data '{ "client_secret": "abcd", "refresh_token": "wxyz" }'
```

> where `abcd` should be replaced with your current API key and `wxyz` with your current Refresh Token.

> The format of the response is as follows:

```shell
{
  "token_type": "bearer",
  "access_token": "new_access_token",
  "refresh_token": "new_refresh_token",
  "expires_in": 86400 (in seconds)
}
```

By default the API key does not expire, although is possible to make them expire after 1 day.
You can enable this option by logging into your partner account at [novicap.com](https://www.novicap.com)

When enabled, you are no longer able to generate new API keys in the partner account and you will be required to refresh your api key with the refresh token API endpoint when it expires.
The refresh token can be found un your partner portal > settings under Refresh Token API section at [novicap.com](https://www.novicap.com).
 