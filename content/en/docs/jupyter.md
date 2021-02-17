---
title: "Jupyter Hub and Lab"
linkTitle: "Jupyter"
weight: 100
description: >-
     Page description for heading and indexes.
---

## What is Jupyter? (Notebooks, JupyterLab, JupyterHub)

### Notebooks and JupyterLab
Jupyter notebook is a web browser based tool for interactive data analysis, visualization, and exploration. It supports dusins of popular languages, most notably Python and R. JupyterLab is a development environment for notebooks that like the notebooks themselves also runs in the browser. 

### Hosting JupytarLab with JupyterHub
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

### Improvements

#### Let users install and manage their own packages
At SSB the JupyterLab instances are protected from direct access to the internet, to secure live data. At the moment all Python and R libraries/packages must be pre-built into the JupyterLab instances when they are served to the user. This means that...
1. Users don't always have access to the libraries they want. This probably hampers experimentation and exploration, and might lead to sub-optimal solutions or some things not being done at all.
2. When a user requires a library, the DAPLA team has to spend precious time on the menial work of adding a library to a Dockerfile, and figuring out dependency issues. 
3. Some packages/libraries have specific version dependencies, so when everyone is sharing the same version of every package it means a lot of desirable settups are simply not possible. 
4. Versions of libraries that have been added for historical reasons might hamper development of new statistics, and there might be no easy way of figuring out who you will hurt when/if you upgrade or downgrade a library in the common kernel configuration.

These issues could be remidied by giving users access to a package repository and package installer. As I see it, there are two main options for giving users access to package installation: 
1. Opening egress for the package installer (for example "pip", the python package installer), enabling users to install any package they want from the centralized repository on the internet. This has the upside of giving users ultimate empowerment and productivity. We should be able to train our users to personally vet the packages they are going to use, and ask for a second oppinion if in doubt. Either way, it should not be possible for a "bad" package to do damage to the data or the system. In order to open egress, we would need to edit this network policy: https://github.com/statisticsnorway/platform-dev/blob/master/flux/staging-bip-app/dapla-spark/jupyter/networkpolicy.yaml We would probably have to figure out which ports or port range the package installer(s) use(s), and add those.
2. The safer option, that also takes more work, is creating either a proxy that only allows people to get safe/vetted packages from the internet, or even an in-house package repository that is hosting the safe/vetted packages we want to make available to the users. This would mean that package manager commands like "pip" are redirected to this proxy or internal package repo. We could have a document on GitHub containing a structured list of packages (and versions of those packages) that the server allows users to retrieve. Users would be free to make pull requests directly to this list, where they add the package and/or version(s) of that package that they want available. In the pull request they should give the reason why they want/need the package, and confirm that they think the package is safe. 

Users get a new instance of JupyterLab every time they open it. This means that in the case where users have access to a package manager, they should be able to write and execute an installation script for setting up the environment they need with the right packages consistently, so that they can replicate their work environment without issues. When setting up a work environment using a script you should always specify package versions, so that the environment will always be stable and replicatable. 

#### Automated JupyterLab image deployment
It would be nice to automate the deployment of new JupyterLab images to staging (when merging/committing changes to the JupyterLab Dockerfile to master). There is no built in support for this in Flux/Helm.
