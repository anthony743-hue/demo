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
        /* Fond de page cohérent avec le reste de l'application */
        body {
            background-color: #f9fafb;
            min-height: 100vh;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        /* Conteneur principal */
        .container.p-4 {
            max-width: 1400px;
            padding-top: 2.5rem !important;
            padding-bottom: 2.5rem !important;
        }

        /* Typographie de l'en-tête */
        .list-page-container h1 {
            color: #111827;
            font-weight: 600;
            font-size: 1.5rem;
            letter-spacing: -0.02em;
            margin: 0;
        }

        /* Bouton d'ajout principal */
        .btn-add-primary {
            background-color: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            padding: 9px 18px;
            font-weight: 500;
            font-size: 0.875rem;
            transition: background-color 0.15s ease;
            text-decoration: none;
        }
        .btn-add-primary:hover {
            background-color: #1d4ed8;
            color: #ffffff;
        }

        /* Carte de la table */
        .table-card {
            background-color: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-top: 24px;
        }

        /* Tableau épuré (sans bordures classiques) */
        .table-clean {
            margin-bottom: 0;
            border-collapse: collapse;
        }

        .table-clean thead th {
            background-color: #f9fafb;
            color: #6b7280;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-clean tbody td {
            color: #374151;
            font-size: 0.9rem;
            padding: 16px 20px;
            border-bottom: 1px solid #f3f4f6;
            vertical-align: middle;
        }

        .table-clean tbody tr:last-child td {
            border-bottom: none;
        }

        .table-clean tbody tr:hover td {
            background-color: #f9fafb;
        }

        /* Bouton d'action subtil */
        .btn-action {
            font-size: 0.8rem;
            font-weight: 500;
            padding: 6px 14px;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
            background-color: #ffffff;
            color: #6b7280;
            text-decoration: none;
            transition: all 0.15s ease;
        }

        .btn-action:hover {
            background-color: #eff6ff;
            color: #2563eb;
            border-color: #bfdbfe;
        }

        /* Style pour l'état vide */
        .empty-state {
            padding: 48px 20px;
            color: #9ca3af;
            font-size: 0.9rem;
        }

        /* Conteneur des boutons d'action */
        .actions {
            display: flex;
            gap: 8px;
            justify-content: center;
        }
    </style>
</head>
<body>

<div class="container p-4 list-page-container">
    <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
        <div>
            <h1>Liste des devis</h1>
        </div>
        <a class="btn btn-add-primary" href="<c:url value='/devis/form' />">
            Ajouter un devis
        </a>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-clean align-middle mb-0">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Date de création</th>
                        <th scope="col">Observation</th>
                        <th class="text-center" scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty liste_devis}">
                            <c:forEach items="${liste_devis}" var="item">
                                <tr>
                                    <td class="fw-medium">${item.id}</td>
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
                                                <span class="text-muted fst-italic">Aucune observation</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <a class="btn-action"
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
                                <td colspan="4" class="empty-state text-center">
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