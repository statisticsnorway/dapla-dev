---
title: "Working with Rawdata Converter Apps"
date: 2021-01-07T15:21:51+01:00
weight: 10
---

## Configuring your development environment

### rawdata-converter-project

Although not mandatory, it is recommended that you work with rawdata-converter apps via the [rawdata-converter-project](https://github.com/statisticsnorway/rawdata-converter-project). It facilitates a development environment for working with multiple standalone Rawdata Converter repos in a common context. This makes it easy to make changes and debug code across of rawdata converter components.

```sh
$ git clone git@github.com:statisticsnorway/rawdata-converter-project.git
```

Then use `make update-all` to pull down all registered rawdata-converter-apps (listed in the `repos.txt` file).

Later, use `make status-all` if you want to check for remote updates to any of the associated rawdata-converter repositories.

Open the rawdata-converter-project `pom.xml` in your favorite IDE.