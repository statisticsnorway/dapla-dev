[![Netlify Status](https://api.netlify.com/api/v1/badges/67d92d24-062b-4ef5-8fbe-1b6c09ddd465/deploy-status)](https://app.netlify.com/sites/dapla/deploys)

# Dapla Developer Portal

This is the source of the Dapla Development Portal.

The published pages are here: https://dapla.netlify.app/

The site is built using Hugo and the [Docsy](https://github.com/google/docsy) theme. [Docsy](https://github.com/google/docsy) is a Hugo theme for technical documentation sites, providing easy site navigation, structure, and more. You can find detailed theme instructions in the Docsy user guide: https://docsy.dev/docs/


## Running the website locally

To build and serve the site locally:

```
make serve
```

Navigate to `http://localhost:1313`. You can now make changes that will immediately show up in your browser after you save.


## Development

If you want to do SCSS edits and want to publish these, you need to install `PostCSS`

```bash
npm install
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
