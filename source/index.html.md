---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - line_quote
  - invoice_quote
  - errors

search: true
---

# Introduction

Welcome to the NoviCap invoice discounting API. You can use this service to get fast, automated quotes for companies and specific invoices.

# Authentication

> To authorize while using the endpoint `line_quote`:

```shell
curl "https://api.novicap.com/line_quote" --data api_key=abcd
```

> where `abcd` should be replaced with your API key.

We use API keys to authenticate. You can generate a new API key by logging into your partner account at [novicap.com](https://www.novicap.com)

The API key should be included in all requests to the server as an HTTP request parameter named `api_key`.
