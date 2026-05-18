package com.example.forage.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.models.Client;
import com.example.forage.models.Demande;
import com.example.forage.models.Devis;
import com.example.forage.models.DevisDetail;
import com.example.forage.service.ClientService;
import com.example.forage.service.DemandeService;
import com.example.forage.service.DevisService;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/devis")
public class DevisController {
    private ClientService clientService;
    private DevisService devisService;
    private DemandeService demandeService;

    public DevisController(ClientService clService, DevisService devisService, DemandeService demandeService) {
        this.clientService = clService;
        this.devisService = devisService;
        this.demandeService = demandeService;
    }

    @GetMapping("/form")
    public ModelAndView showForm() {
        ModelAndView model = new ModelAndView("devis/add");
        return model;
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

        devis.setDmd(demande);
        devis.setCreateAt(LocalDate.now());

        if (devis.getDetails() != null) {
            // for (DevisDetail detail : devis.getDetails()) {
            //     devis.addDetail(detail); 
            // }
        }

        devisService.insert(devis);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body("Devis créé avec l'ID " + devis.getId());
    }

    @GetMapping("/list")
    public ModelAndView getList(){
        ModelAndView mv = new ModelAndView("devis/list");
        List<Devis> ls = devisService.findAll();
        mv.addObject("liste_devis", ls);
        return mv;
    }

    @GetMapping("/detail")
    public String getMethodName(@RequestParam String param) {
        return new String();
    }
    
}
