---
title: "DLP Pseudo Service REST API"
linkTitle: "REST API"
type: swagger
draft: false
weight: 40
---

{{% alert title="Note" color="info" %}}
The dapla-dlp-pseudo-service is not publicly available. Thus, the interactive request stuff in the Swagger UI will not work unless you [configure access explicitly]({{< ref "#accessing-the-pseudo-service" >}}).
{{% /alert %}}

{{< swaggerui src="/openapi/dapla-dlp-pseudo-service.yml" >}}


## Accessing the pseudo service

The endpoint used by the Swagger UI above addresses a non-existent url (`http://localhost:30950`). However, you can easily point this to a live pseudo service by using a local proxy.

### Port forwarding with kubectl

With `kubectl`, you can configure a port forward "tunnel" to the dapla-dlp-pseudo-service kubernetes pod.

First, retrieve the name of the pod:

```shell
$ kubectl get pods | grep pseudo-service

dapla-dlp-pseudo-service-6c4d9695c6-x68tn
```

Then configure port-forwarding from `localhost:30950` to the pseudo service running on port `8080`

```shell
$ kubectl port-forward dapla-dlp-pseudo-service-6c4d9695c6-x68tn 30950:8080
```
