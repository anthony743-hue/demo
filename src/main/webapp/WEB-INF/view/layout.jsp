<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Mon Application</title>
    <link rel="stylesheet" href="<c:url value='/assets/bootstrap/css/bootstrap.min.css' />">
    <style>
        :root {
            --sidebar-bg: #ffffff;
            --sidebar-text: #4b5563;
            --sidebar-hover-bg: #f3f4f6;
            --sidebar-active-bg: #eff6ff;
            --sidebar-active-text: #1d4ed8;
            --sidebar-accent: #3b82f6;
            --sidebar-border: #e5e7eb;
            --sidebar-width: 250px;
            --transition: 0.2s ease;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background-color: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            z-index: 1000;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
        }

        /* Logo / Titre */
        .sidebar-logo {
            padding: 1.5rem 1.5rem 1.25rem;
            font-weight: 700;
            font-size: 1.15rem;
            color: #111827;
            border-bottom: 1px solid var(--sidebar-border);
            margin: 0 1rem 0.5rem;
            letter-spacing: -0.02em;
        }

        /* Navigation principale */
        .sidebar-nav {
            list-style: none;
            padding: 0.5rem 0.75rem 0;
            margin: 0;
            flex: 1;
        }

        /* Bouton Accordéon principal */
        .accordion-group {
            margin-bottom: 2px;
        }

        .accordion-toggle {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            padding: 0.7rem 1rem;
            background: transparent;
            border: none;
            border-radius: 8px;
            color: var(--sidebar-text);
            font-size: 0.9rem;
            font-weight: 500;
            text-align: left;
            cursor: pointer;
            transition: background var(--transition), color var(--transition);
            letter-spacing: -0.01em;
        }

        .accordion-toggle:hover {
            background-color: var(--sidebar-hover-bg);
            color: #111827;
        }

        /* Flèche en CSS pur (remplace l'icône) */
        .collapse-arrow {
            width: 7px;
            height: 7px;
            border-right: 2px solid #9ca3af;
            border-bottom: 2px solid #9ca3af;
            transform: rotate(-45deg); /* Pointe vers la droite */
            transition: transform var(--transition), border-color var(--transition);
            flex-shrink: 0;
            margin-left: 8px;
        }

        .accordion-toggle:hover .collapse-arrow {
            border-color: #6b7280;
        }

        .accordion-toggle[aria-expanded="true"] .collapse-arrow {
            transform: rotate(45deg); /* Pointe vers le bas */
            border-color: var(--sidebar-accent);
        }

        /* Sous-menu */
        .accordion-submenu {
            list-style: none;
            padding: 0.25rem 0 0.5rem 0.75rem;
            margin: 0;
        }

        .accordion-submenu .nav-link {
            display: block;
            padding: 0.55rem 1rem;
            border-radius: 6px;
            color: var(--sidebar-text);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 400;
            transition: background var(--transition), color var(--transition);
            border-left: 3px solid transparent;
            margin-left: 6px; /* Décalage pour l'alignement visuel */
        }

        .accordion-submenu .nav-link:hover {
            background-color: var(--sidebar-hover-bg);
            color: #111827;
        }

        .accordion-submenu .nav-link.active {
            background-color: var(--sidebar-active-bg);
            color: var(--sidebar-active-text);
            font-weight: 500;
            border-left-color: var(--sidebar-accent);
        }

        /* Pied de page */
        .sidebar-footer {
            margin-top: auto;
            padding: 1.25rem 1.5rem;
            border-top: 1px solid var(--sidebar-border);
            font-size: 0.75rem;
            color: #9ca3af;
            text-align: center;
            letter-spacing: 0.01em;
        }

        /* Contenu principal */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 32px 40px;
            background: #f9fafb;
            min-height: 100vh;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .sidebar.open {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <aside class="sidebar">
        <div class="sidebar-logo">
            ForageApp
        </div>

        <!-- Navigation avec accordéons -->
        <ul class="sidebar-nav">
            <!-- Groupe Demandes -->
            <li class="accordion-group">
                <button class="accordion-toggle"
                        data-bs-toggle="collapse"
                        data-bs-target="#demandesMenu"
                        aria-expanded="${param.page == 'demandes' ? 'true' : 'false'}">
                    Demandes
                    <span class="collapse-arrow"></span>
                </button>
                <ul id="demandesMenu" class="accordion-submenu collapse ${param.page == 'demandes' ? 'show' : ''}">
                    <li>
                        <a href="<c:url value='/' />" class="nav-link ${param.subpage == 'gestion-demandes' ? 'active' : ''}">
                            Gestion de demandes
                        </a>
                    </li>
                </ul>
            </li>

            <!-- Groupe Devis -->
            <li class="accordion-group">
                <button class="accordion-toggle"
                        data-bs-toggle="collapse"
                        data-bs-target="#devisMenu"
                        aria-expanded="${param.page == 'devis' ? 'true' : 'false'}">
                    Devis
                    <span class="collapse-arrow"></span>
                </button>
                <ul id="devisMenu" class="accordion-submenu collapse ${param.page == 'devis' ? 'show' : ''}">
                    <li>
                        <a href="<c:url value='/devis/list' />" class="nav-link ${param.subpage == 'liste-devis' ? 'active' : ''}">
                            Gestion de devis
                        </a>
                    </li>
                </ul>
            </li>

            <!-- Groupe Statuts -->
            <li class="accordion-group">
                <button class="accordion-toggle"
                        data-bs-toggle="collapse"
                        data-bs-target="#statutsMenu"
                        aria-expanded="${param.page == 'statuts' ? 'true' : 'false'}">
                    Statuts
                    <span class="collapse-arrow"></span>
                </button>
                <ul id="statutsMenu" class="accordion-submenu collapse ${param.page == 'statuts' ? 'show' : ''}">
                    <li>
                        <a href="<c:url value='/statusdmd/add' />" class="nav-link ${param.subpage == 'ajout-statut' ? 'active' : ''}">
                            Ajout de statut
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/statusdmd/update' />" class="nav-link ${param.subpage == 'modif-statut' ? 'active' : ''}">
                            Modification de statut
                        </a>
                    </li>
                </ul>
            </li>
        </ul>

        <div class="sidebar-footer">
            &copy; 2026 ForageApp
        </div>
    </aside>

    <div class="main-content">
        <jsp:include page="${contentPage}" />
    </div>

    <script src="<c:url value='/assets/bootstrap/js/bootstrap.bundle.min.js' />"></script>
    <script src="<c:url value='/assets/bootstrap/js/script.js' />"></script>
</body>
</html>