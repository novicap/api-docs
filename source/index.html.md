---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - novicap_ids
  - light_integration
  - api
  - search
  - line_quote
  - companies
  - invoices_create
  - invoices_index
  - invoices_show
  - invoices_acceptance_create
  - invoices_approved_by_debtor
  - invoices_paid_by_debtor
  - invoice_comments_create
  - invoice_comments_index
  - errors

search: true
---

# Introduction

Welcome to the NoviCap early payments API. You can use our API to receive automatic quotes for companies. The API is a work in progress and we have documented here the endpoints that are stable.

# Authentication

> To authorize while using the endpoint `line_quote`:

```shell
curl "https://api.novicap.com/line_quote" --data api_key=abcd
```

> where `abcd` should be replaced with your API key.

We use API keys to authenticate. You can generate a new API key by logging into your partner account at [novicap.com](https://www.novicap.com)

The API key should be included in all requests to the server as an HTTP request parameter named `api_key`.

# Permissions

Not all API endpoints are available and you must have specific permission to use an endpoint.
If you get receive an error while trying to access a specific endpoint, do not hesitate to contact our API team at api@novicap.com to request access.
