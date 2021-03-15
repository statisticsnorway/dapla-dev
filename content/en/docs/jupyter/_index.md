---
title: "Jupyter"
linkTitle: "Jupyter"
weight: 80
description: >-
     Information about how JupyterLab is hosted on JupyterHub, where the code and configuration is, and what improvements could be made
---

## What is Jupyter?

### Notebooks and JupyterLab
Jupyter notebook is a web browser based tool for interactive data analysis, visualization, and exploration. It supports dusins of popular languages, most notably Python and R. JupyterLab is a development environment for notebooks that like the notebooks themselves also runs in the browser. 

### Hosting JupyterLab with JupyterHub
Instances of JupyterLab are generated and served by JupyterHub, which is running on Kubernetes on BIP. Each user gets their own JupyterLab instance on request. A JupyterLab instance lives in a Kubernetes Pod spawned by a Kubernetes Spawner (kubespawner). As the JupyterLab instances themselves are short lived and not persistent, persistence is provided by storing the work in GCP Buckets. At SSB the JupyterLab instances are protected from direct access to the internet, to secure live data. At the moment all Python and R libraries/packages and JupyterLab plugins must be pre-built into the JupyterLab instances before they are served to the user. All users get JupyterLab instances built from the same image, which means that everyone shares the same configuration of libraries and plugins.

## Code and Configuration
Jupyter code and configuration is located in this repository: https://github.com/statisticsnorway/dapla-gcp-jupyter
- `/jupyterhub/Dockerfile` defines the Docker image for JupyterHub
- `/jupyter/Dockerfile` defines the Docker image for JupyterLab. This is where you must specify which libraries should be built into the kernels. 
     - Every time a user wants a new library, we must 
          1. Make a change to this docker file 
          2. Re-run the azure pipeline that builds this image and uploads it to GCR 
          3. Change the JupyterHub deployment to point to the new JupyterLab image

The Jupyter deployment configuration (HelmRelease yaml) is located here: https://github.com/statisticsnorway/platform-dev/blob/master/flux/staging-bip-app/dapla-spark/jupyter/jupyter.yaml
This yaml specifies the JupyterHub deployment. However, this includes specifying which image should be used for the JupyterLab instance, which means that some JupyterLab settings are here too.

## Python Package Index Server (pypiserver)
Users of JupyterLab sometimes need to install, upgrade or downgrade a python package that is not built into the JupyterLab image by default. For these cases we have deployed an internal python package index server, which makes whitelisted python packages available to JupyterLab users through the command line tool `pip`.

To learn more about how to use this functionality or make new packages or versions available for installation, visit the github repository: https://github.com/statisticsnorway/dapla-pypiserver. 

## Improvements
### Dockerizing production environments
It would be handy to dockerize and archive JupyterLab environments exactly as they are when they are used for producing a statistic. This way we guarantee reproducibility.

### Automated JupyterLab image deployment
It would be nice to automate the deployment of new JupyterLab images to staging (when merging/committing changes to the JupyterLab Dockerfile to master). There is no built in support for this in Flux/Helm.
