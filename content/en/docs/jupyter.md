---
title: "Jupyter Hub and Lab"
linkTitle: "Jupyter"
weight: 100
description: >-
     Page description for heading and indexes.
---

## What is Jupyter (Notebooks, -Lab, and -Hub)?

Jupyter is a development environment supporting some popular languages like Python and R. The basic Jupyter environment that a user develops in is called a "Notebook". The notebook is an interactive tool for data analysis, visualization, and exploration. Notebooks can be used and developed in a web browser. JupyterLab is a web based development environment for notebooks, so provides more power to the user. Instances of JupyterLab are generated and served by JupyterHub. Each user gets their own JupyterLab instance, which is spawned by a Kubernetes Spawner (kubespawner).

At SSB the JupyterLab instances are protected from direct access to the internet, to secure live data. At the moment all Python and R libraries/packages must be pre-built into the JupyterLab instances when they are served to the user. This means that...
1. users don't always have access to the libraries they want In the future, and the DAPLA team has to spend precious time on the menial work of adding a library to a Dockerfile, and figuring out dependency issues. 
2. Some packages/libraries have specific version dependencies, so when everyone is sharing the same version of every package it means a lot of desirable settups are simply not possible. 

These two issues problems could be remidied by giving users access to a package repository and package manager. As I see it, there are two main options for giving users access to a package repository: 
1. Opening egress for "pip" (the python package manager), enabling users to install any package they want from the centralized repository on the internet. This has the upside of giving users ultimate empowerment and productivity. We should be able to train our users to personally vet the packages they are going to use, and ask for a second oppinion if in doubt. Either way, it should not be possible for a "bad" package to do damage to the data or the system.
2. The safer option, that also takes a lot more work, is creating either an in-house package repository hosting safe/vetted packages, or a proxy that only allows people to get safe/vetted packages from the internet. This would mean that package manager commands like "pip" are redirected to this server. We could have a document on GitHub containing a structured list of packages (and versions of those packages) that the server allows users to retrieve. Users would be free to make pull requests directly to this list, where they add the package and/or version of that package that they want available. In the pull request they have to give the reason why they want/need the package, and confirm that they think the package is safe. 

Users get a new instance of JupyterLab every time they open it, so in the case where they have access to a package manager, they should be able to write an installation script for setting up the environment they need with the right packages consistently, so that they can replicate their work environment without issues. When setting up a work environment using a script you should always specify package versions, so that the environment will always be stable and replicatable. 

Jupyter code and configuration is located in this repository: https://github.com/statisticsnorway/dapla-gcp-jupyter
- `/jupyterhub/Dockerfile` defines the Docker image for JupyterHub
- `/jupyter/Dockerfile` defines the Docker image for JupyterLab. This is where you must specify which libraries should be built into the kernels. 
     - Every time a user wants a new library, we must 
          1. Make a change to this docker file 
          2. Re-run the azure pipeline that builds this image and uploads it to GCR 
          3. Change the JupyterHub deployment to point to the new JupyterLab image
	- It would be nice to automate the deployment of new JupyterLab images to staging (on merge to master of JupyterLab Dockerfile).

The Jupyter deployment configuration (flux/helm yaml) is located here: https://github.com/statisticsnorway/platform-dev/blob/master/flux/staging-bip-app/dapla-spark/jupyter/jupyter.yaml
This yaml specifies the Jupyter Hub deployment. However, this includes specifying which image should be used for the JupyterLab instance, which means that some JupyterLab settings are here too.
