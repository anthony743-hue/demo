package com.example.forage.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.forage.entity.ApiResponse;
import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.DemandeService;
import com.example.forage.service.ParametreService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;

@Controller
@RequestMapping("/statusdmd")

public class StatusDemandeController {
    private StatusDemandeService stdserivce;

    private DemandeService dmdsService;

    private StatusService statusService;

    private ParametreService paramService;

    public StatusDemandeController(StatusDemandeService stdserivce, DemandeService dmdsService,
            StatusService statusService, ParametreService service) {
        this.stdserivce = stdserivce;
        this.dmdsService = dmdsService;
        this.statusService = statusService;
        this.paramService = service;
    }

    @GetMapping("/add")
    public ModelAndView getAddStatusDemandePage(@ModelAttribute("statusDemande") StatusDemande std) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/add.jsp");
        mv.addObject("listeStatus", statusService.findByDesignationContaining("Devis"));
        mv.addObject("listeDemande", dmdsService.getAll());
        return mv;
    }

    @PostMapping("/add")
    public String submitStatusDemande(@Validated StatusDemande std, BindingResult result,
            RedirectAttributes redirsAttrb) {
        if (result.hasErrors()) {
            redirsAttrb.addFlashAttribute("org.springframework.validation.BindingResult.statusDemande", result);
            redirsAttrb.addFlashAttribute("statusDemande", std);
            redirsAttrb.addFlashAttribute("errorMsg", "Veuillez corriger les erreurs ci-dessous.");
        } else {
            try {
                stdserivce.insert(std, dmdsService);
                redirsAttrb.addFlashAttribute("successMsg", "Insertion réussie avec succès");
            } catch (Exception e) {
                redirsAttrb.addFlashAttribute("errorMsg", "Erreur technique, veuillez réessayer plus tard." + e.getMessage());
                redirsAttrb.addFlashAttribute("statusDemande", std);
            }
        }
        return "redirect:/statusdmd/add";
    }

    @GetMapping("/update")
    public ModelAndView getModifPage() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/modif.jsp");
        mv.addObject("listeDemande", dmdsService.getAll());
        return mv;
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<?> addStatusDemande(@RequestBody StatusDemande std) {
        ApiResponse response = new ApiResponse();
        try {
            stdserivce.update(std);
            response.setMessage("mise a jour reussi");
            response.setSuccess(true);
        } catch (Exception e) {
            response.setData(std);
            response.setMessage(e.getMessage());
            response.setSuccess(false);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/byref")
    @ResponseBody
    public ResponseEntity<?> getListStatusByRef(String ref){
        ApiResponse response = new ApiResponse();
        Demande d = null;
        try {
            d = dmdsService.findByReference(ref);
            List<StatusDemande> listStatus = stdserivce.getByDemande(d);
            response.setData(listStatus);
            response.setMessage("Envoie Reussi");
            response.setSuccess(true);
        } catch (Exception e) {
            response.setData(ref);
            response.setMessage(e.getMessage());
            response.setSuccess(false);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }   
}
