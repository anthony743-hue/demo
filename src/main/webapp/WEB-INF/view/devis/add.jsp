<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${action}</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
</head>

<body class="bg-light">
    <div class="container-fluid py-4">
        <div class="row justify-content-center">
            <div class="col-lg-12">
                <!-- Carte principale -->
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
                            <div>
                                <h1 class="h4 mb-1">${action}</h1>
                            </div>
                            <a class="btn btn-outline-secondary" href="<c:url value='/devis/list' />">
                                <i class="bi bi-list-ul me-1"></i> Voir la liste
                            </a>
                        </div>
                    </div>

                    <div class="card-body">
                        <!-- Section Devis (informations générales) -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h2 class="h5 mb-3">Devis</h2>
                                <!-- Champ Demande avec input-group -->
                                <div class="mb-3">
                                    <label for="demandeInput" class="form-label fw-semibold">Demande</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" class="form-control" id="demandeInput"
                                               name="reference" placeholder="Référence de la demande...">
                                    </div>
                                </div>

                                <!-- Formulaire principal (client, date, lieu, type) en grille -->
                                <form id="formTemp">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="client" class="form-label fw-semibold">Client</label>
                                            <input type="text" readonly class="form-control" id="client"
                                                   name="client" placeholder="****">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="date" class="form-label fw-semibold">Date</label>
                                            <input type="date" name="createAt" class="form-control" id="date">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="lieu" class="form-label fw-semibold">Lieu</label>
                                            <input type="text" name="lieu" readonly class="form-control"
                                                   id="lieu" placeholder="****">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="type" class="form-label fw-semibold">Type</label>
                                            <select name="type" id="type" class="form-select">
                                                <option value="1">Etude</option>
                                                <option value="2">Forage</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Section Détail des lignes de devis -->
                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h2 class="h5 mb-0">Détail</h2>
                                    <button id="addButton" class="btn btn-outline-primary">
                                        <i class="bi bi-plus-lg"></i> Ajouter
                                    </button>
                                </div>

                                <!-- Tableau responsive avec style Bootstrap -->
                                <div class="table-responsive">
                                    <table id="tableDevis" class="table table-striped table-bordered table-hover align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Libellé</th>
                                                <th>Qté</th>
                                                <th>PU</th>
                                                <th>Montant</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="devisBody">
                                            <!-- Ligne de saisie fixe (toujours dans le tbody) -->
                                            <tr id="inputRow" class="table-light">
                                                <td><input type="text" name="libelle" form="inputDevis" id="inputLibelle" class="form-control form-control-sm" placeholder="Libellé"></td>
                                                <td><input type="number" name="qte" form="inputDevis" id="inputQte" class="form-control form-control-sm" placeholder="Qté"></td>
                                                <td><input type="number" name="pu" form="inputDevis" id="inputPu" class="form-control form-control-sm" placeholder="PU"></td>
                                                <td></td>
                                                <td><div class="d-flex justify-content-end mt-3">
    <button id="saveDevisBtn" class="btn btn-success">Enregistrer le devis</button>
</div></td>
                                            </tr>
                                            <!-- Les lignes de devis seront injectées ici -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts Bootstrap -->
    <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
    <!-- Votre script JavaScript (inchangé) -->
    <script>
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
                if (!val) return;
                const url = contextPath + "/demande/byref?" + new URLSearchParams("ref=" + val);
                try {
                    const res = await fetch(url);
                    if (!res.ok) throw new Error("Erreur réseau");
                    const demande = await res.json();
                    sessionStorage.setItem("demande", JSON.stringify(demande));
                    form.elements['client'].value = demande.client.nom;
                    form.elements['lieu'].value = demande.commune.nom;
                } catch(e) { console.error(e); }
            }
            dmd.addEventListener("input", e => searchDemandeByRef(e.target.value.trim()));

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
    console.log(demandeFromSession);
    if (!demandeFromSession || details.length === 0) {
        alert("Remplissez la référence et ajoutez au moins un détail.");
        return;
    }

    const observation = prompt("Observation (optionnel) :") || "";

    const payload = {
        dmd: {
            id : demandeFromSession.id
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
    </script>
</body>
</html>