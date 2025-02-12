async function listModel() {
    const name = document.getElementById("modelName").value;
    const description = document.getElementById("modelDescription").value;
    const price = document.getElementById("modelPrice").value;

    if (!name || !description || !price) {
        alert("Please fill in all fields!");
        return;
    }

    try {
        await contract.methods.listModel(name, description, price)
            .send({ from: userAccount });
        alert("Model listed successfully!");
    } catch (error) {
        console.error("Error listing model:", error);
    }
}

async function loadModels() {
    const modelList = document.getElementById("modelList");
    modelList.innerHTML = "";

    try {
        const modelCount = await contract.methods.getModelCount().call();
        for (let i = 0; i < modelCount; i++) {
            const model = await contract.methods.getModelDetails(i).call();
            const modelItem = document.createElement("div");
            modelItem.innerHTML = `
                <h3>${model.name}</h3>
                <p>${model.description}</p>
                <p>Price: ${model.price} Tokens</p>
                <p>Seller: ${model.creator}</p>
                <button onclick="purchaseModel(${i})">Buy</button>
            `;
            modelList.appendChild(modelItem);
        }
    } catch (error) {
        console.error("Error loading models:", error);
    }
}

async function purchaseModel(modelId) {
    try {
        await contract.methods.purchaseModel(modelId).send({ from: userAccount });
        alert("Model purchased successfully!");
    } catch (error) {
        console.error("Error purchasing model:", error);
    }
}

document.getElementById("listModel").addEventListener("click", listModel);
window.onload = loadModels;
