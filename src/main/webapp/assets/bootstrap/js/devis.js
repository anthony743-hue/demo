document.addEventListener("DOMContentLoaded", () => {
    const tableBody = document.querySelector('#tableDevis tbody');
    const inputLibelle = document.getElementById('inputLibelle');
    const inputQte = document.getElementById('inputQte');
    const inputPu = document.getElementById('inputPu');
    const addBtn = document.getElementById('addButton');
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    const contextPath = "http://localhost:8080";

    // --- Recherche demande (inchangé) ---
    async function searchDemandeByRef(val) {
        if (val === null || val === undefined || val === "") return;
        const url = contextPath + "/demande/byref?" + new URLSearchParams("ref=" + val);
        try {
            const res = await fetch(url);
            if (!res.ok) throw new Error("Erreur réseau");
            const demande = await res.json();
            sessionStorage.setItem("demande", JSON.stringify(demande));
            form.elements['client'].value = demande.client.nom;
            form.elements['lieu'].value = demande.commune.nom;
        } catch (e) { console.error(e); }
    }
    dmd.addEventListener("input", e => {
        searchDemandeByRef(e.target.value.trim());
    });

    // --- Gestion du sessionStorage ---
    const getDevisArray = () => JSON.parse(sessionStorage.getItem("devisArr") || "[]");
    const saveDevisArray = arr => sessionStorage.setItem("devisArr", JSON.stringify(arr));

    function deleteDevis(index) {
        const arr = getDevisArray();
        arr.splice(index, 1);
        saveDevisArray(arr);
        renderDataRows();
    }

    function addDevisToTable(devis, index) {
        const tr = document.createElement('tr');

        const tdLibelle = document.createElement('td');
        tdLibelle.textContent = devis.libelle;
        tr.appendChild(tdLibelle);

        const tdQte = document.createElement('td');
        tdQte.textContent = devis.qte;
        tr.appendChild(tdQte);

        const tdPu = document.createElement('td');
        tdPu.textContent = devis.pu;
        tr.appendChild(tdPu);

        const tdMontant = document.createElement('td');
        const montant = (parseFloat(devis.qte) * parseFloat(devis.pu)).toFixed(2);
        tdMontant.textContent = montant;
        tr.appendChild(tdMontant);

        const tdAction = document.createElement('td');
        const btnDelete = document.createElement('button');
        btnDelete.className = 'btn btn-outline-danger btn-sm';
        btnDelete.textContent = 'Supprimer';
        btnDelete.addEventListener('click', () => deleteDevis(index));
        tdAction.appendChild(btnDelete);
        tr.appendChild(tdAction);

        tableBody.appendChild(tr);
    }

    function renderDataRows() {
        const rows = tableBody.querySelectorAll('tr:not(#inputRow)');
        rows.forEach(r => r.remove());
        const arr = getDevisArray();
        arr.forEach((devis, i) => addDevisToTable(devis, i));
    }

    function addDevis() {
        const libelle = inputLibelle.value.trim();
        const qte = inputQte.value.trim();
        const pu = inputPu.value.trim();

        if (!libelle || !qte || !pu) {
            alert("Veuillez remplir tous les champs.");
            return;
        }

        const devis = {
            libelle: libelle,
            qte: parseFloat(qte),
            pu: parseFloat(pu)
        };

        const arr = getDevisArray();
        arr.push(devis);
        saveDevisArray(arr);
        addDevisToTable(devis, arr.length - 1);

        inputLibelle.value = '';
        inputQte.value = '';
        inputPu.value = '';
    }

    document.getElementById('saveDevisBtn').addEventListener('click', async () => {
        const details = JSON.parse(sessionStorage.getItem("devisArr") || "[]");
        const demandeFromSession = JSON.parse(sessionStorage.getItem("demande") || "null");
        const Type = form.elements['type'].value;
        console.log(demandeFromSession);
        if (!demandeFromSession || details.length === 0) {
            alert("Remplissez la référence et ajoutez au moins un détail.");
            return;
        }

        const observation = prompt("Observation (optionnel) :") || "";

        const payload = {
            dmd: {
                id: demandeFromSession.id,
                status: {
                    designation: Type
                }
            },
            observation: observation,
            details: details
        };

        try {
            const res = await fetch('http://localhost:8080/devis/form', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });
            if (res.ok) {
                alert('Devis enregistré !');
                sessionStorage.removeItem('devisArr');
                sessionStorage.removeItem('demande');
                location.reload();
            } else {
                alert('Erreur : ' + await res.text());
            }
        } catch (err) {
            console.error(err);
            alert('Erreur réseau');
        }
    });

    addBtn.addEventListener("click", addDevis);
    renderDataRows();
});