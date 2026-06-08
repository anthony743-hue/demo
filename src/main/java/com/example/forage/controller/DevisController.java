package com.example.forage.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.HashMap;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.example.forage.models.Demande;
import com.example.forage.models.Devis;
import com.example.forage.models.DevisDetail;
import com.example.forage.models.Status;
import com.example.forage.models.StatusDemande;
import com.example.forage.models.TypeDevis;
import com.example.forage.service.ClientService;
import com.example.forage.service.DemandeService;
import com.example.forage.service.DevisService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;
import com.example.forage.service.TypeDevisService;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/devis")
public class DevisController {
    private DevisService devisService;
    private DemandeService demandeService;
    private StatusService stService;
    private TypeDevisService typeDevisService;
    private StatusDemandeService statusDemandeService;

    public DevisController(DevisService devisService, DemandeService demandeService,
            StatusService stService, StatusDemandeService std, TypeDevisService typeDevisService) {
        this.devisService = devisService;
        this.demandeService = demandeService;
        this.stService = stService;
        this.statusDemandeService = std;
        this.typeDevisService = typeDevisService;
    }

    @GetMapping("/form")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/devis/add.jsp");
        mv.addObject("listeStatus", typeDevisService.findAll());
        mv.addObject("listeDemande", demandeService.getAll());
        return mv;
    }

    @PostMapping("/form")
    @ResponseBody
    public ResponseEntity<?> submitForm(@RequestBody Devis devis) {
        String ref = devis.getDmd().getReference();

        try {
            Demande demande = demandeService.findByReference(ref);
            if (demande == null) {
                return ResponseEntity.badRequest().body("Demande introuvable pour l'ID " + ref);
            }
            TypeDevis t = typeDevisService.findById(devis.getTypeDevis());
            // if (!mp.containsKey(t.getType())) {
            // return ResponseEntity.badRequest().body("Status Inconnue : " +
            // s.getDesignation());
            // }
            devis.setTypeDevis(t);
            Status st = stService.findDistinctBySigleLike("");

            List<DevisDetail> ls = devis.getDetails();
            for (DevisDetail d : ls) {
                d.setDevis(devis);
            }

            devis.setDmd(demande);
            devisService.insert(devis);
            // statusDemandeService.insert(std);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur rencontre " + e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.CREATED)
                .body("Devis créé avec l'ID " + devis.getId());
    }

    @GetMapping("/list")
    public ModelAndView getList() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/devis/list.jsp");
        mv.addObject("liste_devis", devisService.findAll());
        return mv;
    }

    @GetMapping("/detail")
    public ModelAndView getMethodName(@RequestParam String id) {
        ModelAndView mv = new ModelAndView("layout");
        Devis devis = devisService.findById(Long.parseLong(id));
        mv.addObject("liste_detail", devis.getDetails());
        mv.addObject("contentPage", "/WEB-INF/view/devis/detail.jsp");
        return mv;
    }

}
