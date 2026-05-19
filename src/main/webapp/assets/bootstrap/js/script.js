async function searchDemandeByRef(val) {
    if (!val) return;
    const url = contextPath + "/demande/byref?" + new URLSearchParams("ref=" + val);
    try {
        const res = await fetch(url);
        if (!res.ok) throw new Error("Erreur réseau");
        const demande = await res.json();
        return demande;
    } catch (e) { console.error(e); }
}

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
        console.error(response);
    } catch (error) {
        console.error(error);
    }
}