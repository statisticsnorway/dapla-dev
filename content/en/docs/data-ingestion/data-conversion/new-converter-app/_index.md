---
title: "Creating a new Converter App"
date: 2021-01-07T15:11:03+01:00
weight: 20
---

{{% alert title="Notice" color="info" %}}
Make sure you have configured your [development environment]({{< ref "docs/data-ingestion/data-conversion/development-environment/#configuring-your-development-environment" >}}).
{{% /alert %}}

## Generate a rawdata converter app

From within your `rawdata-converter-project` workspace, use the [cookiecutter-rawdata-converter-app](https://github.com/statisticsnorway/cookiecutter-rawdata-converter-app) seed to quickly generate a starting base for you new rawdata-converter app. [Cookiecutter](https://cookiecutter.readthedocs.io/) is a scaffolding tool that will prompt for information and use this to generate a new project. Refer to the README for more instructions on how to install and use cookiecutter.

```sh
$ cd $SSB_DEV/rawdata-converter-project
$ cookiecutter gh:statisticsnorway/cookiecutter-rawdata-converter-app

converter_name [SomeName]: Cheese
project_name [rawdata-converter-app-cheese]:
deployment_name [rawdata-converter-cheese]:
project_slug [cheese]:
base_package [no.ssb.rawdata.converter.app]:
package_dir [no/ssb/rawdata/converter/app]:
rawdata_shortname [somerawdata]: cheesedata
micronaut_version [2.1.4]:
rawdata_converter_version [0.6.7]:

```

The generated project is a fully operative Micronaut application. It provides building blocks common for most converter applications, and it relies on the common converter application infrastructure code from [rawdata-converter-coredux](https://github.com/statisticsnorway/rawdata-converter-coredux).

Your main task at hand should be to provide an implementation of the [RawdataConverter](https://github.com/statisticsnorway/rawdata-converter-coredux/blob/master/src/main/java/no/ssb/rawdata/converter/core/convert/RawdataConverter.java) interface. Your implementation will receive `RawdataMessage` objects containing data specific for some data source (e.g. some XML data structure), and the `RawdataConverter` should transform this data into Avro `GenericRecord`s.

Your generated converter app provides you with starting point for your implentation. Have a look at other rawdata converter applications for inspiration on how to write the actual *conversion code*. 

Refer to the [converter app configuration reference]({{< ref "docs/data-ingestion/data-conversion/converter-app-config" >}}) section for a description of the misc application configuration parameters.


## Register the converter app

When you're ready, add the newly generated converter app to [github](https://github.com/organizations/statisticsnorway/repositories/new) and register it in the [repos.txt](https://github.com/statisticsnorway/rawdata-converter-project/blob/master/repos.txt) and [pom.xml](https://github.com/statisticsnorway/rawdata-converter-project/blob/master/pom.xml). This will allow other dapla developers to discover and work with the new converter app in the `rawdata-converter-project` workspace.

Make sure to tag your new github repo with the `dapla` and `rawdata-converter` tags.


## Deploy the converter app

At the root of the generated rawdata converter app is a directory (`./bip`) containing guidance and scripts that can help to get the application deployed into the dapla application cluster.

Files under `./bip/platform-dev` is a starting point for config connector files that can be more or less copied into the [platform-dev](https://github.com/statisticsnorway/platform-dev) repo. Of course, you will need to understand the details of all these files before continuing.