[![Netlify Status](https://api.netlify.com/api/v1/badges/67d92d24-062b-4ef5-8fbe-1b6c09ddd465/deploy-status)](https://app.netlify.com/sites/dapla/deploys)

# Dapla Development Portal

This is the source of the Dapla Development Portal consisting of:

* A short highlights section explaining what Dapla is all about
* A "getting started" section for new developers 
* The Dapla reference documentation
 
The portal is built using Hugo and the [Docsy](https://github.com/google/docsy) theme


[Docsy](https://github.com/google/docsy) is a Hugo theme for technical documentation sites, providing easy site navigation, structure, and more. This **Docsy Example Project** uses the Docsy theme, as well as providing a skeleton documentation structure for you to use. You can either copy this project and edit it with your own content, or use the theme in your projects like any other [Hugo theme](https://gohugo.io/themes/installing-and-using-themes/).

The Docsy theme is included in this project as a Git submodule:

```bash
▶ git submodule
 a053131a4ebf6a59e4e8834a42368e248d98c01d themes/docsy (heads/master)
```

You can find detailed theme instructions in the Docsy user guide: https://docsy.dev/docs/


If you want to do SCSS edits and want to publish these, you need to install `PostCSS`

```bash
npm install
```

## Running the website locally

Once you've cloned or copied the site repo, from the repo root folder, run:

```
hugo server
```

## Running a container locally

You can run the dapla-dev portal inside a [Docker](ihttps://docs.docker.com/) container, the container runs with a volume bound to the `dapla-dev` folder. This approach doesn't require you to install any dependencies other than Docker.

1. Build the docker image 

```bash
docker build -f dev.Dockerfile -t dapla-dev:latest .
```

1. Run the built image

```bash
docker run --publish 1313:1313 --detach --mount src="$(pwd)",target=/home/dapla-dev/app,type=bind dapla-dev:latest
```

Open your web browser and type `http://localhost:1313` in your navigation bar,
This opens a local instance of the dapla-dev homepage. You can now make
changes to the dapla-dev portal and those changes will immediately show up in your
browser after you save.

To stop the container, first identify the container ID with:

```bash
docker container ls
```

Take note of the hexadecimal string below the `CONTAINER ID` column, then stop
the container:

```bash
docker stop [container_id]
```

To delete the container run:

```
docker container rm [container_id]
```
