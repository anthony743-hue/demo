<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <div class="container">
            <div class="row d-fkex justify-content-center">
                <div class="col-md-6">
                    <div class="card" id="boxMsg">
                        <div class="card-body">
                            <div class="mb-3 text-bold">StatusDemande</div>
                            <div class="col-12">
                                <label for="type" class="form-label fw-semibold">Demande</label>
                                <select name="demande" id="demandeRef" class="form-select">
                                    <option value="" selected>Référence de la demande...</option>
                                    <c:if test="${not empty listeDemande}">
                                        <c:forEach items="${listeDemande}" var="item">
                                            <option value="${item.reference}">${item.reference}</option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                            <form id="formTemp">
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label for="date" class="form-label fw-semibold">Date</label>
                                        <input type="datetime-local" name="daty" class="form-control" id="daty">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lieu" class="form-label fw-semibold">Observation</label>
                                        <input type="text" name="obs" class="form-control" id="obs" placeholder="****">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="type" class="form-label fw-semibold">Statut</label>
                                        <select name="status" id="status" class="form-select">
                                            <option value="">Choisir un StatusDemande</option>

                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Modifier le Status Demande</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
                    // const seconds = String(d.getSeconds()).padStart(2, '0');

                    // Construction de la valeur
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
                    success = success !== false; // true par défaut
                    var msgType = success ? 'success' : 'danger';

                    // Construction de la chaîne HTML par concaténation (compatible ES5)
                    var html = '<div class="alert alert-' + msgType + ' alert-dismissible fade show" role="alert" id="msgCard">' +
                        msg +
                        '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                        '</div>';

                    var ancien = boxMsg.querySelector('#msgCard');
                    if (ancien) ancien.remove();    // ou boxMsg.removeChild(ancien)

                    // Insertion
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