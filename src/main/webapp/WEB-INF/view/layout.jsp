<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Mon Application</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
    <style>
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 230px;
            background-color: #f8f9fa;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
            padding-top: 20px;
        }
        .main-content {
            margin-left: 230px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Sidebar fixe -->
    <div class="sidebar">
        <h5 class="px-3">Menu</h5>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="<c:url value='/' />" class="nav-link">
                    <i class="bi bi-house"></i> Gestion de demandes
                </a>
            </li>
            <li class="nav-item">
                <a href="<c:url value='/devis/list' />" class="nav-link">
                    <i class="bi bi-person"></i> Gestion de devis
                </a>
            </li>
             <li class="nav-item">
                <a href="<c:url value='/statusdmd/add' />" class="nav-link">
                    <i class="bi bi-person"></i> Ajout de statusDemande
                </a>
            </li>
             <li class="nav-item">
                <a href="<c:url value='/statusdmd/update' />" class="nav-link">
                    <i class="bi bi-person"></i> Modification de statusDemande
                </a>
            </li>
        </ul>
    </div>

    <!-- Contenu dynamique -->
    <div class="main-content">
        <jsp:include page="${contentPage}" />
    </div>
        <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
        <script src="<c:url value='/assets/bootstrap/js/script.js' />"></script>
</body>
</html>