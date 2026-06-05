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
import com.example.forage.service.ClientService;
import com.example.forage.service.DemandeService;
import com.example.forage.service.DevisService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;

import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/devis")
public class DevisController {
    private DevisService devisService;
    private DemandeService demandeService;
    private StatusService stService;
    private StatusDemandeService statusDemandeService;

    public DevisController(DevisService devisService, DemandeService demandeService,
            StatusService stService, StatusDemandeService std) {
        this.devisService = devisService;
        this.demandeService = demandeService;
        this.stService = stService;
        this.statusDemandeService = std;
    }

    @GetMapping("/form")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/devis/add.jsp");
        mv.addObject("script", "devis.js");
        return mv;
    }

    @PostMapping("/form")
    @ResponseBody
    public ResponseEntity<?> submitForm(@RequestBody Devis devis) {
        Integer demandeId = devis.getDmd().getId();
        if (demandeId == null) {
            return ResponseEntity.badRequest().body("ID de la demande manquant.");
        }

        Demande demande = demandeService.findById(demandeId);
        if (demande == null) {
            return ResponseEntity.badRequest().body("Demande introuvable pour l'ID " + demandeId);
        }

        StatusDemande stdBeforeUpdate = new Vector<>(statusDemandeService.getByDemande(demande)).lastElement();
        Map<String, Integer> mp = new HashMap<>();
        mp.put("DEC", 12);
        mp.put("DEA", 13);
        mp.put("DER", 14);
        mp.put("DFC", 15);
        mp.put("DFA", 16);
        mp.put("DFR", 17);

        try {
            List<DevisDetail> ls = devis.getDetails();
            for (DevisDetail d : ls) {
                d.setDevis(devis);
            }

            Status s = devis.getDmd().getStatus();
            if (!mp.containsKey(s.getDesignation())) {
                return ResponseEntity.badRequest().body("Status Inconnue : " + s.getDesignation());
            }
            Map<Integer, Status> map = stService.findAsMap();
            
            Status s1 = map.get(mp.get(s.getDesignation()));

            LocalDateTime ldt = LocalDateTime.now();

            // StatusDemande std = new StatusDemande();
            // std.setDaty(ldt);
            // std.setDemande(demande);
            // std.setStatus(s1);
            // std.setDT(stdBeforeUpdate.getDiff(std));

            devis.setDmd(demande);
            devis.setCreateAt(ldt.toLocalDate());
            
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
