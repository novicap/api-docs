# Identifying companies

Our system uses a unique ID for each company (supplier or debtor) composed of the [ISO 2-letter country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) and an ID depending on the country. It is required for us to correctly identify the legal entity we're dealing with.

In the United Kingdom, this is defined as `GB` and the 8 digit Companies House number. For example, Tesco PLC has a country code of `GB` and an ID of `00445790`.

In Spain, this is defined as `ES` and the CIF code. For example, Mercadona SA has a country code of `ES` and an ID of `A46103834`.
