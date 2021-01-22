---
title: "Converter App REST API"
linkTitle: "REST API"
type: swagger
draft: false
weight: 40
---

{{% alert title="Note" color="info" %}}
None of the rawdata-converter applications are publicly available. Thus, the interactive request stuff in the Swagger UI will not work unless you [configure access explicitly]({{< ref "#accessing-live-rawdata-converter-applications" >}}).
{{% /alert %}}

The following REST endpoints are available by default in all rawdata converter apps.

{{< swaggerui src="/openapi/rawdata-converter.yml" >}}


## Accessing live rawdata-converter applications

The endpoint used by the Swagger UI above addresses a non-existent url (`http://localhost:30900`). However, you can easily point this to a live rawdata converter by using a local proxy.

### Port forwarding with kubectl

With `kubectl`, you can configure a port forward "tunnel" to a rawdata-converter app kubernetes pod.

First, retrieve the name of a pod:

```shell
$ kc get pods | grep rawdata-converter

rawdata-converter-foo-6c4d9695c6-x68tn
rawdata-converter-bar-575898498c-9msfh
rawdata-converter-baz-355c756466-rt2x5
```

Then configure port-forwarding from `localhost:30900` to the converter running on port `8080`

```shell
$ kubectl port-forward rawdata-converter-foo-6c4d9695c6-x68tn 30900:8080
```

### Avoiding CORS validation

You will also need to avoid CORS validation. There are [multiple ways to do this](https://medium.com/swlh/avoiding-cors-errors-on-localhost-in-2020-5a656ed8cefa). If you're using Chrome, then [this plugin](https://chrome.google.com/webstore/detail/moesif-origin-cors-change/digfbfaphojjndkpccljibejjbppifbc?hl=en) can help you out.