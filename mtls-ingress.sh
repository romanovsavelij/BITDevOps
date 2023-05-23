#!/bin/bash

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \\n  --cacert example_certs1/example.com.crt --cert example_certs1/client.example.com.crt --key example_certs1/client.example.com.key \\n  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"