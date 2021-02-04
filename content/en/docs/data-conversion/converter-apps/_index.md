---
title: "Rawdata Converter Apps"
date: 2021-01-07T15:11:03+01:00
weight: 20
---

## Overview

The following sketch shows some key components involved inside a Converter Application. The sketch exemplifies a scenario where we are consuming rawdata from multiple rawdata sources.

The blue components constitutes the "converter framework". They're provided by the _Converter Core_ and take care of the heavy lifting and common functionality.

The Green box denotes what is specific for a given converter application. It is responsible for transforming a given rawdata format to Avro format. 

![Converter App Overview](/images/conversion/converter-app-overview.png)

