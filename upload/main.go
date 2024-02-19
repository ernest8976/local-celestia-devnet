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
	rpcAddr  = "http://127.0.0.1:26658"
	rpcToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJwdWJsaWMiLCJyZWFkIiwid3JpdGUiXX0.CP0e8U2NWFtvpj-krp8DFutzK0s7ycH03Nf08z5fCag"
)

func main() {
	fmt.Println("this is a celestia upload test")

	ctx := context.TODO()
	client, err := rpc.NewClient(ctx, rpcAddr, rpcToken)
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

	msg1 := []byte("message 2")
	//msg2 := []byte("message 2")

	ctx = context.TODO()
	//submit data
	id1, proof1, err := ceda.Submit(ctx, []da.Blob{msg1}, -1)
	for i := 0; i < len(id1); i++ {
		log.Println("id: ", hex.EncodeToString(id1[i]))
		log.Println("proof: ", hex.EncodeToString(proof1[i]))
	}
	//get blob
	blob1, err := ceda.Get(ctx, id1)
	log.Println(string(blob1[0]))

	commitment1, err := ceda.Commit(ctx, []da.Blob{msg1})
	log.Println(hex.EncodeToString(commitment1[0]))

	//verify blob
	oks, err := ceda.Validate(ctx, id1, proof1)
	for _, value := range oks {
		log.Println("verify result: ", value)
	}
}
