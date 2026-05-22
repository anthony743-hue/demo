document.addEventListener("DOMContentLoaded", () => {
    const dmd = document.getElementById('demandeInput');
    const form = document.getElementById('formTemp');
    const obsInput = document.getElementById('obs');
    const dtInput = document.getElementById('daty');
    const selectType = document.getElementById("status");

    dmd.addEventListener("input", e => {
        const lsStatusDmd = searchStatusDmdByRef(e.target.value.trim());
        if(lsStatusDmd){
            sessionStorage.setItem("lsStatusDmd", JSON.stringify(response));
        }
    });

    selectType.addEventListener("change", e => {
        const val = e.target.value;
        if(val){
            const lsStatusDmd = JSON.parse(sessionStorage.getItem("lsStatusDmd") || "[]");
            for(const a of lsStatusDmd){
                if( a.status.id == val ){
                    sessionStorage.setItem("statusDmdTarget", JSON.stringify(a));
                    form.elements['daty'].value = a.daty;
                    form.elements['observation'].value = a.observation; 
                    break;
                }
            }
        }
    });

    function changeDmdFieldValue(name_field, val){
        const std = JSON.parse(sessionStorage.getItem("statusDmdTarget") || "null");
        if(std){
            std[name_field] = val;
            sessionStorage.setItem("statusDmdTarget", JSON.stringify(std));
        }
    }

    async function saveChange(){
        const std = sessionStorage.getItem("statusDmdTarget") || "null";
        const url = contextPath + "/statusdmd/add";
        try {
            const request = await fetch(url,{
                method : 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: std
            });
            if(!request.ok) throw new Error("Erreur reseau");
            const response = await request.json();
            alert(response);
        } catch (error) {
            alert(error);
        }
    }

    obsInput.addEventListener("input", e => changeDmdFieldValue("observation",e.target.value));
    dtInput.addEventListener("input", e => changeDmdFieldValue("daty",e.target.value));
});