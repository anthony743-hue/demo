<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${action}</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">
                <div class="card shadow-sm">
                    <div class="card-header bg-white">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
                            <div>
                                <h1 class="h4 mb-1">${action}</h1>
                                <p class="text-muted mb-0">Formulaire simple pour creer ou modifier une demande.</p>
                            </div>
                            <a class="btn btn-outline-secondary" href="<c:url value='/demande/list' />">Voir la liste</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="<c:url value='/demande/${path}' />" method="post">
                            <c:if test="${not empty dmd}">
                                <input type="hidden" name="id" value="${dmd.id}">
                            </c:if>

                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label" for="client">Client</label>
                                    <select name="client" id="client" class="form-select" required>
                                        <option value="">Choisir un client</option>
                                        <c:forEach items="${listeClient}" var="item">
                                            <option
                                                value="${item.id}"
                                                <c:if test="${not empty dmd and not empty dmd.client and dmd.client.id == item.id}">selected</c:if>>
                                                ${item.nom} - ${item.contact}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label" for="status">Statut</label>
                                    <select name="status" id="status" class="form-select" required>
                                        <option value="">Choisir un statut</option>
                                        <c:forEach items="${listeStatus}" var="item">
                                            <option
                                                value="${item.id}"
                                                <c:if test="${not empty dmd and not empty dmd.status and dmd.status.id == item.id}">selected</c:if>>
                                                ${item.designation}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label" for="commune">Commune</label>
                                    <select name="commune" id="commune" class="form-select" required>
                                        <option value="">Choisir une commune</option>
                                        <c:forEach items="${listeCommune}" var="item">
                                            <option
                                                value="${item.id}"
                                                <c:if test="${not empty dmd and not empty dmd.commune and dmd.commune.id == item.id}">selected</c:if>>
                                                ${item.nom}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6 ">
                                    <div class="form-floating mb-3">
                                        <label for="reference">Reference</label>
<input type="text" 
       name="reference" 
       id="reference" 
       class="form-control" 
       value="${not empty dmd and not empty dmd.reference ? dmd.reference : ''}">                                    </div>
                                </div>

                                <c:if test="${not empty dmd and not empty dmd.commune}">
                                    <div class="col-12">
                                        <div class="alert alert-secondary mb-0">
                                            Localisation actuelle: ${dmd.localisation}
                                        </div>
                                    </div>
                                </c:if>

                                <div class="col-12 d-flex flex-column flex-sm-row gap-2 pt-2">
                                    <button type="submit" class="btn btn-primary">
                                        ${action}
                                    </button>
                                    <a class="btn btn-outline-secondary" href="<c:url value='/demande/add' />">
                                        Nouvelle saisie
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
