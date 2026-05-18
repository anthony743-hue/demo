<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des demandes</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(180deg, #f4efe5 0%, #eef3ef 100%);
            color: #22352e;
        }

        .page-shell {
            padding: 32px 16px 48px;
        }

        .page-header {
            max-width: 1100px;
            margin: 0 auto 24px;
            background: linear-gradient(135deg, #1f4b3f 0%, #274f69 100%);
            color: #fff;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 20px 50px rgba(31, 75, 63, 0.16);
        }

        .page-header h1 {
            margin: 0 0 8px;
            font-size: 2rem;
            font-weight: 700;
        }

        .page-header p {
            margin: 0;
            color: rgba(255, 255, 255, 0.82);
        }

        .table-card {
            max-width: 1100px;
            margin: 0 auto;
            background: #fcfbf8;
            border-radius: 24px;
            box-shadow: 0 24px 60px rgba(36, 53, 45, 0.1);
            overflow: hidden;
        }

        .table thead th {
            background: #edf3ef;
            color: #325044;
            border-bottom: 0;
            white-space: nowrap;
        }

        .badge-status {
            background: #e0efe7;
            color: #1f6b52;
            font-weight: 600;
            border-radius: 999px;
            padding: 8px 12px;
        }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .empty-state {
            padding: 48px 24px;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="page-shell">
        <div class="page-header d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
            <div>
                <h1>Liste des demandes</h1>
                <p>Consultez, modifiez ou supprimez les demandes existantes depuis cette page.</p>
            </div>
            <a class="btn btn-light text-success fw-semibold" href="<c:url value='/demande/add' />">
                Ajouter une demande
            </a>
        </div>

        <div class="table-card">
            <c:choose>
                <c:when test="${not empty listDemande}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="px-4 py-3">ID</th>
                                    <th class="px-4 py-3">Nom du client</th>
                                    <th class="px-4 py-3">Statut</th>
                                    <th class="px-4 py-3">Localisation</th>
                                    <th class="px-4 py-3 text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listDemande}" var="item">
                                    <tr>
                                        <td class="px-4 py-3">${item.id}</td>
                                        <td class="px-4 py-3 fw-semibold">${item.client.nom}</td>
                                        <td class="px-4 py-3">
                                            <span class="badge-status">${item.status.designation}</span>
                                        </td>
                                        <td class="px-4 py-3">${item.localisation}</td>
                                        <td class="px-4 py-3 text-end">
                                            <div class="actions justify-content-end">
                                                <a class="btn btn-sm btn-outline-primary" href="<c:url value='/demande/update?id=${item.id}' />">
                                                    Modifier
                                                </a>
                                                <a class="btn btn-sm btn-outline-danger" href="<c:url value='/demande/remove?id=${item.id}' />">
                                                    Supprimer
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <p class="mb-3">Aucune demande n'est disponible pour le moment.</p>
                        <a class="btn btn-success" href="<c:url value='/demande/add' />">Creer la premiere demande</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
