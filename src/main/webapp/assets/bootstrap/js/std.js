document.addEventListener("DOMContentLoaded", () => {
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    const selectType = document.getElementById("status");
    const contextPath = "http://localhost:8080";

    async function searchDemandeByRef(val) {
        if (!val) return;
        const url = contextPath + "/demande/byref?" + new URLSearchParams("ref=" + val);
        try {
            const res = await fetch(url);
            if (!res.ok) throw new Error("Erreur réseau");
            const demande = await res.json();
            if (demande) {
                console.log(demande);
                sessionStorage.setItem("demande", JSON.stringify(demande));
            }
        } catch (e) { console.error(e); }
    }
    dmd.addEventListener("input", e => searchDemandeByRef(e.target.value.trim()));

    async function sendStd(param) {
        const url = contextPath + "/statusdmd/add";
        try {
            const res = await fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(param)
            });
            if (!res.ok) throw new Error("Erreur reseau");
            const response = await res.json();
            console.log(response);
        } catch (error) {
            console.error(error);
        }
    }

    form.addEventListener("submit", e => {
        e.preventDefault();
        const demande = JSON.parse(sessionStorage.getItem("demande") || "null");
        if (!demande) {
            alert("Il faut que la demande existe");
            return;
        }

        const status = form.elements['status'].value;
        const daty = form.elements['createAt'].value;
        const obs = form.elements['obs'].value;

        const std = {
            demande: demande,
            status: {
                id: status
            },
            daty: daty,
            observation: obs
        }
        sendStd(std);
    });
});