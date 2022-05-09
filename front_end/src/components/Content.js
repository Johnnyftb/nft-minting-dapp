import React from 'react';
import {useEthers, useContractFunction} from "@usedapp/core";
import {utils} from "ethers";
import { Contract } from '@ethersproject/contracts'

import {contractAddress, contractABI} from "../constants/constants";

const contract = new Contract(contractAddress, contractABI);

export default function Content() {

    const { activateBrowserWallet, account, deactivate } = useEthers();

    const [mintAmount, setMintAmount] = React.useState(0);

    function minusMintAmount() {
        setMintAmount((prev) => prev === 0 ? 0 : prev - 1);
    }

    function addMintAmount() {
        setMintAmount((prev) => prev + 1);
    }

    console.log(contractAddress);


    return (
        <section className="content bg-light">
            <div className="container p-5 text-dark d-flex justify-content-between align-items-start">
                <div className="text-start">
                    <h1 className="display-3 fw-bold">Mint Baker Boy NFTs</h1>
                    {!account ? (
                        <button className="btn bg-primary text-light px-4 py-2" onClick={activateBrowserWallet}>Connect Wallet</button>
                    ) : (
                        <>
                            <p className="lead">{account}</p>
                            <button className="btn bg-secondary text-light px-4 py-2" onClick={deactivate}>Disconnect</button>
                        </>
                        
                    )}
                    <div className="d-flex align-items-center justify-content-center mt-5">
                        <i className="fa fa-angle-left fa-2x" onClick={minusMintAmount}></i>
                        <h2 className="fw-bold mx-4 mt-1">{mintAmount}</h2>
                        <i className="fa fa-angle-right fa-2x" onClick={addMintAmount}></i>
                    </div>
                    <p className="text-center">1 NFT = 0.05 ETH</p>
                    <div className="d-flex justify-content-center mt-1">
                        {!account || mintAmount > 1 ? (
                            <button className="btn bg-secondary rounded-pill text-light px-3 py-2">Mint disabled</button>
                        ) : (
                            <button className="btn bg-primary rounded-pill text-light px-3 py-2">Mint</button>
                        )}
                    </div>
                    {mintAmount > 1 && <p className="lead text-danger text-center">Max Mint Amount is 1!</p> }
                    <p className="lead mt-5">Please use Rinkeby network</p>
                    <p className="lead">Contract Address: <a href={`https://rinkeby.etherscan.io/address/${contractAddress}#code`}>{contractAddress}</a></p>
                </div>
                <img src="/images/breadman.png" alt="" />
            </div>
        </section>
    )
}