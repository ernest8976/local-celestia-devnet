# qa-net

### step1. build the celestia-app images.
```shell
./celestia-app-build.sh
```

### step2. build the celestia-da images
```shell
./celestia-da-build.sh
```

### step3. start the simpleist cluster
```shell
./start-cluster.sh
```

### step4. remove the cluster
```shell
./clean-cluster.sh
```

### todo
- verify the celestia logic
- support more types da-node,i.e. full-node,light-node