# NoviCap IDs

Our system has a unique ID for each legal entity (company or debtor) which will be referred to as the `novicap_id`. It is required to find financial information that we use for quotes.

In the United Kingdom, this is defined as the 8 digit company number prefixed with "GB". For example, Tesco PLC has a `novicap_id` of `GB00445790`.

In Spain, this is defined as the CIF code prefixed with "ES". For example, Mercadona SA has a `novicap_id` of `ESA46103834`.

To be certain you have generated the correct `novicap_id`, or if you cannot generate it with the information you have available, you can use the [search API](#search) with the company name.
