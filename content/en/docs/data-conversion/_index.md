---
title: "Data Conversion"
date: 2021-01-07T13:35:33+01:00
draft: false
weight: 45
---

## What is Data Conversion all about?

The goals of _Data Conversion_ in DAPLA are:
* Transform rawdata - that is: data on _whichever_ data format - to a standardized and common data format (avro!)
* Enrich the dataset with required metadata in order to:
  * protect data integrity
  * facilitate for security and data ownership
  * ensure discoverability
* Perform pseudonymization


## What is "Rawdata"?

The term _Rawdata_ is used about data that is _unprocessed_. It denotes data that has simply been transmitted from a data source. The data can be described in a plethora of different data formats.

An important domain object in DAPLA is the "RawdataMessage". In essence it is an envelope that wraps
a set of data elements according to a given data entity.

![Rawdata Message](/images/conversion/rawdata-message.png)

The Data Collection applications are responsible for _producing_ streams of such RawdataMessages. Producing means: Fetch data from a data source and assemble RawdataMessages on an entity basis.

The Data Conversion applications are responsible for _consuming_ streams of RawdataMessages. Consuming means: Transform rawdata to a common format and make it available in the DAPLA data lake.

We typically denote the process of Data Collection and Data Conversion as _Data Ingestion_.

## High Level steps

The following sketch shows a general view of the different steps involved in the DAPLA Data Ingestion process.

```mermaid
sequenceDiagram
    participant Source as Data Source
    participant Collector as Data Collector
    participant RawdataGCS as GCS (Rawdata)
    participant Converter as Data Converter
    participant ConvertedGCS as GCS (Converted Rawdata)
    participant DAPLA as DAPLA Services

    loop while data is available
      Collector->>+Source: retrieve data
      activate Collector
      Collector->>RawdataGCS: write rawdata
      deactivate Collector
    end

    loop while data is available
      Converter->>+RawdataGCS: retrieve rawdata
      activate Converter
      Converter->>ConvertedGCS: write pseudonymized data
      deactivate Converter
    end

    DAPLA->>+ConvertedGCS: retrieve
```

