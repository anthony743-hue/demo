<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
    /* --- Styles spécifiques pour ce formulaire --- */
    .status-form-container .anthropic-card {
        background-color: #ffffff;
        border: 1px solid #e5e7eb;
        border-radius: 12px;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        overflow: hidden;
        margin-top: 24px;
    }
    
    .status-form-container .anthropic-card .card-header {
        border-bottom: 1px solid #f3f4f6;
        padding: 24px 28px;
        background-color: #ffffff;
    }

    .status-form-container .anthropic-card .card-body {
        padding: 28px;
    }

    .status-form-container h1 {
        color: #111827;
        font-weight: 600;
        font-size: 1.25rem;
        letter-spacing: -0.02em;
        margin: 0;
    }

    /* Alertes douces (remplace les couleurs vives de Bootstrap) */
    .status-form-container .alert-custom {
        border-radius: 8px;
        padding: 12px 16px;
        font-size: 0.875rem;
        font-weight: 450;
        border: 1px solid;
        margin-bottom: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .status-form-container .alert-custom-danger {
        background-color: #fef2f2;
        color: #991b1b;
        border-color: #fecaca;
    }
    .status-form-container .alert-custom-success {
        background-color: #f0fdf4;
        color: #166534;
        border-color: #bbf7d0;
    }
    .status-form-container .btn-close {
        padding: 0.5rem;
        opacity: 0.5;
    }

    /* Champs de formulaire */
    .status-form-container .form-label {
        color: #374151;
        font-weight: 500;
        font-size: 0.875rem;
        margin-bottom: 6px;
    }

    .status-form-container .form-control, 
    .status-form-container .form-select {
        border: 1px solid #d1d5db;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 0.9rem;
        color: #111827;
        transition: all 0.15s ease;
        background-color: #ffffff;
    }

    .status-form-container .form-control:focus, 
    .status-form-container .form-select:focus {
        border-color: #93c5fd;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        outline: none;
    }

    /* Bouton principal */
    .status-form-container .btn-primary-custom {
        background-color: #2563eb;
        border: none;
        border-radius: 8px;
        padding: 11px 20px;
        font-weight: 500;
        color: #ffffff;
        transition: background-color 0.15s ease;
        margin-top: 8px;
    }
    .status-form-container .btn-primary-custom:hover {
        background-color: #1d4ed8;
        color: #ffffff;
    }
</style>

<div class="container status-form-container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-xl-7">
            
            <!-- Messages flash globaux -->
            <c:if test="${not empty errorMsg}">
                <div class="alert alert-custom alert-custom-danger" role="alert">
                    <span>${errorMsg}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-custom alert-custom-success" role="alert">
                    <span>${successMsg}</span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card anthropic-card">
                <!-- En-tête de la carte -->
                <div class="card-header">
                    <h1>Nouveau statut de demande</h1>
                </div>
                
                <div class="card-body">
                    <form id="formAddStatusDmd" modelAttribute="statusDemande"
                               action="<c:url value='/statusdmd/add' />" method="post">
                        <div class="row g-3">
                            <!-- Champ demande -->
                            <div class="col-12">
                                <label for="ref" class="form-label">Référence de la demande</label>
                                <select name="demande.id" id="ref" class="form-select" required>
                                    <option value="">Choisir une demande...</option>
                                    <c:forEach items="${listeDemande}" var="item">
                                        <option value="${item.id}"
                                            ${not empty statusDemande and statusDemande.demande.id eq item.id ? 'selected' : ''}>
                                            ${item.reference}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Champ date -->
                            <div class="col-md-6">
                                <label for="date" class="form-label">Date</label>
                                <input type="datetime-local" name="daty" class="form-control" id="date"
                                       value="${not empty statusDemande and statusDemande.daty != null ? statusDemande.daty : ''}" />
                            </div>

                            <!-- Champ observation -->
                            <div class="col-md-6">
                                <label for="lieu" class="form-label">Observation</label>
                                <input type="text" name="observation" class="form-control" id="lieu"
                                       value="${not empty statusDemande and statusDemande.observation != null ? statusDemande.observation : ''}" />
                            </div>

                            <!-- Champ statut -->
                            <div class="col-md-6">
                                <label for="status" class="form-label">Statut</label>
                                <select name="status.id" id="status" class="form-select" required>
                                    <c:forEach items="${listeStatus}" var="item">
                                        <option value="${item.id}"
                                            ${not empty statusDemande and statusDemande.status.id eq item.id ? 'selected' : ''}>
                                            ${item.designation}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-12">
                                <button type="submit" class="btn btn-primary-custom w-100">Enregistrer le statut</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>