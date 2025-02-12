const contractAddress = "YOUR_SMART_CONTRACT_ADDRESS";
const contractABI = [/* YOUR_ABI_HERE */];

let web3;
let contract;
let userAccount;

async function loadWeb3() {
    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const accounts = await web3.eth.getAccounts();
        userAccount = accounts[0];
        document.getElementById("walletAddress").innerText = `Connected: ${userAccount}`;
        contract = new web3.eth.Contract(contractABI, contractAddress);
    } else {
        alert("Please install MetaMask!");
    }
}

document.getElementById("connectWallet").addEventListener("click", loadWeb3);
