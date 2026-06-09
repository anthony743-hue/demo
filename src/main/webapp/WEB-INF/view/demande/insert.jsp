<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Styles spécifiques pour le formulaire (à mettre idéalement dans le head principal) -->
<style>
    /* Carte conteneur */
    .anthropic-card {
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        overflow: hidden;
        background-color: #ffffff;
    }
    
    .anthropic-card .card-header {
        border-bottom: 1px solid #f3f4f6;
        padding: 24px 28px;
        background-color: #ffffff;
    }

    .anthropic-card .card-body {
        padding: 28px;
    }

    /* Typographie */
    .anthropic-card h1 {
        color: #111827;
        font-weight: 600;
        letter-spacing: -0.02em;
        margin-bottom: 4px;
    }
    
    .anthropic-card .text-muted {
        color: #6b7280 !important;
        font-size: 0.9rem;
    }

    /* Champs de formulaire */
    .anthropic-card .form-label {
        color: #374151;
        font-weight: 500;
        font-size: 0.875rem;
        margin-bottom: 6px;
    }

    .anthropic-card .form-control, 
    .anthropic-card .form-select {
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 0.9rem;
        color: #111827;
        transition: all 0.15s ease;
        background-color: #ffffff;
    }

    .anthropic-card .form-control:focus, 
    .anthropic-card .form-select:focus {
        border-color: #93c5fd;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        outline: none;
    }

    /* Bandeau d'information (remplace l'alert bootstrap classique) */
    .info-banner {
        background-color: #f0f9ff;
        border: 1px solid #bae6fd;
        border-radius: 8px;
        padding: 12px 16px;
        color: #0369a1;
        font-size: 0.875rem;
        font-weight: 450;
        display: flex;
        align-items: center;
    }

    /* Boutons */
    .btn-primary-custom {
        background-color: #2563eb;
        border: none;
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: 500;
        color: #ffffff;
        transition: background-color 0.15s ease;
    }
    .btn-primary-custom:hover {
        background-color: #1d4ed8;
        color: #ffffff;
    }

    .btn-ghost {
        background-color: transparent;
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 10px 20px;
        color: #374151;
        font-weight: 450;
        transition: all 0.15s ease;
    }
    .btn-ghost:hover {
        background-color: #f9fafb;
        border-color: #9ca3af;
        color: #111827;
    }
    
    /* Bouton secondaire tout petit dans le header */
    .btn-subtle-link {
        color: #6b7280;
        font-size: 0.875rem;
        font-weight: 500;
        text-decoration: none;
        padding: 6px 12px;
        border-radius: 6px;
        transition: all 0.15s ease;
    }
    .btn-subtle-link:hover {
        background-color: #f3f4f6;
        color: #111827;
    }
</style>

<!-- Contenu HTML de la page -->
<div class="container py-5" style="background-color: #f9fafb; min-height: 100vh;">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            <div class="card anthropic-card">
                <div class="card-header">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2">
                        <div>
                            <h1 class="h4 mb-1">${action}</h1>
                        </div>
                        <a class="btn-subtle-link" href="<c:url value='/demande/list' />">
                            <i class="bi bi-list-ul me-1"></i>Voir la liste
                        </a>
                    </div>
                </div>
                
                <div class="card-body">
                    <form action="<c:url value='/demande/${path}' />" method="post">
                        <c:if test="${not empty dmd}">
                            <input type="hidden" name="id" value="${dmd.id}">
                        </c:if>

                        <div class="row g-3">
                            <!-- Remplacement de l'alert standard par une bannière info épurée -->
                            <c:if test="${not empty dmd and not empty dmd.commune}">
                                <div class="col-12">
                                    <div class="info-banner mb-0">
                                        <i class="bi bi-geo-alt-fill me-2"></i>
                                        Localisation actuelle : ${dmd.localisation}
                                    </div>
                                </div>
                            </c:if>
                            
                            <div class="col-12" style="margin-top: 8px;">
                                <label class="form-label" for="client">Client</label>
                                <select name="client" id="client" class="form-select" required>
                                    <option value="">Choisir un client</option>
                                    <c:forEach items="${listeClient}" var="item">
                                        <option value="${item.id}"
                                         <c:if
                                            test="${not empty dmd and not empty dmd.client and dmd.client.id == item.id}">
                                            selected</c:if>>
                                            ${item.nom} - ${item.contact}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label" for="commune">Commune</label>
                                <select name="commune" id="commune" class="form-select" required>
                                    <option value="">Choisir une commune</option>
                                    <c:forEach items="${listeCommune}" var="item">
                                        <option value="${item.id}" <c:if
                                            test="${not empty dmd and not empty dmd.commune and dmd.commune.id == item.id}">
                                            selected</c:if>>
                                            ${item.nom}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-6">
                                        <label for="date" class="form-label">Date</label>
                                        <input type="datetime-local" name="createAt" class="form-control" id="date">
                                    </div>
                            <div class="col-12">
                                <label class="form-label" for="reference">Reference</label>
                                <input type="text" name="reference" id="reference" class="form-control"
                                    value="${not empty dmd and not empty dmd.reference ? dmd.reference : ''}">
                            </div>

                            <div class="col-12 d-flex flex-column flex-sm-row gap-2 pt-3">
                                <button type="submit" class="btn btn-primary-custom">
                                    ${action}
                                </button>
                                <a class="btn btn-ghost" href="<c:url value='/' />">
                                    Retour
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>