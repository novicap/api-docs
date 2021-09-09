## Errors

Any HTTP request may fail with one of the following errors.

Error Code | Meaning
---------- | -------
400 | Bad Request -- The formatting of the request is not correct
401 | Unauthorized -- Your API key is not recognised
403 | Forbidden -- Your API key is recognised and the URL is correct, but you do not have permission to perform that action
404 | Not Found -- The URL is not correct
500 | Internal Server Error -- We had an unexpected problem on our side - contact support or try again later
502 | Bad Gateway -- Something went wrong between you and our servers - contact support or try again later
503 | Service Unavailable -- We're under unusually high load and can't respond to that request at the moment - contact support or try again later
504 | Gateway Timeout -- We're under unusually high load and can't respond to that request at the moment - contact support or try again later
