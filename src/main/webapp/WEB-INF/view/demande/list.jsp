<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Styles spécifiques pour la liste (à mettre idéalement dans le head principal) -->
<style>
    /* Conteneur principal pour le fond gris */
    .list-page-container {
        background-color: #f9fafb;
        min-height: 100vh;
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
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }
    .btn-add-primary:hover {
        background-color: #1d4ed8;
        color: #ffffff;
    }

    /* Tableau épuré */
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
        border-bottom: 1px solid #f3f4f6; /* Ligne de séparation très fine */
        vertical-align: middle;
    }

    /* Suppression de la dernière bordure de la dernière ligne */
    .table-clean tbody tr:last-child td {
        border-bottom: none;
    }

    /* Effet de survol sur les lignes */
    .table-clean tbody tr:hover td {
        background-color: #f9fafb;
    }

    /* Pastille/Badge pour le statut */
    .status-pill {
        background-color: #eff6ff;
        color: #2563eb;
        padding: 5px 12px;
        border-radius: 9999px;
        font-size: 0.8rem;
        font-weight: 500;
        display: inline-block;
    }

    /* Boutons d'actions subtils */
    .btn-action {
        font-size: 0.8rem;
        font-weight: 500;
        padding: 6px 12px;
        border-radius: 6px;
        border: 1px solid #e5e7eb;
        background-color: #ffffff;
        color: #6b7280;
        text-decoration: none;
        transition: all 0.15s ease;
    }

    .btn-action-edit:hover {
        background-color: #eff6ff;
        color: #2563eb;
        border-color: #bfdbfe;
    }

    .btn-action-delete:hover {
        background-color: #fef2f2;
        color: #dc2626;
        border-color: #fecaca;
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

<!-- Contenu HTML -->
<div class="container py-5 list-page-container">
    <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-center gap-3">
        <div>
            <h1>Liste des demandes</h1>
        </div>
        <a class="btn-add-primary" href="<c:url value='/demande/add' />">
            <i class="bi bi-plus-lg"></i> Ajouter une demande
        </a>
    </div>

    <div class="table-card">
        <div class="table-responsive">
            <table class="table table-clean align-middle mb-0">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Nom du client</th>
                        <th scope="col">Statut</th>
                        <th scope="col">Localisation</th>
                        <th class="text-center" scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listDemande}">
                            <c:forEach items="${listDemande}" var="item">
                                <tr>
                                    <td>${item.id}</td>
                                    <td class="fw-semibold">${item.client.nom}</td>
                                    <td>
                                        <span class="status-pill">${item.status.designation}</span>
                                    </td>
                                    <td>${item.localisation}</td>
                                    <td>
                                        <div class="actions">
                                            <a class="btn-action btn-action-edit"
                                                href="<c:url value='/demande/update?id=${item.id}' />">
                                                Modifier
                                            </a>
                                            <a class="btn-action btn-action-delete"
                                                href="<c:url value='/demande/remove?id=${item.id}' />">
                                                Supprimer
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty-state text-center">
                                    Aucune demande n'est disponible pour le moment.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>