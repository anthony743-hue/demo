<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des devis</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
    <style>
        /* Reprise exacte du style des demandes */
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }
        .table-card {
            overflow: hidden;
            border: 1px solid #black;
        }
        .table-bordered th, 
        .table-bordered td {
            border-color: #e9ecef;
        }
        thead th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #1e2a3e;
            border-bottom-width: 1px;
        }
        .btn-light {
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        .btn-light:hover {
            background-color: #e9ecef;
        }
        .btn-sm {
            border-radius: 0.375rem;
        }
        .text-end {
            text-align: right;
        }
        .container.p-4 {
            max-width: 1400px;
        }
    </style>
</head>
<body>

<div class="container p-4">
    <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3 mb-4">
        <div>
            <h1>Liste des devis</h1>
        </div>
        <a class="btn btn-light text-success fw-semibold" href="<c:url value='/devis/form' />">
            Ajouter un devis
        </a>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-bordered align-middle mb-0">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th class="" scope="col">Date de création</th>
                        <th scope="col">Observation</th>
                        <th class="text-center text-end" scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty liste_devis}">
                            <c:forEach items="${liste_devis}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty item.createAt}">
                                                ${item.createAt}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty item.observation}">
                                                ${item.observation}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Aucune observation</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <div class="actions justify-content-center w-100">
                                            <a class="btn btn-sm btn-outline-primary"
                                               href="<c:url value='/devis/detail?id=${item.id}' />">
                                                Voir plus
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="text-center py-4 text-muted">
                                    Aucun devis n'est disponible pour le moment.
                                 </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>