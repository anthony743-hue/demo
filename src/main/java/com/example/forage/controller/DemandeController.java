package com.example.forage.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.forage.models.Client;
import com.example.forage.models.Commune;
import com.example.forage.models.Demande;
import com.example.forage.models.Status;
import com.example.forage.models.StatusDemande;
import com.example.forage.service.ClientService;
import com.example.forage.service.CommuneService;
import com.example.forage.service.DemandeService;
import com.example.forage.service.StatusDemandeService;
import com.example.forage.service.StatusService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/demande")
public class DemandeController {
    private StatusDemandeService stdService;
    private StatusService statusService;
    private DemandeService dmdService;
    private CommuneService cmService;
    private ClientService clService;

    public DemandeController(StatusDemandeService stdService, StatusService statusService, DemandeService dmdService, CommuneService communeService, ClientService clientService) {
        this.stdService = stdService;
        this.statusService = statusService;
        this.dmdService = dmdService;
        this.cmService = communeService;
        this.clService = clientService;
    }

    @GetMapping("/add")
    public ModelAndView insertDemande(){
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/demande/insert.jsp");
        List<Status> lsStatus = statusService.findAll();
        List<Commune> lsCommunes = cmService.getAll();
        List<Client> lsClients = clService.findAll();

        mv.addObject("listeStatus", lsStatus);
        mv.addObject("listeCommune", lsCommunes);
        mv.addObject("listeClient", lsClients);
        mv.addObject("path", "add");
        mv.addObject("action", "Enregistrer la demande");
        return mv;
    }    
    
    @PostMapping("/add")
    public String saveDemande(Demande demande){
        StatusDemande std = new StatusDemande(demande, LocalDateTime.now());
        dmdService.insert(demande);
        stdService.insert(std);
        return "redirect:/demande/add";
    }

    @GetMapping("/update")
    public ModelAndView getMethodName(@RequestParam Integer id) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/demande/insert.jsp");
        List<Status> lsStatus = statusService.findAll();
        List<Commune> lsCommunes = cmService.getAll();
        List<Client> lsClients = clService.findAll();
        Demande d = dmdService.findById(id);

        mv.addObject("listeStatus", lsStatus);
        mv.addObject("listeCommune", lsCommunes);
        mv.addObject("listeClient", lsClients);
        mv.addObject("dmd", d);
        mv.addObject("path", "update");
        mv.addObject("action", "Modifier la demande");
        return mv;
    }

    @PostMapping("/update")
    public String postMethodName(Demande demande) {
        StatusDemande std = new StatusDemande(demande, LocalDateTime.now());

        Demande d0 = dmdService.findById(demande.getId());
        if( d0.getStatus().getId() != demande.getStatus().getId() ){
            stdService.insert(std);
        }
        dmdService.insert(demande);

        return "redirect:/demande/list";
    }
    
    @GetMapping("/list")
    public ModelAndView getList() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("contentPage", "/WEB-INF/view/demande/list.jsp");
        List<Demande> ls = dmdService.getAll();
        mv.addObject("listDemande", ls);
        return mv;
    }
    
    @GetMapping("/remove")
    public String remove(@RequestParam Integer id){
        return "redirect:/demande/list";
    }

    @GetMapping("/byref")
    public ResponseEntity<?> getByRef(@RequestParam String ref){
        Demande d = null;
        try {
            d = dmdService.findByReference(ref);
        } catch (Exception e) {
            return new ResponseEntity<>(e, HttpStatus.ACCEPTED);
        }
        return new ResponseEntity<>(d, HttpStatus.CREATED);
    }
}
