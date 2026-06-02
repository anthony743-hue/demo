document.addEventListener("DOMContentLoaded", () => {
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    async function getDemande(e){
        let demande = await searchDemandeByRef(e.target.value.trim());
        if(demande !== null && demande !== undefined){
            let msg = "L'objet parsable";
            sessionStorage.setItem("demande", JSON.stringify(demande));
        }
    }
    dmd.addEventListener("input", e => getDemande(e));
    
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