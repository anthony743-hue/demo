package com.example.forage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.models.Demande;
import com.example.forage.models.Parametre;
import com.example.forage.models.Status;
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
    public ModelAndView getAddPage() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/add.jsp");
        mv.addObject("script", "std.js");
        List<Status> status = statusService.findAll();
        mv.addObject("listeStatus", status);
        return mv;
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> submitAdd(@RequestBody StatusDemande std) {
        Long duration = 0L;
        Demande d = dmdsService.findById(std.getDemande().getId());
        
        try {
            d.setStatus(std.getStatus());
            dmdsService.insert(d);
            duration = stdBeforeUpdate.getDiff(std);
            std.setDT(duration);
            stdserivce.insert(std);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.CREATED).body("Status demande cree avec succes");
    }

    @GetMapping("/update")
    public ModelAndView getModifPage() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/statusdmd/modif.jsp");
        mv.addObject("script", "std2.js");
        return mv;
    }

    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<?> submitModif(@RequestBody StatusDemande std) {
        try {
            List<StatusDemande> ls = stdserivce.getByDemande(std.getDemande());
            StatusDemande stdBeforeUpdate = stdserivce.findById(std.getId());
            if (stdBeforeUpdate.equals(std)) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body("Aucune modification n'a ete effectue");
            }

            if (!stdBeforeUpdate.getDaty().isEqual(std.getDaty())) {
                int idx = 0;
                StatusDemande nextStd = null, previousStd = null;
                for (int i = 0; i < ls.size(); i++) {
                    if (ls.get(i).getId() == std.getId()) {
                        idx = i;
                        break;
                    }
                }
                Long duration = 0L;
                if (idx > 0) {
                    previousStd = ls.get(idx - 1);
                    if (previousStd.getDaty().isBefore(std.getDaty())) {
                        duration = previousStd.getDiff(std);
                        std.setDT(duration);
                    }
                }
                if (idx < ls.size() - 1) {
                    nextStd = ls.get(idx + 1);
                    if (nextStd.getDaty().isAfter(std.getDaty())) {
                        duration = std.getDiff(nextStd);
                        nextStd.setDT(duration);
                        stdserivce.insert(previousStd);
                    }
                }
            }
            stdserivce.insert(std);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("ON a un probleme : " + e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.ACCEPTED).body("Status demande modifie avec succes");
    }

    @GetMapping("/byref")
    public ResponseEntity<?> getByRef(@RequestParam String ref) {
        List<StatusDemande> ls = null;
        Demande d = null;
        try {
            d = dmdsService.findByReference(ref);
            ls = stdserivce.getByDemande(d);
        } catch (Exception e) {
            return new ResponseEntity<>(e, HttpStatus.ACCEPTED);
        }
        return new ResponseEntity<>(ls, HttpStatus.CREATED);
    }

    public ModelAndView getAlertForDemande(@RequestParam String ref) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/demande/alert.jsp");

        List<Parametre> liste_param = paramService.getOrdered();
        Demande demande = dmdsService.findById(Integer.parseInt(ref));
        List<StatusDemande> list_status = stdserivce.getByDemande(demande);

        int i = 0, j1 = 0, j2 = 1, n = liste_param.size(), m = list_status.size();
        Parametre temp = null;
        StatusDemande std = null, std2 = null;
        Integer idxThen = 0, idxNow = 0;
        // for (i = 0; i < m - 1; i++) {
        //     std = list_status.get(i);
        //     if (j1 < n) {
        //         temp = liste_param.get(j1);
        //         if( temp.getStatus1().get ){

        //         }
        //         for (j2 = i + 1; j2 < m; j2++) {
        //             std2 = list_status.get(j2);
        //         }
        //         j1++;
        //     }
        // }
        // for(i=0; i < n; i++){
        // temp = liste_param.get(i);
        // idxThen = temp.getStatus1().getId();
        // idxNow = temp.getStatus2().getId();
        // while ( j1 < j2 && j2 < m ) {
        // std = list_status.get(j1);
        // std2 = list_status.get(j2);

        // if( std.getStatus().getId() != idxThen ){
        // j1++;
        // }
        // if( std2.getStatus().getId() != idxNow ){
        // j2++;
        // }
        // if( )
        // }
        // }
        // for(i=0; i < list_status.size(); i++){
        // idx = list_status.get(i).getStatus().getId();
        // temp = liste_param.get(j);
        // while ( j < n && temp.getStatus1().getId() == idx ) {

        // }
        // }

        List<Parametre> retour = new ArrayList<>();
        mv.addObject("liste_param", retour);
        return mv;
    }
}
