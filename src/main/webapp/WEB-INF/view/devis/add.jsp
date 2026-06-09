<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .devis-page-container { background-color: #f9fafb; min-height: 100vh; }
    .anthropic-card { border: 1px solid #e5e7eb; border-radius: 12px; box-shadow: 0 1px 2px 0 rgba(0,0,0,0.05); overflow: hidden; background-color: #ffffff; }
    .anthropic-card .card-header { border-bottom: 1px solid #f3f4f6; padding: 24px 28px; background-color: #ffffff; }
    .anthropic-card .card-body { padding: 28px; }
    .anthropic-card h1 { color: #111827; font-weight: 600; letter-spacing: -0.02em; margin: 0; }
    .section-title { color: #374151; font-weight: 600; font-size: 1rem; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid #f3f4f6; }
    .btn-subtle-link { color: #6b7280; font-size: 0.875rem; font-weight: 500; text-decoration: none; padding: 6px 12px; border-radius: 6px; transition: all 0.15s ease; }
    .btn-subtle-link:hover { background-color: #f3f4f6; color: #111827; }
    .btn-add-primary { background-color: #2563eb; color: #ffffff; border: none; border-radius: 8px; padding: 8px 16px; font-weight: 500; font-size: 0.875rem; transition: background-color 0.15s ease; display: inline-flex; align-items: center; gap: 6px; }
    .btn-add-primary:hover { background-color: #1d4ed8; color: #ffffff; }
    .btn-primary-custom { background-color: #2563eb; border: none; border-radius: 8px; padding: 10px 24px; font-weight: 500; color: #ffffff; transition: background-color 0.15s ease; }
    .btn-primary-custom:hover { background-color: #1d4ed8; color: #ffffff; }
    .anthropic-card .form-label { color: #374151; font-weight: 500; font-size: 0.875rem; margin-bottom: 6px; }
    .anthropic-card .form-control, .anthropic-card .form-select { border: 1px solid #d1d5db; border-radius: 8px; padding: 10px 14px; font-size: 0.9rem; color: #111827; transition: all 0.15s ease; background-color: #ffffff; }
    .anthropic-card .form-control:focus, .anthropic-card .form-select:focus { border-color: #93c5fd; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); outline: none; }
    .table-clean { margin-bottom: 0; border-collapse: collapse; width: 100%; }
    .table-clean thead th { background-color: #f9fafb; color: #6b7280; font-size: 0.75rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.05em; padding: 12px 16px; border-bottom: 1px solid #e5e7eb; }
    .table-clean tbody td { color: #374151; font-size: 0.9rem; padding: 12px 16px; border-bottom: 1px solid #f3f4f6; vertical-align: middle; }
    .table-clean tbody tr:last-child td { border-bottom: none; }
    .table-clean tbody tr:hover td { background-color: #f9fafb; }
    .table-clean .form-control-sm { border: 1px solid #e5e7eb; border-radius: 6px; padding: 8px 12px; font-size: 0.875rem; transition: all 0.15s ease; }
    .table-clean .form-control-sm:focus { border-color: #93c5fd; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1); outline: none; }
    #inputRow td { background-color: #ffffff; border-bottom: 2px solid #e5e7eb; }
    .btn-outline-danger { font-size: 0.8rem; font-weight: 500; padding: 6px 12px; border-radius: 6px; border: 1px solid #e5e7eb; background-color: #ffffff; color: #6b7280; transition: all 0.15s ease; }
    .btn-outline-danger:hover { background-color: #fef2f2; color: #dc2626; border-color: #fecaca; }
    .is-invalid { border-color: #dc2626 !important; }
    .is-invalid:focus { box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1) !important; }
    .invalid-feedback { display: none; color: #dc2626; font-size: 0.75rem; margin-top: 4px; }
    .was-validated .is-invalid ~ .invalid-feedback { display: block; }
    .error-list { list-style-type: disc; padding-left: 20px; color: #b91c1c; background: #fef2f2; padding: 12px 16px; border-radius: 8px; border: 1px solid #fecaca; }
</style>

<div class="container py-5 devis-page-container">
    <div class="row justify-content-center">
        <div class="col-lg-11 col-xl-10">
            <div class="card anthropic-card">
                <%-- <div class="card-header">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
                        <div><h1 class="h4 mb-1">${action}</h1></div>
                        <a class="btn-subtle-link" href="<c:url value='/devis/list' />">
                            <i class="bi bi-list-ul me-1"></i> Voir la liste
                        </a>
                    </div>
                </div> --%>
                <div class="card-body">
                    <!-- Section Devis -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h2 class="section-title">Devis</h2>
                            <form id="formTemp">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label for="demandeRef" class="form-label">Demande</label>
                                        <select name="demande" id="demandeRef" class="form-select">
                                            <option value="" selected>Référence de la demande...</option>
                                            <c:if test="${not empty listeDemande}">
                                                <c:forEach items="${listeDemande}" var="item">
                                                    <option value="${item.reference}">${item.reference}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="client" class="form-label">Client</label>
                                        <input type="text" class="form-control" id="client" name="client" readonly style="background-color: #f9fafb;">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="date" class="form-label">Date</label>
                                        <input type="datetime-local" name="createAt" class="form-control" id="date">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lieu" class="form-label">Lieu</label>
                                        <input type="text" name="lieu" class="form-control" id="lieu" readonly style="background-color: #f9fafb;">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="type" class="form-label">Type</label>
                                        <select name="typeDevis.id" id="type" class="form-select">
                                            <c:if test="${not empty listeStatus}">
                                                <c:forEach items="${listeStatus}" var="item">
                                                    <option value="${item.id}">${item.type}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Section Détail -->
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="section-title mb-0 pb-0 border-0">Détail</h2>
                                <button id="addButton" class="btn btn-add-primary">
                                    <i class="bi bi-plus-lg"></i> Ajouter une ligne
                                </button>
                            </div>

                            <div class="table-responsive" style="border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden;">
                                <table id="tableDevis" class="table table-clean align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th>Libellé</th>
                                            <th style="width: 100px;">Qté</th>
                                            <th style="width: 150px;">PU</th>
                                            <th style="width: 150px;">Montant</th>
                                            <th style="width: 120px;" class="text-center">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="devisBody">
                                        <tr id="inputRow">
                                            <td>
                                                <input type="text" name="libelle" form="inputDevis" id="inputLibelle" class="form-control form-control-sm" placeholder="Désignation...">
                                            </td>
                                            <td>
                                                <input type="number" name="qte" form="inputDevis" id="inputQte" class="form-control form-control-sm" placeholder="0">
                                            </td>
                                            <td>
                                                <input type="number" name="pu" form="inputDevis" id="inputPu" class="form-control form-control-sm" placeholder="0.00">
                                            </td>
                                            <td></td>
                                            <td>
                                                <div class="d-flex justify-content-center">
                                                    <button id="saveDevisBtn" class="btn btn-primary-custom w-100" style="font-size: 0.8rem; padding: 8px 12px;">
                                                        <i class="bi bi-check-lg me-1"></i> Enregistrer
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="globalError" class="mt-3" style="display:none;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script defer>
    document.addEventListener("DOMContentLoaded", function() {
        var tableBody = document.querySelector('#tableDevis tbody');
        var inputLibelle = document.getElementById('inputLibelle');
        var inputQte = document.getElementById('inputQte');
        var inputPu = document.getElementById('inputPu');
        var addBtn = document.getElementById('addButton');
        var demandeRefSelect = document.getElementById('demandeRef');
        var form = document.getElementById('formTemp');
        var contextPath = "http://localhost:8080";
        var globalErrorDiv = document.getElementById('globalError');

        // Aucune validation à l'ajout, on laisse l'utilisateur ajouter sans blocage
        function addDevisToTable(devis, index) {
            var tr = document.createElement('tr');
            var tdLibelle = document.createElement('td');
            tdLibelle.textContent = devis.libelle;
            tr.appendChild(tdLibelle);

            var tdQte = document.createElement('td');
            tdQte.textContent = devis.qte;
            tr.appendChild(tdQte);

            var tdPu = document.createElement('td');
            tdPu.textContent = devis.Pu;
            tr.appendChild(tdPu);

            var tdMontant = document.createElement('td');
            var montant = (parseFloat(devis.qte) * parseFloat(devis.Pu)).toFixed(2);
            tdMontant.textContent = montant;
            tr.appendChild(tdMontant);

            var tdAction = document.createElement('td');
            var btnDelete = document.createElement('button');
            btnDelete.className = 'btn btn-outline-danger btn-sm';
            btnDelete.textContent = 'Supprimer';
            btnDelete.addEventListener('click', (function(i) {
                return function() { deleteDevis(i); };
            })(index));
            tdAction.appendChild(btnDelete);
            tr.appendChild(tdAction);

            tableBody.appendChild(tr);
        }

        function renderDataRows() {
            var rows = tableBody.querySelectorAll('tr:not(#inputRow)');
            for (var i = 0; i < rows.length; i++) {
                rows[i].remove();
            }
            var arr = getDevisArray();
            for (var j = 0; j < arr.length; j++) {
                addDevisToTable(arr[j], j);
            }
        }

        function addDevis() {
            // Ajoute directement, sans validation
            var devis = {
                libelle: inputLibelle.value.trim(),
                qte: parseFloat(inputQte.value),
                Pu: parseFloat(inputPu.value)
            };
            var arr = getDevisArray();
            arr.push(devis);
            saveDevisArray(arr);
            addDevisToTable(devis, arr.length - 1);
            inputLibelle.value = '';
            inputQte.value = '';
            inputPu.value = '';
        }

        // Validation complète uniquement au clic sur Enregistrer
        function validateAllLines(details) {
            var errors = [];
            for (var i = 0; i < details.length; i++) {
                var ligne = details[i];
                var lineNum = i + 1;
                if (!ligne.libelle || ligne.libelle.trim() === '') {
                    errors.push("Ligne " + lineNum + " : libellé manquant.");
                }
                if (isNaN(ligne.qte) || ligne.qte <= 0) {
                    errors.push("Ligne " + lineNum + " : quantité invalide (doit être > 0).");
                }
                if (isNaN(ligne.Pu) || ligne.Pu <= 0) {
                    errors.push("Ligne " + lineNum + " : prix unitaire invalide (doit être > 0).");
                }
            }
            return errors;
        }

        function showGlobalErrors(errors) {
            if (!errors || errors.length === 0) {
                globalErrorDiv.style.display = 'none';
                globalErrorDiv.innerHTML = '';
                return;
            }
            var html = '<div class="error-list"><strong>Erreurs détectées :</strong><ul>';
            for (var i = 0; i < errors.length; i++) {
                html += '<li>' + errors[i] + '</li>';
            }
            html += '</ul></div>';
            globalErrorDiv.innerHTML = html;
            globalErrorDiv.style.display = 'block';
        }

        async function searchDemandeByRef(val) {
            if (!val) return;
            var url = contextPath + "/demande/byref?" + new URLSearchParams("ref=" + val);
            try {
                var res = await fetch(url);
                if (!res.ok) throw new Error("Erreur réseau");
                return await res.json();
            } catch (e) { console.error(e); }
        }

        async function refreshDemande(val) {
            var demande = await searchDemandeByRef(val);
            if (demande) {
                form.elements['client'].value = demande.client.nom;
                form.elements['lieu'].value = demande.commune.nom;
            }
        }

        demandeRefSelect.addEventListener("change", function(e) {
            var val = e.target.value;
            if (val) refreshDemande(val);
        });

        var getDevisArray = function() {
            return JSON.parse(sessionStorage.getItem("devisArr") || "[]");
        };
        var saveDevisArray = function(arr) {
            sessionStorage.setItem("devisArr", JSON.stringify(arr));
        };

        function deleteDevis(index) {
            var arr = getDevisArray();
            arr.splice(index, 1);
            saveDevisArray(arr);
            renderDataRows();
        }

        document.getElementById('saveDevisBtn').addEventListener('click', async function() {
            var details = getDevisArray();
            var typeVal = form.elements['type'].value;
            var daty = form.elements['createAt'].value;

            // Validation de la demande
            if (!demandeRefSelect.value) {
                alert("Veuillez sélectionner une demande.");
                return;
            }

            if(daty === null){
                alert("Veuille donner la valeur a la date");
                return;
            }

            // Validation des lignes (seule validation)
            var errors = validateAllLines(details);
            if (errors.length > 0) {
                showGlobalErrors(errors);
                return;
            }

            if (details.length === 0) {
                alert("Ajoutez au moins une ligne de détail.");
                return;
            }

            var observation = prompt("Observation (optionnel) :") || "";
            var payload = {
                dmd: { reference: demandeRefSelect.value },
                typeDevis: { id: typeVal },
                observation: observation,
                details: details,
                createAt: daty
            };

            try {
                var res = await fetch(contextPath + '/devis/form', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                if (res.ok) {
                    alert('Devis enregistré !');
                    sessionStorage.removeItem('devisArr');
                    location.reload();
                } else {
                    var errText = await res.text();
                    alert('Erreur serveur : ' + errText);
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