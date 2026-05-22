const contextPath = "http://localhost:8080";

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

async function searchStatusDmdByRef(params) {
    if(!params) throw new Error("Le parametre ne doit pas etre vide");
    const url = contextPath + "/statusdm/byref?" + new URLSearchParams("ref="+params);
    try {
        const request = await fetch(url);
        if(!request.ok) throw new Error("Erreur reseau");
        const response = await res.json();
        return response;
    } catch (error) {
        console.error(error);   
    }
}