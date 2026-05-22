document.addEventListener("DOMContentLoaded", () => {
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    const selectType = document.getElementById("status");
    dmd.addEventListener("input", e => {
        const demande = searchDemandeByRef(e.target.value.trim());
        if(demande){
            sessionStorage.setItem("demande", JSON.stringify(demande));
        }
    });
    
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