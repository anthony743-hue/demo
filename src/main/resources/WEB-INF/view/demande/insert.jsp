<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="progress" id="progressBar" role="progressbar" aria-label="Basic example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                <div class="progress-bar" style="width: 0%"></div>
            </div>
        </div>
        <div class="col-md-8" id="infoPerso">
            <form id="formPerso">
                <div class="form-floating mb-3">
                    <input type="text" name="nomClient" class="form-control" id="floatingInput" placeholder="Jean Richard">
                    <label for="floatingInput">Nom du Client</label>
                </div>
                <div class="form-floating mb-3">
                    <select name="status" class="form-select" id="floatingSelect" placeholder="Selectionner un status">
                        <c:forEach items="${listeStatus}" var="item" >
                            <option value="${item.id}">${item.designation}</option>
                        </c:forEach> 
                    </select>
                    <label for="floatingSelect">Status</label>
                </div>
                <button type="submit" id="nextStep">Suivant</button>
            </form>
        </div>
        <div class="col-md-8" id="infoLocal" style="display: none;">
            <form id="FormLocal">
                 <div class="form-floating mb-3">
                    <input type="text" name="region" class="form-control" id="floatingInput" placeholder="Jean Richard">
                    <label for="floatingInput">Region</label>
                </div>
                 <div class="form-floating mb-3">
                    <input type="text" name="district" class="form-control" id="floatingInput" placeholder="Jean Richard">
                    <label for="floatingInput">District</label>
                </div>
                 <div class="form-floating mb-3">
                    <input type="text" name="commune" class="form-control" id="floatingInput" placeholder="Jean Richard">
                    <label for="floatingInput">Commune</label>
                </div>
                 <div class="form-floating mb-3">
                    <input type="text" name="fokontany" class="form-control" id="floatingInput" placeholder="Jean Richard">
                    <label for="floatingInput">Fokontany</label>
                </div>
                <button type="submit" id="sbtButton" >Enregistrer la demande</button>
            </form>
        </div>
    </div>
    <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>