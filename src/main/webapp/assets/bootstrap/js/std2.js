document.addEventListener("DOMContentLoaded", () => {
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    const obsInput = document.getElementById('obs');
    const dtInput = document.getElementById('daty');
    const selectType = document.getElementById("status");

    async function getLsStatus(e) {
        const lsStatusDmd = await searchStatusDmdByRef(e.target.value.trim());
        sessionStorage.clear();
        if (lsStatusDmd) {
            selectType.innerHTML = "";
            const deFaultOpt = document.createElement("option");
            deFaultOpt.text = "Choisir un StatusDemande";
            deFaultOpt.value = "";
            selectType.appendChild(deFaultOpt);
            sessionStorage.setItem("lsStatusDmd", JSON.stringify(lsStatusDmd));
            let option;
            let a;
            for (let i = 0; i < lsStatusDmd.length; i++) {
                a = lsStatusDmd[i];
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
        const seconds = String(d.getSeconds()).padStart(2, '0');

        // Construction de la valeur
        const value = `${year}-${month}-${day}T${hours}:${minutes}`;
        return value;
    }

    dmd.addEventListener("input", e => {
        getLsStatus(e);
    });

    selectType.addEventListener("change", e => {
        const val = parseInt(e.target.value);
        const lsStatusDmd = JSON.parse(sessionStorage.getItem("lsStatusDmd") || "[]");
        if (val >= 0 && val < lsStatusDmd.length) {
            const a = lsStatusDmd[val];
            form.elements['daty'].value = formatDate(a.daty);
            form.elements['obs'].value = a.observation;
            sessionStorage.setItem("statusDmdTarget", JSON.stringify(a));
        }
    });

    function changeDmdFieldValue(name_field, val) {
        const std = JSON.parse(sessionStorage.getItem("statusDmdTarget"));
        if (std) {
            std[name_field] = val;
            sessionStorage.setItem("statusDmdTarget", JSON.stringify(std));
        }
    }

    async function saveChange() {
        let std = JSON.parse(sessionStorage.getItem("statusDmdTarget") || "null");
        const url = contextPath + "/statusdmd/update";
        if (std === null || std === undefined) {
            alert("Il faut que le StatusDemande existe");
            return;
        }
        try {
            const request = await fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(std)
            });
            if (!request.ok) throw new Error(request.body);
            const response = await request.json();
            alert("RES : " + response);
        } catch (error) {
            alert("ERREUR : " + error);
        }
    }

    obsInput.addEventListener("input", e => changeDmdFieldValue("observation", e.target.value));
    dtInput.addEventListener("input", e => changeDmdFieldValue("daty", e.target.value));
    form.addEventListener("submit", e => {
        e.preventDefault();
        saveChange();
    });
});