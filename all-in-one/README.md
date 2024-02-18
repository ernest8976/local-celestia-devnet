## qa-net

### build the celestia-app images
```shell
./celestia-app-build.sh
```

### build the celestia-da images
```shell
./celestia-da-build.sh
```

### build the local-celestia-devnet images

this is a qa-net for celestia, which include multi celestia-app nodes and celestia-da module.

all docker image are built by forked repo.

To build the Docker image:

```bash
docker build . -t ernest/celestia-local-devnet
```

### start the cluster

```bash
docker run -d -t -i \
    -p 26650:26650 -p 26657:26657 -p 26658:26658 -p 26659:26659 -p 9090:9090 \
    ernest/celestia-local-devnet
```


```bash
curl -X GET http://127.0.0.1:26659/head
```
