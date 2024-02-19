package main

import (
	"context"
	"encoding/hex"
	"fmt"
	rpc "github.com/celestiaorg/celestia-node/api/rpc/client"
	"github.com/celestiaorg/celestia-node/share"
	"github.com/rollkit/celestia-da/celestia"
	"log"

	"github.com/rollkit/go-da"
)

var (
	rpcAddr = "http://127.0.0.1:26658"
)

func main() {
	fmt.Println("this is a celestia upload test")

	ctx := context.TODO()
	client, err := rpc.NewClient(ctx, rpcAddr, "")
	if err != nil {
		panic(err.Error())
	}

	ns, err := hex.DecodeString("0000d832b53576dd9ef4")
	if err != nil {
		panic(err.Error())
	}

	namespace, err := share.NewBlobNamespaceV0(ns)
	if err != nil {
		panic(err.Error())
	}

	ceda := celestia.NewCelestiaDA(client, namespace, -1, ctx)

	msg1 := []byte("message 1")
	//msg2 := []byte("message 2")

	ctx = context.TODO()
	id1, proof1, err := ceda.Submit(ctx, []da.Blob{msg1}, -1)
	log.Println(id1)
	log.Println(proof1)
	log.Println(err)
}
