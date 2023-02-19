// Default provider.
var provider = window.ethereum;

// request ethereum signature for message from account
async function personalSign(provider, account, message) {
    const signature = await provider.send('personal_sign', [message, account]);
    return signature;
}

// get user nonce
async function getUuidByAccount(account) {
    const response = await fetch("/users/" + account + "/nonce");
    const nonceJson = await response.json();
    if (!nonceJson) { return null };
    return nonceJson[0].eth_nonce;
}

function attachWalletBinding() {
    let elements = document.querySelectorAll('.button.login');

    if (elements) {
        for (let i = 0; i < elements.length; i++) {
            elements[i].addEventListener('click', async (e) => {
                // TODO: use most foolproof way of checking null or empty
                if (elements[i].dataset != null && elements[i].dataset .path != null) {
                    document.querySelector('.redirect_path').value = elements[i].dataset.path;
                }
                attachMeta(e);
            }, { once: true});
        }
    }
}

const attachMeta = async function (e) {
    e.preventDefault;

    var instance = window.ethereum;
    // TODO: Change infuraID
    const providerOptions = {
        injected: {},
        coinbasewallet: {
            package: CoinbaseWalletSDK,
            options: {
                appName: "ReapersNFT",
                infuraId: "960ac78dbd804f7bb6d912ee0ec78ecf",
            }
        },
        walletconnect: {
            package: WalletConnectProvider,
            options: {
                infuraId: "960ac78dbd804f7bb6d912ee0ec78ecf",
            }
        }
    };

    const web3Modal = new Web3Modal.default({
        network: "mainnet",
        cacheProvider: false,
        providerOptions,
    });

    web3Modal.clearCachedProvider();

    try {
        instance = await web3Modal.connect();
        provider = new ethers.providers.Web3Provider(instance);
    } catch (error) {
        console.log(error);

        // Attach button again if we fail to connect.
        // The user closed the popup.
        attachWalletBinding();

        return;
    }

    if (provider) {
        const etherbase = (await provider.getSigner().getAddress()).toLowerCase();
        const nonce = await getUuidByAccount(etherbase);

        if (nonce) {
            const message = "Welcome to ReapersNFT!\n\n" +
                "Click to sign in.\n\n" +
                "This request will not trigger a blockchain transaction or cost any gas fees.\n\n" +
                "Wallet address: " + etherbase + "\n\n" +
                "Nonce: " + nonce;

            var signature = null;
            try {
                // Switch to the correct chain to fix signing issues.
                if ((await provider.getNetwork()).chainId != 1) {
                    await provider.send('wallet_switchEthereumChain', [{ chainId: '0x1' }]);
                }
                signature = await personalSign(provider, etherbase, message);

                if (!signature) {
                    console.log("Signature not provided!")

                    attachWalletBinding();

                    return;
                }
            } catch (error) {
                console.log(error);

                // Attach button again if the user doesn't allow the signing..
                attachWalletBinding();

                return;
            }

            const formNewSession = document.querySelector('form.new_session');
            if (!formNewSession) {
                return
            }
            const formInputEthAddress = document.querySelector('input.eth_address');
            const formInputEthSignature = document.querySelector('input.eth_signature');
            const formAuthToken = document.querySelector('[name="authenticity_token"]');

            formInputEthAddress.value = etherbase;
            formInputEthSignature.value = signature;
            formAuthToken.value = document.querySelector('meta[name="csrf-token"]').content;
            formNewSession.submit();
        }
    } else {
        console.log('Please install a wallet like MetaMask!');
        const metamaskMsg = document.getElementById("install-wallet-message")
        if (metamaskMsg != null) {
            document.getElementById("install-wallet-message").style.display = "block";
        }
    }
};

window.attachMeta = attachMeta;
window.attachWalletBinding = attachWalletBinding;
