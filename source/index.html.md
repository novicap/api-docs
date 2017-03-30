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

Welcome to the NoviCap early payments API.
You can use our API to receive automated quotes for invoices, synchronize invoices to our platform and communicate invoice status updates to our system.

There are two steps for integrating with us, the first is to use the light integration to enable customers to onboard and open a factoring facility with us (sign legal, upload docs,...).

After the initial onboarding is complete and a company is activated, you can trade invoices automatically through the API and there is no more need for the customer to login to novicap.

If you do not have access to the API yet, please [sign up here](https://app.novicap.com/partner_registration) and reach out to api@novicap.com to enable API access for your partner account.

# Authentication

> To authorize while using the endpoint `line_quote`:

```shell
curl "https://api.novicap.com/line_quote" --data api_key=abcd
```

> where `abcd` should be replaced with your API key.

We use API keys to authenticate. You can generate a new API key by logging into your partner account at [novicap.com](https://www.novicap.com)

The API key should be included in all requests to the server as an HTTP request parameter named `api_key`.
