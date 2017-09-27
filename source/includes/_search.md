## Search

### Search for a company by name or CIF

```shell
curl "https://api.novicap.com/v1/search?api_key=abcd&query=PREPARTS+SL&country=ES"
```

> The above command returns JSON structured like this:

```json
{
  "name": "PRECISSION PARTS PREPARTS SL.",
  "location": "Barcelona",
  "is_public_entity": false,
  "registration_number": "B65354490",
  "country": "ES",
  "size": "unknown",
  "novicap_id": "ESB65354490"
}
```

Searches for a company in our database. Returns a unique `novicap_id` which is used to represent that company in all other requests.

#### HTTP Request

`GET https://api.novicap.com/v1/search`

#### Query Parameters

Parameter | Default | Required | Description
----------|---------|----------|--------------------------------------------------------------------------------------------------
api_key   |         | ✓        | Your api key for authentication.
query     |         | ✓        | The search query. Can be a company name, e.g. "PREPARTS SL" or a CIF/VAT number, e.g. "B65354490"
country   | "ES"    |          | An ISO Alpha-2 country code. The company should be incorporated in this country.

#### Response

> A successful response is a JSON compatible with this schema:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema",
  "description": "Search result representation in json schema",
  "type": "object",
  "properties": {
    "country": { "type": "string" },
    "is_public_entity": { "type": "boolean" },
    "location": { "type": "string" },
    "name": { "type": "string" },
    "novicap_id": { "type": "string" },
    "registration_number": { "type": "string" },
    "size": { "type": "string" }
  }
}
```

A successful response is a JSON payload with these fields:

Variable            | Type    | Description
--------------------|---------|--------------------------------------------------------------------------------------------------------------
country             | String  | An ISO Alpha-2 country code matching the location.
is_public_entity    | Boolean | Whether the company is listed as a public administration.
location            | String  | The location of incorporation of the company.
name                | String  | The official name of the company.
novicap_id          | String  | The `novicap_id` of the company. This will not change and can be used in subsequent requests.
registration_number | String  | A legal identifier of the company. In Spain, this is the CIF code.
size                | String  | The approximate size of the company (revenue). One of: very_large, large, medium, small, very_small, unknown.
