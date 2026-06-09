<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* --- Styles scoupés à cette page --- */
    .update-status-container .anthropic-card {
        background-color: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        overflow: hidden;
        margin-top: 24px;
    }

    .update-status-container .anthropic-card .card-header {
        border-bottom: 1px solid #f3f4f6;
        padding: 24px 28px;
        background-color: #ffffff;
    }

    .update-status-container .anthropic-card .card-body {
        padding: 28px;
    }

    .update-status-container h1 {
        color: #111827;
        font-weight: 600;
        font-size: 1.25rem;
        letter-spacing: -0.02em;
        margin: 0;
    }

    /* Étapes visuelles pour guider l'utilisateur */
    .step-label {
        color: #6b7280;
        font-size: 0.75rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 8px;
        display: block;
    }

    .selector-group {
        background-color: #f9fafb;
        padding: 16px 20px;
        border-radius: 8px;
        margin-bottom: 24px;
        border: 1px solid #e5e7eb;
    }

    /* Champs de formulaire */
    .update-status-container .form-label {
        color: #374151;
        font-weight: 500;
        font-size: 0.875rem;
        margin-bottom: 6px;
    }

    .update-status-container .form-control, 
    .update-status-container .form-select {
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 0.9rem;
        color: #111827;
        transition: all 0.15s ease;
        background-color: #ffffff;
    }

    .update-status-container .form-control:focus, 
    .update-status-container .form-select:focus {
        border-color: #93c5fd;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        outline: none;
    }

    /* Surcharge des alertes générées par le Javascript */
    .update-status-container .alert {
        border-radius: 8px;
        padding: 12px 16px;
        font-size: 0.875rem;
        font-weight: 450;
        border: 1px solid;
        margin-top: 20px;
        margin-bottom: 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .update-status-container .alert-success {
        background-color: #f0fdf4;
        color: #166534;
        border-color: #bbf7d0;
    }
    .update-status-container .alert-danger {
        background-color: #fef2f2;
        color: #991b1b;
        border-color: #fecaca;
    }
    .update-status-container .btn-close {
        padding: 0.5rem;
        opacity: 0.5;
    }

    /* Bouton principal */
    .update-status-container .btn-primary-custom {
        background-color: #2563eb;
        border: none;
        border-radius: 8px;
        padding: 11px 20px;
        font-weight: 500;
        color: #ffffff;
        transition: background-color 0.15s ease;
        margin-top: 8px;
    }
    .update-status-container .btn-primary-custom:hover {
        background-color: #1d4ed8;
        color: #ffffff;
    }
</style>

<div class="container update-status-container">
    <div class="row d-flex justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="card anthropic-card" id="boxMsg">
                <div class="card-header">
                    <h1>Modification de statut</h1>
                </div>
                <div class="card-body">
                    
                    <!-- Étape 1 : Sélection de la demande (en dehors du formTemp comme dans la logique initiale) -->
                    <div class="mb-3">
                        <span class="step-label">Étape 1 : Sélectionner la demande</span>
                        <select name="demande" id="demandeRef" class="form-select">
                            <option value="" selected>Référence de la demande...</option>
                            <c:if test="${not empty listeDemande}">
                                <c:forEach items="${listeDemande}" var="item">
                                    <option value="${item.reference}">${item.reference}</option>
                                </c:forEach>
                            </c:if>
                        </select>
                    </div>

                    <!-- Étape 2 : Modification (le formulaire géré par JS) -->
                    <span class="step-label">Étape 2 : Modifier les informations</span>
                    
                    <form id="formTemp">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="daty" class="form-label">Date</label>
                                <input type="datetime-local" name="daty" class="form-control" id="daty">
                            </div>
                            <div class="col-md-6">
                                <label for="obs" class="form-label">Observation</label>
                                <input type="text" name="obs" class="form-control" id="obs" placeholder="Observation...">
                            </div>
                            <div class="col-md-6">
                                <label for="status" class="form-label">Statut</label>
                                <select name="status" id="status" class="form-select">
                                    <option value="">Choisir un StatusDemande</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary-custom w-100">Enregistrer la modification</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- SCRIPT INTACT -->
<script defer>
    document.addEventListener("DOMContentLoaded", () => {
        const demandeRefSelect = document.getElementById('demandeRef');

        const form = document.getElementById('formTemp');
        const obsInput = document.getElementById('obs');
        const dtInput = document.getElementById('daty');
        const selectType = document.getElementById("status");
        const boxMsg = document.getElementById('boxMsg');

        async function getLsStatus(ref) {
            const lsStatusDmd = await searchStatusDmdByRef(ref);
            sessionStorage.clear();
            if (lsStatusDmd.success) {
                const list = lsStatusDmd.data;
                selectType.innerHTML = "";
                const deFaultOpt = document.createElement("option");
                deFaultOpt.text = "Choisir un StatusDemande";
                deFaultOpt.value = "";
                selectType.appendChild(deFaultOpt);
                sessionStorage.setItem("lsStatusDmd", JSON.stringify(list));
                let option;
                let a;
                for (let i = 0; i < list.length; i++) {
                    a = list[i];
                    option = document.createElement("option");
                    option.value = i;
                    option.text = a.status.designation;
                    selectType.appendChild(option);
                }
            }
        }

        function formatDate(dt) {
            const d = new Date(dt);

            const year = d.getFullYear();
            const month = String(d.getMonth() + 1).padStart(2, '0');
            const day = String(d.getDate()).padStart(2, '0');
            const hours = String(d.getHours()).padStart(2, '0');
            const minutes = String(d.getMinutes()).padStart(2, '0');

            const value = year + "-" + month + "-" + day + "T" + hours + ":" + minutes;
            console.log(year + " | " + month + " | " + day + " | " + hours + " || " + value);
            return value;
        }

        demandeRefSelect.addEventListener("change", e => {
            const val = e.target.value;
            if (val !== null && val.trim() !== '') {
                getLsStatus(val);
            }
        });

        selectType.addEventListener("change", e => {
            const val = e.target.value;
            refreshStd(val);
        });

        function refreshStd(val){
            if (val !== null && val !== '') {
                const idx = parseInt(val);
                const lsStatusDmd = JSON.parse(sessionStorage.getItem("lsStatusDmd") || "[]");
                if (idx >= 0 && idx < lsStatusDmd.length) {
                    const a = lsStatusDmd[idx];
                    let temp = formatDate(a.daty);
                    form.daty.value = temp;
                    form.obs.value = a.observation;
                    sessionStorage.removeItem("statusDmdTarget");
                    sessionStorage.setItem("statusDmdTarget", JSON.stringify(a));
                }
            }
        }

        function changeDmdFieldValue(name_field, val) {
            const std = JSON.parse(sessionStorage.getItem("statusDmdTarget"));
            if (std !== null && std !== undefined) {
                std[name_field] = val;
                sessionStorage.removeItem("statusDmdTarget");
                sessionStorage.setItem("statusDmdTarget", JSON.stringify(std));
            }
        }

        async function saveChange() {
            let st = JSON.parse(sessionStorage.getItem("statusDmdTarget"));
            const url = contextPath + "/statusdmd/update";
            if (st === null || st === undefined) {
                alert("Il faut que le StatusDemande existe");
                return;
            }
            try {
                const request = await fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(st)
                });
                if (!request.ok) throw new Error(request.body);
                const response = await request.json();
                if (response.success) {
                    createToastMsg("Modification Reussi");
                    refreshStd(selectType.value);
                } else {
                    throw new Error(response.message);
                }
            } catch (error) {
                createToastMsg(error, false);
            }
        }

        function createToastMsg(msg, success = true) {
            success = success !== false; 
            var msgType = success ? 'success' : 'danger';

            var html = '<div class="alert alert-' + msgType + ' alert-dismissible fade show" role="alert" id="msgCard">' +
                msg +
                '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                '</div>';

            var ancien = boxMsg.querySelector('#msgCard');
            if (ancien) ancien.remove();    

            // Le JS injecte l'alerte dans boxMsg. Grâce au CSS, elle prendra le style pastel automatiquement
            boxMsg.insertAdjacentHTML('afterbegin', html);
        }

        obsInput.addEventListener("input", e => changeDmdFieldValue("observation", e.target.value));
        dtInput.addEventListener("input", e => changeDmdFieldValue("daty", e.target.value));
        form.addEventListener("submit", e => {
            e.preventDefault();
            saveChange();
        });
    });
</script>